import 'dart:io';

import 'package:flutter/material.dart';

import 'package:camera/camera.dart';

import 'package:expchk/app/common/widgets/camera_bottom_bar.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController _controller;

  bool _isCameraReady = false;
  bool _isCapturing = false;
  bool _isFlashOn = false;

  // // For Focusing
  // Offset _focusPoint = Offset(0, 0);

  // // For Zoom
  // double _currentZoom = 1.0;

  // // For Capturing
  // String _capturedImagePath = '';
  // File? _capturedImage;

  @override
  void initState() {
    super.initState();

    initCamera();
  }

  void initCamera() async {
    final cameras = await availableCameras();

    _controller = CameraController(
      cameras.first,
      ResolutionPreset.high,
      enableAudio: false,
    );

    await _controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {
        _isCameraReady = true;
      });
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case "CameraAccessDenied":
            debugPrint("Camera access denied");
            break;
          default:
            debugPrint("Camera error: ${e.description}");
            break;
        }
      }
    });
    // setState(
    //   () {
    //     _isCameraReady = true;
    //   },
    // );
  }

  void setIsCapturing(bool value) {
    setState(() {
      _isCapturing = value;
    });
  }

  void setFlashOn(bool value) {
    setState(() {
      _isFlashOn = value;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isCameraReady
          ? Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Positioned.fill(
                  child: CameraPreview(_controller),
                ),
                Positioned(
                  top: 0,
                  child: Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.5),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    height: 150,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(0.75),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: kToolbarHeight,
                  left: 15,
                  child: CircleAvatar(
                    backgroundColor: Colors.black.withOpacity(0.4),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: (MediaQuery.of(context).size.height / 2) - 150,
                  child: Container(
                    height: 300,
                    width: 300,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    // child: const Column(
                    //   children: [
                    //     Expanded(
                    //       child: Row(
                    //         children: [
                    //           Text("data"),
                    //           Spacer(),
                    //           Text("data"),
                    //         ],
                    //       ),
                    //     ),
                    //     Expanded(
                    //       child: Row(
                    //         children: [
                    //           Text("data"),
                    //           Spacer(),
                    //           Text("data"),
                    //         ],
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ),
                ),
                CameraBottomBar(
                  controller: _controller,
                  setIsCapturing: setIsCapturing,
                  setIsFlashOn: setFlashOn,
                  isFlashOn: _isFlashOn,
                  isCapturing: _isCapturing,
                ),
              ],
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
