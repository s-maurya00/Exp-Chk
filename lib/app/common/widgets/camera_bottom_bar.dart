import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:camera/camera.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as path_provider;

import 'package:expchk/app/pages/image_preview.dart';

class CameraBottomBar extends StatelessWidget {
  const CameraBottomBar({
    required this.controller,
    required this.setIsCapturing,
    required this.setIsFlashOn,
    required this.isFlashOn,
    required this.isCapturing,
    super.key,
  });

  final bool isFlashOn;
  final bool isCapturing;
  final CameraController controller;
  final Function(bool) setIsCapturing;
  final Function(bool) setIsFlashOn;

  // static const MethodChannel _channel = MethodChannel('camera_image_saver');

  // static final List<String> imageFormats = [
  //   'jpg',
  //   'jpeg',
  //   'png',
  //   'gif',
  //   'webp',
  //   'bmp',
  //   'wbmp',
  //   'heic',
  //   'heif',
  // ];

  // static bool _isImage(String path) {
  //   bool output = false;

  //   imageFormats.forEach(
  //     (imageFormat) {
  //       if (path.toLowerCase().contains(imageFormat)) {
  //         output = true;
  //       }
  //     },
  //   );
  //   return output;
  // }

  // static Future<bool?> _saveImage(
  //   String path, {
  //   bool toDCIM = false,
  // }) async {
  //   File? tempFile;

  //   if (path.isEmpty) {
  //     throw ArgumentError("Please provide a valid file path");
  //   }
  //   if (!_isImage(path)) {
  //     throw ArgumentError("File on path is not an image");
  //   }

  //   bool? result = await _channel.invokeMethod(
  //     'saveImage',
  //     <String, dynamic>{
  //       'path': path,
  //       'toDCIM': toDCIM,
  //       'albumName': toDCIM ? 'DCIM' : 'Pictures',
  //     },
  //   );
  //   if (tempFile != null) {
  //     tempFile.delete();
  //   }
  //   return result;
  // }

  void _capturedImage(BuildContext context) async {
    if (isCapturing) {
      debugPrint("Already taking picture (isCapturing is true))");
      return null;
    }
    if (!controller.value.isInitialized) {
      debugPrint("controller.value.isInitialized is false");
      return null;
    }
    if (controller.value.isTakingPicture) {
      debugPrint("controller.value.isTakingPicture is true");
      return null;
    }

    // final Directory appDir =
    //     await path_provider.getApplicationSupportDirectory();

    // final String fileName = path.join(appDir.path, '${DateTime.now()}.jpg');

    setIsCapturing(true);

    try {
      debugPrint("isFlashOn: $isFlashOn");
      await controller
          .setFlashMode(isFlashOn ? FlashMode.torch : FlashMode.off);
      XFile picture = await controller.takePicture();

      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => ImagePreview(
      //       file: picture,
      //     ),
      //   ),
      // );

      debugPrint("picture.path: ${picture.path}");

      await Get.to(ImagePreview(
        file: picture,
      ));

      // String imagePath = picture.path;

      // await _saveImage(imagePath);
      // debugPrint("Photo captured and saved to gallery");
    } on CameraException catch (e) {
      debugPrint("Error occured while capturing image: $e");
      return null;
    } finally {
      setIsCapturing(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 50,
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          const Expanded(
            child: Icon(
              Icons.photo_library_outlined,
            ),
          ),
          GestureDetector(
            onTap: () {
              _capturedImage(context);
              debugPrint("Capture Image tapped");
            },
            child: Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.grey[300]!,
                        width: 5,
                        style: BorderStyle.solid,
                      ),
                      borderRadius: BorderRadius.circular(35),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setIsFlashOn(!isFlashOn);
              },
              child: isFlashOn
                  ? const Icon(
                      Icons.flash_on,
                      size: 30,
                    )
                  : const Icon(
                      Icons.flash_off,
                      size: 30,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
