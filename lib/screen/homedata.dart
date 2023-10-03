import 'package:flutter/material.dart';
import 'package:no_interrupt/screen/video_player_screen.dart';
import 'package:no_interrupt/video.dart';
import '../constant/constant.dart';
import '../local/sf.dart';
import '../model/channel_info.dart';
import '../model/video_list.dart';
import '../services/video_services.dart';
import '../widgets/custom_silver_app_bar.dart';

class homeData extends StatefulWidget {
  const homeData({Key? key}) : super(key: key);
  @override
  State<homeData> createState() => _homeDataState();
}

class _homeDataState extends State<homeData> {
  TextEditingController _textFieldController = TextEditingController();
  late String codeDialog;
  bool mainload = true;
  late String valueText;
  var hasPadding = true;
  VoidCallback? onTap;
  ChannelInfo? _channelInfo;
  late VideosList _videosList;
  late Item _item;
  late bool _loading;
  bool _isloading = false;
  late String _playListId;
  late String _nextPageToken;
  late ScrollController _scrollController;
  @override
  void initState() {
    super.initState();
    Constants().getuserdeatils();
    Constants().savesafeuserdata();
    Constants().check();
    _loading = true;
    _nextPageToken = '';
    _scrollController = ScrollController();
    _videosList = VideosList(etag: '', kind: '', nextPageToken: '', videos: []);
    _videosList.videos = [];
    _getChannelInfo();
    _getChannelInfo2();

  }

  // get chaneel_id from sf
  _getChannelInfo() async {
    _channelInfo =
        await Services.getChannelInfo(CHANNEL_ID: Constants.Channel_id);
    _item = _channelInfo!.items[0];
    _playListId = _item.contentDetails.relatedPlaylists.uploads;
    print('_playListId $_playListId');
    await _loadVideos();
    setState(() {
      mainload = false;
      _loading = false;
    });
  }
  _getChannelInfo2() async {
    _channelInfo =
        await Services.getChannelInfo(CHANNEL_ID: Constants.Channel_id2);
    _item = _channelInfo!.items[0];
    _playListId = _item.contentDetails.relatedPlaylists.uploads;
    print('_playListId $_playListId');
    await _loadVideos();
    setState(() {
      mainload = false;
      _loading = false;
    });
  }
  _loadVideos() async {
    _loading = true;
    VideosList tempVideosList = await Services.getVideosList(
      playListId: _playListId,
    );
    _nextPageToken = tempVideosList.nextPageToken;
    _videosList.videos.addAll(tempVideosList.videos);
    print('videos: ${_videosList.videos.length}');
    // print('_nextPageToken $_nextPageToken');
    print(int.parse(_item.statistics.videoCount));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _channelInfo != Null
          ? NotificationListener<ScrollEndNotification>(
              onNotification: (ScrollNotification notification) {
                if (_videosList.videos.length >=
                    int.parse(_item.statistics.videoCount)) {
                  setState(() {
                    _isloading = false;
                  });
                  return true;
                }
                if (notification.metrics.pixels ==
                    notification.metrics.maxScrollExtent) {
                  _loadVideos();
                  setState(() {
                    _isloading = true;
                  });
                } else {
                  setState(() {
                    _isloading = false;
                  });
                }
                return true;
              },
              child: Stack(children: [
                CustomScrollView(controller: _scrollController, slivers: [
                  CustomSliverAppBar(),
                  SliverPadding(
                    padding: const EdgeInsets.only(bottom: 60.0),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final VideoItem videoItem = _videosList.videos[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return VideoPlayerScreen(
                                  videoItem: videoItem,
                                  videolist: _videosList.videos,
                                );
                              }));

                              //activity
                              if (onTap != null) onTap!();
                            },
                            child: Column(

                              children: [
                                Stack(
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: hasPadding ? 12.0 : 0,
                                        ),
                                        child: Image.network(
                                          errorBuilder: (_, __, ___) => Center(
                                            child: Container(
                                              height: 190.0,
                                              decoration: BoxDecoration(
                                                
                                              ),
                                              width: double.infinity,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons
                                                        .signal_wifi_connected_no_internet_4,
                                                    color: Colors.white,
                                                  ),
                                                  Text("Check your network Status!", style: TextStyle(fontSize: 10,color: Colors.white),)
                                                ],
                                              ),
                                            ),
                                          ),
                                          videoItem.video.thumbnails.high.url,
                                          height: 190.0,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        )),
                                    Positioned(
                                      bottom: 8.0,
                                      right: hasPadding ? 20.0 : 8.0,
                                      child: Container(
                                        padding: const EdgeInsets.all(4.0),
                                        // color: Colors.black,
                                        // child: Text(
                                        //   videoItem.video.channelTitle,
                                        //   style: Theme.of(context)
                                        //       .textTheme
                                        //       .caption!
                                        //       .copyWith(color: Colors.white),
                                        // ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                        onTap: () =>
                                            print('Navigate to profile'),
                                        child: CircleAvatar(
                                          onForegroundImageError:(_, __,) => Center(child: Icon(Icons.network_check,color: Colors.white,),),
                                          foregroundImage: NetworkImage(
                                              videoItem.video.thumbnails
                                                  .thumbnailsDefault.url),
                                        ),
                                      ),
                                      const SizedBox(width: 8.0),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                videoItem.video.title,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .copyWith(fontSize: 15.0),
                                              ),
                                            ),
                                            Flexible(
                                              child: Text(
                                                ' Published At • ${(videoItem.video.publishedAt.toLocal().toIso8601String().split('T').first)}',
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .caption!
                                                    .copyWith(fontSize: 14.0),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {},
                                        child: const Icon(Icons.more_vert,
                                            size: 20.0),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        childCount: _videosList.videos.length,
                      ),
                    ),
                  ),
                ]),
                Positioned(
                  bottom: 10,
                  width: MediaQuery.of(context).size.width,
                  child: Align(
                    child: _isloading
                        ? Column(
                            children: [
                              Container(
                                height: 15.0,
                                width: 15.0,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 1.0,
                                  ),
                                ),
                              )
                            ],
                          )
                        : Container(),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.50,
                  width: MediaQuery.of(context).size.width,
                  child: Align(
                    child: mainload
                        ? Column(
                            children: [
                              Center(child: Text("Loading...\n")),
                              Container(
                                height: 15.0,
                                width: 15.0,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2.0,
                                  ),
                                ),
                              )
                            ],
                          )
                        : Container(),
                  ),
                ),
              ]),
            )
          : Positioned(
              bottom: 10,
              width: MediaQuery.of(context).size.width,
              child: Align(
                child: Column(
                  children: [
                    Container(
                      height: 15.0,
                      width: 15.0,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 5.0,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }

  // _displayTextInputDialog(BuildContext context) {
  //   return showDialog(
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //           title: Text('Enter Channel Id'),
  //           content: TextField(
  //             onChanged: (value) {
  //               valueText = value;
  //               setState(() {});
  //             },
  //             controller: _textFieldController,
  //             decoration: InputDecoration(hintText: "Chanel Id"),
  //           ),
  //           actions: <Widget>[
  //             ElevatedButton(
  //               style: ElevatedButton.styleFrom(primary: Colors.red),
  //               child: Text('CANCEL'),
  //               onPressed: () {
  //                 setState(() {
  //                   Navigator.pop(context);
  //                 });
  //               },
  //             ),
  //             ElevatedButton(
  //               style: ElevatedButton.styleFrom(primary: Colors.green),
  //               child: Text('Submit'),
  //               onPressed: () {
  //                 setState(() {
  //                   Constants.Channel_id = valueText.trim();
  //                   Navigator.pop(context);
  //                 });
  //               },
  //             ),
  //           ],
  //         );
  //       });
  // }

}
