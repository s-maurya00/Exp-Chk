import 'package:flutter/material.dart';

import 'package:get/get.dart';

import './home.dart';
import './add_item_page.dart';
import './settings.dart';

import '../common/services/theme_services.dart';
import '../common/utils/colors.dart';

import '../controllers/item_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _itemController = Get.put(ItemController());
  // the line final _itemController = Get.put(ItemController()); does the following:
  // 1. Creates an instance of ItemController
  // 2. Makes it available to all the child widgets of Home
  // here, we use get.put() cause we want to create a new instance of ItemController which can be used by all the child widgets of Home. If we do final _itemController = ItemController(); then we will not be able to use it in the child widgets of Home.

  // 3. to access this particular instance of ItemController in any other file, we can use Get.find<ItemController>() or Get.put<ItemController>() or Get.find() or Get.put(). example:
  // final _itemController = Get.find<ItemController>();

  // 4. to access it in child widgets of Home, we can use Get.find<ItemController>() or Get.put<ItemController>() or Get.find() or Get.put(). example:
  // final _itemController = Get.find<ItemController>();

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
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(
          color: context.isDarkMode ? Colors.grey[800] : Colors.grey[200],
          height: 1,
        ),
      ),
    );
  }
}
