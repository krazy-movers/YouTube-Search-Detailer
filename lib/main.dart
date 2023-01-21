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
  final keywordController = TextEditingController();
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
                controller: keywordController,
                autofocus: true,
                decoration: InputDecoration(
                  labelText: '検索キーワード',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      final text = keywordController.text;
                      if (text.isNotEmpty) {
                        final snackBar = SnackBar(
                          content: Text('$text検索します'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SearchResultPage(text),
                          ),
                        );
                      }
                    },
                  ),
                )),
            const TextField(
              decoration: InputDecoration(labelText: 'チャンネルURL'),
            ),
            const TextField(
              decoration: InputDecoration(labelText: '動画の長さ'),
            ),
            const TextField(
              decoration: InputDecoration(labelText: '投稿からの経過時間'),
            ),
            SizedBox(
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        const snackBar = SnackBar(
                          content: Text('設定ボタンが押下されました'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.red,
                        fixedSize: const Size(250, 50),
                      ),
                      child: const Text('設定', style: TextStyle(fontSize: 15)))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

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
