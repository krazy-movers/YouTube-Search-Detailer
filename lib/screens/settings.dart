// ignore_for_file: unused_element

import 'dart:html';

import 'package:flutter/material.dart';
import 'package:youtube_api/youtube_api.dart';
import 'search_result.dart';
import 'home.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<SettingsPage> createState() => _SeettingsPageState();
}

class _SeettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: '設定項目1'),
            ),
            TextField(
              decoration: InputDecoration(labelText: '設定項目2'),
            ),
            TextField(
              decoration: InputDecoration(labelText: '設定項目3'),
            ),
          ],
        ),
      ),
    );
  }
}
