import 'package:expchk/app/common/utils/theme.dart';
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
        _showItems(context),
      ],
    );
  }

  _showItems(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.7648,
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
                if (index == 10) {
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
