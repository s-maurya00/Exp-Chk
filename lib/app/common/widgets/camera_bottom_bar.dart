import 'package:flutter/material.dart';

class CameraBottomBar extends StatelessWidget {
  const CameraBottomBar({required this.isFlashOn, super.key});

  final bool isFlashOn;

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
            child: isFlashOn
                ? const Icon(
                    Icons.flash_on_rounded,
                    size: 30,
                  )
                : const Icon(
                    Icons.flash_off_rounded,
                    size: 30,
                  ),
          ),
        ],
      ),
    );
  }
}
