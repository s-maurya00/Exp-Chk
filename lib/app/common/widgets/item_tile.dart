import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../models/item.dart';

class ItemTile extends StatelessWidget {
  const ItemTile({
    Key? key,
    required this.item,
    required this.handleOnTap,
  }) : super(key: key);

  final Item item;
  final Function handleOnTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        handleOnTap(item.id);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        padding: const EdgeInsets.only(
          top: 15,
        ),
        decoration: BoxDecoration(
          color: context.isDarkMode
              ? const Color.fromARGB(255, 46, 46, 46)
              : const Color.fromARGB(255, 241, 237, 237),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Row(
              children: [
                item.image.toString() == "null"
                    ? Container(
                        margin: const EdgeInsets.only(
                          left: 15,
                          right: 15,
                        ),
                        child: Image.asset(
                          "lib/app/assets/images/no_image_available.png",
                          height: 60,
                          width: 60,
                        ),
                      )
                    : Image.network(
                        item.image.toString(),
                        height: 60,
                        width: 60,
                      ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.productName.toString(),
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Text("Expiry: ${item.expiryDate.toString()}"),
                          const SizedBox(
                            width: 25,
                          ),
                          Text("Quantity: ${item.quantity.toString()}"),
                        ],
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.check_box_outline_blank,
                  size: 28,
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 90,
                top: 10,
                right: 20,
                bottom: 20,
              ),
              height: 2,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
