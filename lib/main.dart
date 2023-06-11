import 'package:flutter/material.dart';
import 'screens/home.dart';
import 'screens/search_result.dart';
import 'screens/settings.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
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
        '/result': (context) => SearchResultPage('', '', '100'),
        '/settings': (context) =>
            const SettingsPage(title: 'YouTube Search Detailer'),
      },
    );
  }
}
