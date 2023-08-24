import 'package:expchk/app/database/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:get_storage/get_storage.dart';

import 'package:expchk/app/pages/home_page.dart';
import 'package:expchk/app/common/services/theme_services.dart';
import 'package:expchk/app/common/utils/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();

  await DBHelper.initDB();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeController().theme,
      home: const HomePage(),
    );
  }
}
