import 'package:flutter/material.dart';

import 'package:get/get.dart';

import './home.dart';
import './add_item_page.dart';
import './settings.dart';

import '../common/services/theme_services.dart';
import '../common/utils/colors.dart';

import '../controllers/item_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _itemController = Get.put(ItemController());

  @override
  void initState() {
    super.initState();
    _itemController.getItem();
  }

  final navScreens = [
    const Home(),
    const Settings(),
    const AddItem(),
  ];

  bool isAscendSort = true;
  int currScreenIndx = 0;
  bool isOnAddPage = false;

  _setIsOnAddPage(bool value) {
    setState(
      () {
        isOnAddPage = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    bool showFab = MediaQuery.of(context).viewInsets.bottom == 0;

    return Scaffold(
      appBar: _appBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: showFab == false ? null : _floatingActionButton(),
      bottomNavigationBar: _bottomNavBar(),
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
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(
          color: context.isDarkMode ? Colors.grey[800] : Colors.grey[200],
          height: 1,
        ),
      ),
    );
  }

  _floatingActionButton() {
    return GestureDetector(
      onTap: () => _setIsOnAddPage(true),
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

  _bottomNavBar() {
    return BottomNavigationBar(
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
        setState(() {
          currScreenIndx = index;
        });
        _setIsOnAddPage(false);
      },
      currentIndex: currScreenIndx,
    );
  }
}
