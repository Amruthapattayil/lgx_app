
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'hive_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox('posts');

  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HivePage(),
    ),
  );
}
