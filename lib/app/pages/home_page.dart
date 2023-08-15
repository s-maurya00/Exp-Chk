import 'package:flutter/material.dart';

import 'package:expchk/app/common/widgets/item_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Column(
        children: [
          const Row(
            children: [
              SizedBox(
                width: 20,
              ),
              Text(
                "All Items",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Icon(
                Icons.sort_rounded,
                size: 28,
              ),
              SizedBox(
                width: 20,
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          _showItems(),
        ],
      ),
    );
  }

  _appBar() {
    return AppBar(
      title: const Text(
        "Good morning",
      ),
      actions: [
        GestureDetector(
          child: const CircleAvatar(
            child: Icon(
              Icons.person,
            ),
          ),
          onTap: () {
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
