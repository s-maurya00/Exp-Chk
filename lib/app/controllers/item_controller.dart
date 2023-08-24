import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../database/db_helper.dart';
import '../models/item.dart';

class ItemController extends GetxController {
  List<Item> itemList = <Item>[].obs;
  RxBool isLoading = true.obs;
  int lastFetchedIndex = -1;

  @override
  void onReady() {
    getItem();
    super.onReady();
  }

  Future<int> addItem({Item? item}) async {
    try {
      int id = await DBHelper.insert(item!);
      print("Item added with id: $id in ItemController.addItem function");

      getItem(lastIndex: lastFetchedIndex);

      return id;
    } catch (e) {
      debugPrint("Error in ItemController.addItem: ${e.toString()}");
      return 0;
    }
  }

  void getItem({int lastIndex = -1}) async {
    isLoading.value = true;
    List<Map<String, dynamic>> fetchedItems = await DBHelper.query();

    if (lastIndex == -1) {
      itemList.assignAll(
        fetchedItems
            .map(
              (data) => Item.fromJson(data),
            )
            .toList(),
      );
    } else {
      List<Item> newItems = fetchedItems
          .where((data) => Item.fromJson(data).id! > lastIndex)
          .map((data) => Item.fromJson(data))
          .toList();
      itemList.addAll(newItems);
      lastFetchedIndex = itemList.isNotEmpty ? itemList.last.id! : -1;
    }
    isLoading.value = false;
  }

  void removeItem(int id) async {
    await DBHelper.delete(id);
    getItem(lastIndex: lastFetchedIndex);
  }

  // void updateItem(Item item) async {
  //   await DBHelper.update(item);
  //   getItem();
  // }

  // void markItemConsumed(int id) async {
  //   await DBHelper.markConsumed(id);
  //   getItem();
  // }
}
