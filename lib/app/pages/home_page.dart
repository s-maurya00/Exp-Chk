import 'package:expchk/app/common/widgets/fab.dart';
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

  _setIsOnAddPage() {
    setState(
      () {
        isOnAddPage = true;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    bool showFab = MediaQuery.of(context).viewInsets.bottom == 0;

    return Scaffold(
      appBar: _appBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: showFab == false
          ? null
          : FAB(isOnAddPage: isOnAddPage, setIsOnAddPage: _setIsOnAddPage),
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
