
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../model/video_list.dart';
class VideoPlayerScreen extends StatefulWidget {
  //
  VideoPlayerScreen({required this.videoItem, required this.videolist});
  VideoItem videoItem;
  final List<VideoItem> videolist;
  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}
class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  var contain;
  var hasPadding =true ;
  late ScrollController scrollController;
  final double expandedHight = 500.0;
  late YoutubePlayerController _controller;
  late bool _isPlayerReady;
  var playid;
  List<String> _ids = [];
  @override
  void initState() {
    getvideoId();
    playid = widget.videoItem.video.resourceId.videoId;
    super.initState();
    _isPlayerReady = false;
    _controller = YoutubePlayerController(
      initialVideoId: playid,
      flags: YoutubePlayerFlags(
        showLiveFullscreenButton: false,
        hideControls: false,
        mute: false,
        // forceHD: true,
        autoPlay: true,
      ),
    )..addListener(_listener);
    scrollController = new ScrollController();
    scrollController.addListener(() => setState(() {}));
  }
  void _listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
      });
      //
    }
  }
  // get video id
  void getvideoId(){
    setState(() {
      for (int i = 0; i < widget.videolist.length; i++) {
        _ids.add(
          widget.videolist[i].video.resourceId.videoId,
        );
        widget.videolist[i].video.resourceId.videoId;
      };
      contain = widget.videolist;
      contain.shuffle();
    }
    );
    print(_ids.length);
  }


  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    // _controller.dispose();
    scrollController.dispose();
    super.dispose();
  }

  double get top {
    double res = expandedHight;
    if (scrollController.hasClients) {
      double offset = scrollController.offset;
      if (offset < (res - kToolbarHeight)) {
        res -= offset;
      } else {
        res = kToolbarHeight;
      }
    }
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            NestedScrollView(
              controller: scrollController,
              headerSliverBuilder: (context, value) {
                return [
                  SliverAppBar(
                    backgroundColor: Colors.black,
                    automaticallyImplyLeading: false,
                    pinned: true,
                    expandedHeight: MediaQuery.of(context).size.width,
                    collapsedHeight: MediaQuery.of(context).size.height *0.35,
                    flexibleSpace: ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        Container(
                          child: YoutubePlayerBuilder(
                              player: YoutubePlayer(

                                aspectRatio: 16 / 9,
                                controller: _controller,
                                progressColors: ProgressBarColors(backgroundColor: Colors.white,playedColor: Colors.red,handleColor: Colors.red),
                                showVideoProgressIndicator: true,
                                progressIndicatorColor: Colors.white,
                                onReady: () {
                                  _isPlayerReady = true;
                                },
                                onEnded: (data) {
                                  _controller
                                      .load(_ids[(_ids.indexOf(data.videoId) + 1) % _ids.length]);
                                },
                              ),
                              builder: (context, player) {
                                return Container(
                                  // some widgets
                                  child:player,
                                );
                              }
                          ),
                        ),
                        Padding(
                          padding:
                          const EdgeInsets.only(left: 15, top: 20, right: 15),
                          child: Container(
                            child: Row(
                              children: [
                                Flexible(
                                    child: Text(
                                      widget.videoItem.video.title,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontFamily: 'Poppins',
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.visible,
                                    )),
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          thickness: 1,
                          color: Colors.white,
                          indent: 10,
                          endIndent: 20,
                        ),
                      ],
                    ),
                  ),
                ];
              },
              body: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount:widget.videolist.length,
                itemBuilder: (BuildContext context, int index) {
                  VideoItem videoItem = contain[index];
                  return InkWell(
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                            return VideoPlayerScreen(
                              videoItem: widget.videolist[index],
                              videolist: (widget.videolist),
                            );
                          }));
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
                              ),
                            ),
                            Positioned(
                              bottom: 8.0,
                              right: hasPadding ? 20.0 : 8.0,
                              child: Container(
                                padding: const EdgeInsets.all(4.0),
                                color: Colors.transparent,
                                // child: Icon(Icons.play_circle_outline,color: Colors.white,size: 22,)
                                // Text(
                                //   videoItem.video.position.toString(),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () => print('Navigate to profile'),
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(videoItem.video.thumbnails.thumbnailsDefault.url),
                                ),
                              ),
                              const SizedBox(width: 8.0),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                child: const Icon(Icons.more_vert, size: 20.0),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),

            ),
          ],
        ),
      ),
    );
  }
}