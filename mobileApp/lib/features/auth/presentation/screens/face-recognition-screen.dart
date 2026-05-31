import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';

// Global variable to hold camera list (may be null if initialization fails)
List<CameraDescription>? cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Attempt to get cameras, but don't crash if it fails – the screen will retry
  try {
    cameras = await availableCameras();
  } catch (e) {
    debugPrint('Failed to get cameras at startup: $e');
  }
  runApp(const FaceRecognitionScreen());
}

class FaceRecognitionScreen extends StatefulWidget {
  const FaceRecognitionScreen({super.key});

  @override
  State<FaceRecognitionScreen> createState() => _FaceRecognitionScreenState();
}

class _FaceRecognitionScreenState extends State<FaceRecognitionScreen>
    with WidgetsBindingObserver {
  CameraController? _cameraController;
  bool _isCameraReady = false;
  bool _isCameraInitializing = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initCamera(); // Start camera initialization
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // Re-initialize camera when app returns to foreground
      _initCamera();
    } else if (state == AppLifecycleState.paused) {
      _cameraController?.dispose();
    }
  }

  /// Initializes the camera: checks availability, requests permission, sets up controller.
  Future<void> _initCamera() async {
    // Reset states
    setState(() {
      _isCameraInitializing = true;
      _isCameraReady = false;
      _errorMessage = null;
    });

    // 1. Ensure we have a camera list – retry if necessary
    if (cameras == null || cameras!.isEmpty) {
      try {
        cameras = await availableCameras();
      } catch (e) {
        setState(() {
          _errorMessage =
          'No camera detected on this device.\nPlease use an alternative verification method.\n\nError: ${e.toString().split('\n').first}';
          _isCameraInitializing = false;
        });
        return;
      }
      if (cameras!.isEmpty) {
        setState(() {
          _errorMessage =
          'No camera detected on this device.\nPlease use an alternative verification method.';
          _isCameraInitializing = false;
        });
        return;
      }
    }

    // 2. Request camera permission
    final status = await Permission.camera.request();
    if (status != PermissionStatus.granted) {
      setState(() {
        _errorMessage =
        'Camera permission is required for face verification.\nPlease grant permission in settings.';
        _isCameraInitializing = false;
      });
      return;
    }

    // 3. Select front camera if available, otherwise use first camera
    CameraDescription selectedCamera;
    try {
      selectedCamera = cameras!.firstWhere(
            (camera) => camera.lensDirection == CameraLensDirection.front,
        orElse: () => cameras!.first,
      );
    } catch (e) {
      selectedCamera = cameras!.first;
    }

    // 4. Create and initialize camera controller
    _cameraController = CameraController(
      selectedCamera,
      ResolutionPreset.medium,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.yuv420,
    );

    try {
      await _cameraController!.initialize();
      if (!mounted) return;
      setState(() {
        _isCameraReady = true;
        _isCameraInitializing = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage =
        'Failed to start camera: ${e.toString().split('\n').first}\nTry restarting the app or use another method.';
        _isCameraInitializing = false;
      });
    }
  }

  /// User taps "Continue" – here you would integrate actual face recognition logic.
  void _onContinuePressed() {
    if (_errorMessage != null || !_isCameraReady) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Camera not available. Please use alternative verification.'),
          backgroundColor: Color(0xFF93000A),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } else {
      HapticFeedback.lightImpact();
      // Placeholder for real verification
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Identity verification in progress...'),
          backgroundColor: Color(0xFF1F1F21),
          behavior: SnackBarBehavior.floating,
        ),
      );
      // You would call your face recognition method here
    }
  }

  void _onTryAnotherWay() {
    HapticFeedback.selectionClick();
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1F1F21),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Alternative Verification',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildAlternativeOption(Icons.fingerprint, 'Use Fingerprint'),
            const SizedBox(height: 12),
            _buildAlternativeOption(Icons.pin, 'Enter Emergency PIN'),
            const SizedBox(height: 12),
            _buildAlternativeOption(Icons.document_scanner, 'Scan ID Document'),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildAlternativeOption(IconData icon, String label) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFFFFBC7C)),
      title: Text(label),
      onTap: () {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$label selected (demo)')),
        );
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      tileColor: const Color(0xFF2A2A2C),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final circleSize = screenWidth > 480 ? 300.0 : 280.0;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF131315),
        colorScheme: const ColorScheme.dark(
          background: Color(0xFF131315),
          surface: Color(0xFF131315),
          primary: Color(0xFFFFB4AA),
          secondary: Color(0xFFFFBC7C),
          tertiary: Color(0xFFADC6FF),
          error: Color(0xFFFFB4AB),
          onBackground: Color(0xFFE4E2E4),
          onSurface: Color(0xFFE4E2E4),
          onPrimary: Color(0xFF690003),
          onSecondary: Color(0xFF4B2800),
          surfaceVariant: Color(0xFF353437),
          outline: Color(0xFFAD8883),
        ),
        fontFamily: 'Inter',
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontFamily: 'Inter', fontSize: 16),
          bodyLarge: TextStyle(fontFamily: 'Inter', fontSize: 18, fontWeight: FontWeight.w500),
          headlineMedium: TextStyle(fontFamily: 'Montserrat', fontSize: 24, fontWeight: FontWeight.w700),
          headlineLarge: TextStyle(fontFamily: 'Montserrat', fontSize: 32, fontWeight: FontWeight.w700),
          labelMedium: TextStyle(fontFamily: 'Inter', fontSize: 14, fontWeight: FontWeight.w700, letterSpacing: 0.05),
        ),
        useMaterial3: true,
      ),
      home: Scaffold(
        backgroundColor: const Color(0xFF131315),
        body: SafeArea(
          child: Column(
            children: [
              _buildTopAppBar(),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 24),
                        // Camera preview or error/loading UI
                        _buildCameraPreview(circleSize),
                        const SizedBox(height: 32),
                        _buildContentText(),
                        const SizedBox(height: 32),
                        _buildTryAnotherWay(),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ),
              _buildBottomButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopAppBar() {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.7),
        border: Border(
          bottom: BorderSide(color: const Color(0xFF5D3F3B).withOpacity(0.1)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFFE4E2E4)),
            onPressed: () => Navigator.pop(context),
            style: IconButton.styleFrom(foregroundColor: Colors.white70),
          ),
          const Text(
            'Identity Verification',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Color(0xFFE4E2E4),
              letterSpacing: 0.15,
            ),
          ),
          TextButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: const Color(0xFF1F1F21),
                  title: const Text('Help & Support'),
                  content: const Text(
                    'Position your face inside the circular frame. Ensure good lighting and remove any obstructions.',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Got it'),
                    ),
                  ],
                ),
              );
            },
            child: const Text(
              'Help',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.05,
                color: Color(0xFFFFB4AA),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCameraPreview(double size) {
    // Error state
    if (_errorMessage != null) {
      return Center(
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFF1F1F21),
            border: Border.all(color: const Color(0xFFFFB4AB).withOpacity(0.5), width: 2),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                _errorMessage!.contains('permission') ? Icons.lock : Icons.videocam_off,
                size: 48,
                color: const Color(0xFFFFB4AB),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  _errorMessage!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFFFFB4AB),
                    fontSize: 14,
                    height: 1.3,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              if (_errorMessage!.contains('permission'))
                ElevatedButton(
                  onPressed: () {
                    openAppSettings();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFBC7C),
                    foregroundColor: const Color(0xFF4B2800),
                  ),
                  child: const Text('Open Settings'),
                )
              else
                ElevatedButton(
                  onPressed: _initCamera,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFBC7C),
                    foregroundColor: const Color(0xFF4B2800),
                  ),
                  child: const Text('Retry'),
                ),
            ],
          ),
        ),
      );
    }

    // Loading state
    if (_isCameraInitializing) {
      return Center(
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFF1F1F21),
          ),
          child: const Center(
            child: CircularProgressIndicator(
              color: Color(0xFFFFBC7C),
            ),
          ),
        ),
      );
    }

    // Camera ready – show live preview inside a circle with overlays
    if (_isCameraReady && _cameraController != null) {
      return SizedBox(
        width: size,
        height: size,
        child: ClipOval(
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Camera preview fitted to fill the circle without distortion
              FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: _cameraController!.value.previewSize?.width ?? size,
                  height: _cameraController!.value.previewSize?.height ?? size,
                  child: CameraPreview(_cameraController!),
                ),
              ),
              // Subtle border
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white.withOpacity(0.3), width: 2),
                  borderRadius: BorderRadius.circular(size / 2),
                ),
              ),
              // Gradient overlay for depth
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      const Color(0xFFFFBC7C).withOpacity(0.08),
                      Colors.transparent,
                    ],
                  ),
                  shape: BoxShape.circle,
                ),
              ),
              // Digital grid overlay
              CustomPaint(
                painter: DigitalGridPainter(),
              ),
              // Scanning line animation (static for demo)
              Positioned(
                left: 0,
                right: 0,
                top: size * 0.3,
                child: Container(
                  height: 2,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.transparent, Color(0xFFFF9400), Colors.transparent],
                    ),
                  ),
                ),
              ),
              // "SCANNING" badge
              Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF9400),
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 8),
                      ],
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.videocam, size: 16, color: Color(0xFF633700)),
                        SizedBox(width: 6),
                        Text(
                          'SCANNING...',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.05,
                            color: Color(0xFF633700),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    // Fallback (should not happen)
    return const SizedBox.shrink();
  }

  Widget _buildContentText() {
    if (_errorMessage != null) {
      return Column(
        children: [
          const Text(
            'Camera Unavailable',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Color(0xFFFFB4AB),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Please use an alternative verification method below.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              height: 1.4,
              color: const Color(0xFFE4E2E4).withOpacity(0.7),
            ),
          ),
        ],
      );
    }

    return Column(
      children: const [
        Text(
          'Verify Identity',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: Color(0xFFE7BDB7),
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Position your face within the frame to securely unlock your emergency profile.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15,
            height: 1.4,
            color: Color(0xFFE4E2E4),
          ),
        ),
      ],
    );
  }

  Widget _buildTryAnotherWay() {
    return TextButton(
      onPressed: _onTryAnotherWay,
      child: const Text(
        'Try another way',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.05,
          decoration: TextDecoration.underline,
          decorationColor: Color(0xFF5D3F3B),
          decorationThickness: 1.2,
          color: Color(0xFFE4E2E4),
        ),
      ),
    );
  }

  Widget _buildBottomButton() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFF131315).withOpacity(0),
            const Color(0xFF131315),
          ],
        ),
      ),
      child: GestureDetector(
        onTap: _onContinuePressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          height: 56,
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F21),
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(color: Color(0xFF0A0A0B), offset: Offset(4, 4), blurRadius: 10),
              BoxShadow(color: Color(0xFF2E2E31), offset: Offset(-4, -4), blurRadius: 10),
            ],
          ),
          child: const Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Continue',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFE4E2E4),
                  ),
                ),
                SizedBox(width: 8),
                Icon(Icons.arrow_forward, color: Color(0xFFE4E2E4), size: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Draws a subtle dot grid overlay on the camera preview.
class DigitalGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFAD8883).withOpacity(0.25)
      ..style = PaintingStyle.fill;
    const spacing = 20.0;
    const dotRadius = 1.2;
    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), dotRadius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}