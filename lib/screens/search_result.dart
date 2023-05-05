import 'dart:async';
import 'package:flutter/material.dart';
import 'package:youtube_api/youtube_api.dart';

// ignore: must_be_immutable
class SearchResultPage extends StatefulWidget {
  String keyword = "";
  String channelUrl = "";
  String movieLength = "";
  SearchResultPage(this.keyword, this.channelUrl, this.movieLength,
      {super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SearchResultPageState createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  static String key = "{apiKey}";

  List<YouTubeVideo> channelResult = [];
  List<YouTubeVideo> videoResult = [];

  YoutubeAPI youtubeChannel = YoutubeAPI(key, maxResults: 3, type: 'channel');
  FutureOr<String> searchChannels() async {
    if (widget.channelUrl != "") {
      String query = widget.channelUrl;
      List<YouTubeVideo> result = await youtubeChannel.search(
        query,
        type: 'channel',
      );
      String channelId = result.elementAt(0).channelId ?? '';
      return channelId;
    }
    return "";
  }

  YoutubeAPI youtubeVideo = YoutubeAPI(key, maxResults: 15, type: 'video');
  Future<void> searchVideo(String? channelId) async {
    String query = widget.keyword;
    videoResult = await youtubeVideo.search(
      query,
      type: 'video',
      channelId: channelId,
    );
    if (channelId != "") {
      videoResult
          .removeWhere((YouTubeVideo video) => video.channelId != channelId);
    }
    setState(() {
      channelResult = channelResult;
      videoResult = videoResult;
    });
  }

  @override
  void initState() {
    super.initState();
    Future(() async {
      String channelId = await searchChannels();
      searchVideo(channelId);
    });
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
                    video.channelId ?? '',
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
