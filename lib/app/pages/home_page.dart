import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:expchk/app/pages/home.dart';
import 'package:expchk/app/pages/add_item_page.dart';
import 'package:expchk/app/pages/settings.dart';

import 'package:expchk/app/common/services/theme_services.dart';
import 'package:expchk/app/common/utils/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final navScreens = [
    const Home(),
    const Settings(),
    const AddItem(),
  ];

  bool isAscendSort = true;
  int currScreenIndx = 0;
  bool isOnAddPage = false;

  @override
  Widget build(BuildContext context) {
    bool showFab = MediaQuery.of(context).viewInsets.bottom == 0;

    return Scaffold(
      appBar: _appBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: showFab == false
          ? null
          : GestureDetector(
              onTap: () {
                setState(
                  () {
                    isOnAddPage = true;
                  },
                );
              },
              child: Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      isOnAddPage
                          ? (Get.isDarkMode
                              ? secondaryClrDark
                              : secondaryClrLight)
                          : (Get.isDarkMode ? primaryClrDark : primaryClrLight),
                      isOnAddPage
                          ? (Get.isDarkMode
                              ? secondaryClrLight
                              : secondaryClrDark)
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
            ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: primaryClr,
        selectedItemColor: isOnAddPage ? primaryClr : secondaryClr,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings_outlined,
            ),
            label: "Settings",
          ),
        ],
        onTap: (index) {
          setState(
            () {
              currScreenIndx = index;
              isOnAddPage = false;
            },
          );
        },
        currentIndex: currScreenIndx,
      ),
      body: navScreens[isOnAddPage == false ? currScreenIndx : 2],
    );
  }

  _appBar() {
    return AppBar(
      title: const Text(
        "ExpChk",
      ),
      scrolledUnderElevation: 0,
      backgroundColor: context.theme.appBarTheme.backgroundColor,
      actions: [
        GestureDetector(
          child: Get.isDarkMode
              ? const Icon(
                  Icons.wb_sunny_outlined,
                )
              : const Icon(
                  Icons.nightlight_round_rounded,
                ),
          onTap: () {
            ThemeController().switchTheme();
          },
        ),
        const SizedBox(
          width: 15,
        ),
      ],
    );
  }
}
