import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../utils/colors.dart';

class FAB extends StatelessWidget {
  const FAB({
    Key? key,
    required this.isOnAddPage,
    required this.setIsOnAddPage,
  }) : super(key: key);

  final bool isOnAddPage;
  final Function setIsOnAddPage;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setIsOnAddPage(),
      child: Container(
        height: 70,
        width: 70,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              isOnAddPage
                  ? (Get.isDarkMode ? secondaryClrDark : secondaryClrLight)
                  : (Get.isDarkMode ? primaryClrDark : primaryClrLight),
              isOnAddPage
                  ? (Get.isDarkMode ? secondaryClrLight : secondaryClrDark)
                  : (Get.isDarkMode ? primaryClrLight : primaryClrDark),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: isOnAddPage
                  ? (Get.isDarkMode
                      ? secondaryClr.withOpacity(0.5)
                      : secondaryClrDark.withOpacity(0.5))
                  : (Get.isDarkMode
                      ? primaryClr.withOpacity(0.5)
                      : primaryClrDark.withOpacity(0.5)),
              spreadRadius: 1,
              blurRadius: 15,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Icon(
          Icons.add,
          color: isOnAddPage ? secondaryClrLight : primaryClrLight,
        ),
      ),
    );
  }
}
