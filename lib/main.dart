import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/home.dart';
import 'screens/search_result.dart';
import 'screens/settings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YouTube Search Detailer',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const MyHomePage(title: 'YouTube Search Detailer'),
      initialRoute: '/',
      routes: {
        '/result': (context) => SearchResultPage(''),
        '/settings': (context) =>
            const SettingsPage(title: 'YouTube Search Detailer'),
      },
      /*
      onPressed: () {
        Navigator.pushNamed(context, '/settings'); // 移動したい画面の名前を設定する
      },
      */
    );
  }
}
