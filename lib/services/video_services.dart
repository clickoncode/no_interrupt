import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../constant/constant.dart';
import '../model/channel_info.dart';
import '../model/video_list.dart';
class Services {
  //
  static const CHANNEL_ID2 = 'UCq-Fj5jknLsUf-MWSy4_brA';
  static const _baseUrl = 'www.googleapis.com';
  static String _nextPageToken = '';
  static Future<ChannelInfo> getChannelInfo({required String CHANNEL_ID}) async {
    Map<String, String> parameters = {
      'part': 'snippet,contentDetails,statistics',
      'id': CHANNEL_ID2,
      'key': Constants.API_KEY,
    };
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    Uri uri = Uri.https(
      _baseUrl,
      '/youtube/v3/channels',
      parameters,
    );
    Response response = await http.get(uri, headers: headers);
     print(response.body);
    ChannelInfo channelInfo = channelInfoFromJson(response.body);
    return channelInfo;
  }

   static Future<VideosList> getVideosList(
      {String? playListId, }) async {
    Map<String, String> parameters = {
      'part': 'snippet',
      'playlistId': playListId!,
      'maxResults': '8',
      'pageToken': _nextPageToken,
      'key': Constants.API_KEY,
    };
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    Uri uri = Uri.https(
      _baseUrl,
      '/youtube/v3/playlistItems',
      parameters,
    );
    Response response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      // print(response.body);
      VideosList videosList = videosListFromJson(response.body);
      var data = json.decode(response.body);
      _nextPageToken = data['nextPageToken'] ?? '';
      return videosList;
    }
    else {
      {
        throw json.decode(response.body)['error']['message'];
      }
    }
  }
}
// class Constants {
//   //
//   static const String API_KEY = 'AIzaSyCEy26MdYAe6__ud8Zn6FZyuFLr2TAo9qc';
// }