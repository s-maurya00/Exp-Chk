import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

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
      child: const Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.light_mode_outlined,
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                "Theme",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Icon(
                Icons.arrow_forward_ios_rounded,
              ),
            ],
          ),
          Divider(),
        ],
      ),
    );
  }

  _accountTile() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: const Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.person_outline,
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                "Account",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Icon(
                Icons.arrow_forward_ios_rounded,
              ),
            ],
          ),
          Divider(),
        ],
      ),
    );
  }

  _generalTile() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: const Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.settings_outlined,
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                "General",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Icon(
                Icons.arrow_forward_ios_rounded,
              ),
            ],
          ),
          Divider(),
        ],
      ),
    );
  }
}
