import 'package:flutter/material.dart';

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
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _sortMode = 'new';

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
            const TextField(
              decoration: InputDecoration(labelText: '検索キーワード'),
            ),
            const TextField(
              decoration: InputDecoration(labelText: 'チャンネルURL'),
            ),
            Container(
              padding: const EdgeInsets.only(top: 16),
              child: Align(
                alignment: Alignment.topRight,
                child: DropdownButton(
                  items: const [
                    DropdownMenuItem(
                      value: 'new',
                      child: Text('公開の新しい順'),
                    ),
                    DropdownMenuItem(
                      value: 'old',
                      child: Text('公開の古い順'),
                    )
                  ],
                  onChanged: (String? value) {
                    setState(() {
                      _sortMode = value!;
                    });
                  },
                  value: _sortMode,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'search',
        child: const Icon(Icons.search),
        onPressed: () {
          // todo: 検索処理
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SearchResultPage(),
            ),
          );
        },
      ),
    );
  }
}

class SearchResultPage extends StatefulWidget {
  const SearchResultPage({super.key});

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
          children: const [
            Text('検索結果'),
          ],
        ),
      ),
    );
  }
}
