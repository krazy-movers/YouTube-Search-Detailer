import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/search_result.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final keywordController = TextEditingController();
  final channelUrlController = TextEditingController();
  final movieLengthController = TextEditingController();
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
                      final keyword = keywordController.text;
                      final channelUrl = channelUrlController.text;
                      final movieLength = movieLengthController.text;

                      if (keyword.isNotEmpty) {
                        final snackBar = SnackBar(
                          content: Text('$keyword検索します'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SearchResultPage(
                                keyword, channelUrl, movieLength),
                          ),
                        );
                      }
                    },
                  ),
                )),
            TextField(
              controller: channelUrlController,
              decoration: const InputDecoration(labelText: 'チャンネルURL'),
            ),
            TextField(
              controller: movieLengthController,
              decoration: const InputDecoration(labelText: '動画の長さ'),
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
