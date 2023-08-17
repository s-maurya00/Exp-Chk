import 'package:expchk/app/common/utils/colors.dart';
import 'package:expchk/app/pages/add_items.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:expchk/app/common/widgets/item_tile.dart';
import 'package:expchk/app/pages/settings.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final navScreens = [
    const HomePage(),
    const Settings(),
  ];

  bool isAscendSort = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      floatingActionButton: GestureDetector(
        onTap: () {
          Get.to(const AddItems());
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
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
            ),
            activeIcon: Icon(
              Icons.home_rounded,
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
            Get.to(
              () => navScreens[index],
            );
          });
        },
      ),
      body: Column(
        children: [
          Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              const Text(
                "All Items",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  print("Sort");
                },
                child: const Icon(
                  Icons.sort_rounded,
                  size: 28,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              GestureDetector(
                onTap: () {
                  setState(
                    () {
                      isAscendSort = !isAscendSort;
                    },
                  );
                },
                child: Icon(
                  isAscendSort
                      ? Icons.arrow_downward_rounded
                      : Icons.arrow_upward_rounded,
                  size: 28,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
            ],
          ),
          _showItems(),
        ],
      ),
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
              Icons.settings_outlined,
            ),
          ),
          onTap: () {
            Get.to(
              () => const Settings(),
              transition: Transition.zoom,
            );
            print("Profile");
          },
        ),
        const SizedBox(
          width: 15,
        ),
      ],
    );
  }

  _showItems() {
    return Expanded(
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ItemTile();
        },
      ),
    );
  }
}
