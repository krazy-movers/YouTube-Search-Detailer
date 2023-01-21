import 'package:flutter/material.dart';

class SearchResultPage extends StatefulWidget {
  String searchWord;
  SearchResultPage(this.searchWord, {super.key});

  @override
  State<SearchResultPage> createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('検索結果'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(widget.searchWord),
          ],
        ),
      ),
    );
  }
}
