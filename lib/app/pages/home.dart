import 'package:expchk/app/common/utils/colors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../common/widgets/item_tile.dart';
import '../common/utils/theme.dart';

import '../controllers/item_controller.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

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
          if (_itemController.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (_itemController.itemList.isEmpty) {
            return const Center(
              child: Text("There are no items to show"),
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (_itemController.selectedItemIds.isNotEmpty)
                  _showSelectedItemsHeader(),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: _itemController.itemList.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          if (index == 0)
                            const SizedBox(
                              height: 20,
                            ),
                          ItemTile(
                            item: _itemController.itemList[
                                _itemController.itemList.length - 1 - index],
                            onItemTap: () {
                              _itemController.toggleSelectedItem(
                                _itemController
                                    .itemList[_itemController.itemList.length -
                                        1 -
                                        index]
                                    .id!,
                              );
                            },
                            isItemSelected:
                                _itemController.selectedItemIds.contains(
                              _itemController
                                  .itemList[_itemController.itemList.length -
                                      1 -
                                      index]
                                  .id!,
                            ),
                          ),
                          if (index == _itemController.itemList.length - 1)
                            const SizedBox(
                              height: 40,
                            ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  _showSelectedItemsHeader() {
    return Container(
      color: context.isDarkMode ? primaryClrDark : primaryClrLight,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            const SizedBox(
              width: 20,
            ),
            Text(
              "${_itemController.selectedItemIds.length} items selected",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                _deleteSelectedItems();
              },
              child: const Icon(
                Icons.delete_rounded,
                size: 28,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
          ],
        ),
      ),
    );
  }

  _deleteSelectedItems() {
    _itemController.removeItemList(_itemController.selectedItemIds);
    _itemController.selectedItemIds.clear();
  }
}
