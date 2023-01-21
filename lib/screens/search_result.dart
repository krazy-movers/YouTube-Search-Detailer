import 'package:flutter/material.dart';
import 'package:youtube_api/youtube_api.dart';

class SearchResultPage extends StatefulWidget {
  String searchWord = "";
  SearchResultPage(this.searchWord, {super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SearchResultPageState createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  static String key = "{apikey}";

  YoutubeAPI youtube = YoutubeAPI(key, maxResults: 15, type: 'video');
  List<YouTubeVideo> videoResult = [];

  Future<void> callAPI() async {
    String query = widget.searchWord;
    videoResult = await youtube.search(query);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    callAPI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        title: const Text('Youtube API'),
      ),
      body: ListView(
        children: videoResult.map<Widget>(listItem).toList(),
      ),
    );
  }

  Widget listItem(YouTubeVideo video) {
    return Card(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 7.0),
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Image.network(
                video.thumbnail.small.url ?? '',
                width: 120.0,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    video.title,
                    softWrap: true,
                    style: const TextStyle(fontSize: 18.0),
                  ),
                  Text(
                    video.url,
                    softWrap: true,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
