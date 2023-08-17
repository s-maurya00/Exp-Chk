import 'package:flutter/material.dart';

import 'package:expchk/app/common/widgets/item_tile.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isAscendSort = true;

  @override
  Widget build(BuildContext context) {
    return Column(
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
        _showItems(context),
      ],
    );
  }

  _showItems(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.775,
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: 11,
              itemBuilder: (context, index) {
                if (index == 10 || index == 0) {
                  return const SizedBox(
                    height: 15,
                  );
                } else {
                  return const ItemTile();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
