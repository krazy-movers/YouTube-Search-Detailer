import 'dart:async';
import 'package:flutter/material.dart';
import 'package:youtube_api/youtube_api.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class SearchResultPage extends StatefulWidget {
  String keyword = "";
  String channelUrl = "";
  String movieLength = "";
  String ignore = "";
  SearchResultPage(this.keyword, this.channelUrl, this.movieLength, this.ignore,
      {super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SearchResultPageState createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  static String key = dotenv.get('YOUTUBE_API_KEY');

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
  Future<void> searchVideo(String? channelId, String? ignoreWord) async {
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
    // 無視する単語がある場合は、その単語を含む動画を除外する
    if (ignoreWord != "") {
      videoResult.removeWhere(
          (YouTubeVideo video) => video.title.contains(ignoreWord!));
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
      String ignoreWord = widget.ignore;
      searchVideo(channelId, ignoreWord);
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
    return GestureDetector(
      child: Card(
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
      ),
      onTap: () => _launchInBrowser(Uri.parse(video.url)),
    );
  }
}
