import 'dart:io';

import 'package:flutter/material.dart';

import 'package:camera/camera.dart';

class ImagePreview extends StatefulWidget {
  const ImagePreview({Key? key, this.file}) : super(key: key);

  final XFile? file;

  @override
  State<ImagePreview> createState() => _ImagePreviewState();
}

class _ImagePreviewState extends State<ImagePreview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Image preview")),
      body: Center(
        child: Image.file(
          File(widget.file!.path),
        ),
      ),
    );
  }
}
