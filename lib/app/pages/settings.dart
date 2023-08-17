import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'home_page.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final isSignedIn = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        _themeTile(),
        const SizedBox(
          height: 20,
        ),
        _accountTile(),
        const SizedBox(
          height: 20,
        ),
        _generalTile(),
      ],
    );
  }

  _themeTile() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(
                Icons.light_mode_outlined,
              ),
              const SizedBox(
                width: 20,
              ),
              const Text(
                "Theme",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              const Icon(
                Icons.arrow_forward_ios_rounded,
              ),
            ],
          ),
          const Divider(),
        ],
      ),
    );
  }

  _accountTile() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(
                Icons.person_outline,
              ),
              const SizedBox(
                width: 20,
              ),
              const Text(
                "Account",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              const Icon(
                Icons.arrow_forward_ios_rounded,
              ),
            ],
          ),
          const Divider(),
        ],
      ),
    );
  }

  _generalTile() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(
                Icons.settings_outlined,
              ),
              const SizedBox(
                width: 20,
              ),
              const Text(
                "General",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              const Icon(
                Icons.arrow_forward_ios_rounded,
              ),
            ],
          ),
          const Divider(),
        ],
      ),
    );
  }
}
