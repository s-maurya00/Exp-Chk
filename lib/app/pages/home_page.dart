import 'package:expchk/app/pages/home.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:expchk/app/common/utils/colors.dart';
import 'package:expchk/app/pages/settings.dart';
// import 'package:expchk/app/pages/add_items.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final navScreens = [
    const Home(),
    const Settings(),
  ];

  bool isAscendSort = true;
  int currScreenIndx = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      floatingActionButton: GestureDetector(
        onTap: () {
          // Get.to(const AddItems());
          print("add tapped");
        },
        child: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            color: primaryClrLight,
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                color: primaryClrDark.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 15,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: const Icon(
            Icons.add,
            color: primaryClrDark,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: primaryClr,
        selectedItemColor: secondaryClr,
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
            },
          );
        },
      ),
      body: navScreens[currScreenIndx],
    );
  }

  _appBar() {
    return AppBar(
      title: const Text(
        "ExpChk",
      ),
      scrolledUnderElevation: 0,
      actions: [
        GestureDetector(
          child: const CircleAvatar(
            child: Icon(
              Icons.person_outline_rounded,
            ),
          ),
          onTap: () {
            // Get.to(
            //   () => const Settings(),
            //   transition: Transition.zoom,
            // );
            print("Profile");
          },
        ),
        const SizedBox(
          width: 15,
        ),
      ],
    );
  }
}
