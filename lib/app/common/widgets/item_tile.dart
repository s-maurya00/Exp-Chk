import 'package:flutter/material.dart';

class ItemTile extends StatelessWidget {
  const ItemTile({super.key});

  @override
  Widget build(BuildContext context) {
    return _appItem();
  }

  _appItem() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(
                    left: 10, right: 10, top: 5, bottom: 5),
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "title",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Text("Expires in 'x' days"),
                      SizedBox(
                        width: 25,
                      ),
                      Text("Quantity: x Units"),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              const Icon(
                Icons.more_vert,
                size: 28,
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(
                    left: 70,
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
              ),
            ],
          ),
        ),
      ],
    );
  }
}
