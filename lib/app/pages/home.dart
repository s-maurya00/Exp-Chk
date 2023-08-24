import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../common/widgets/item_tile.dart';
import '../common/utils/theme.dart';

import '../controllers/item_controller.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _itemController = Get.find<ItemController>();
  bool isAscendSort = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 13,
          ),
          child: Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              Text(
                "All Items",
                style: headingStyle,
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
        ),
        _showItems(),
      ],
    );
  }

  _showItems() {
    return Expanded(
      child: Obx(
        () {
          print("length: ${_itemController.itemList.length}");
          if (_itemController.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (_itemController.itemList.isEmpty) {
            return const Center(
              child: Text("There are no items to show"),
            );
          } else {
            return ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: _itemController.itemList.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    index == 0
                        ? const SizedBox(
                            height: 20,
                          )
                        : Container(),
                    ItemTile(
                      item: _itemController.itemList[
                          _itemController.itemList.length - 1 - index],
                          handleOnTap: _handleItemDelete,
                    ),
                    index == _itemController.itemList.length - 1
                        ? const SizedBox(
                            height: 20,
                          )
                        : Container(),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }

  _handleItemDelete(int id) {
    _itemController.removeItem(id);
  }
}
