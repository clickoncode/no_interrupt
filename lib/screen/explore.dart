import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:no_interrupt/screen/feed.dart';
import 'package:no_interrupt/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/shotvideo_model.dart';



class Explore_Screen extends StatefulWidget {
  const Explore_Screen({Key? key}) : super(key: key);
  @override
  State<Explore_Screen> createState() => _Explore_ScreenState();
}

class _Explore_ScreenState extends State<Explore_Screen> {
  PageController controller = PageController();

  //to check which index is currently played
  int currentIndex = 0;
  //static content
   List<String> urls =  [
    'https://www.statuslagao.com/whatsapp/videos/new/new-whatsapp-status-video-298.mp4',
    'https://www.statuslagao.com/whatsapp/videos/new/new-whatsapp-status-video-528.mp4',
    'https://www.statuslagao.com/whatsapp/videos/new/new-whatsapp-status-video-520.mp4',
    'https://www.statuslagao.com/whatsapp/videos/new/new-whatsapp-status-video-273.mp4',
    'https://www.statuslagao.com/whatsapp/videos/new/new-whatsapp-status-video-361.mp4',
    'https://www.statuslagao.com/whatsapp/videos/new/new-whatsapp-status-video-808.mp4',
    'https://www.statuslagao.com/whatsapp/videos/new/new-whatsapp-status-video-904.mp4',
    'https://www.statuslagao.com/whatsapp/videos/new/new-whatsapp-status-video-831.mp4',
    'https://www.statuslagao.com/whatsapp/videos/new/new-whatsapp-status-video-413.mp4',
    'https://www.statuslagao.com/whatsapp/videos/new/new-whatsapp-status-video-605.mp4',
    'https://www.statuslagao.com/whatsapp/videos/new/new-whatsapp-status-video-567.mp4',
    'https://www.statuslagao.com/whatsapp/videos/new/new-whatsapp-status-video-313.mp4',
    'https://www.statuslagao.com/whatsapp/videos/new/new-whatsapp-status-video-223.mp4',
     'https://www.statuslagao.com/whatsapp/videos/new/new-whatsapp-status-video-301.mp4',
     'https://www.statuslagao.com/whatsapp/videos/new/new-whatsapp-status-video-552.mp4',
     'https://www.statuslagao.com/whatsapp/videos/new/new-whatsapp-status-video-470.mp4',
     'https://www.statuslagao.com/whatsapp/videos/new/new-whatsapp-status-video-292.mp4',
     'https://www.statuslagao.com/whatsapp/videos/new/new-whatsapp-status-video-318.mp4',
     'https://www.statuslagao.com/whatsapp/videos/new/new-whatsapp-status-video-701.mp4',
     'https://www.statuslagao.com/whatsapp/videos/new/new-whatsapp-status-video-741.mp4',
     'https://www.statuslagao.com/whatsapp/videos/new/new-whatsapp-status-video-617.mp4',
     'https://www.statuslagao.com/whatsapp/videos/new/new-whatsapp-status-video-358.mp4',
     'https://www.statuslagao.com/whatsapp/videos/new/new-whatsapp-status-video-704.mp4',
     'https://www.statuslagao.com/whatsapp/videos/new/new-whatsapp-status-video-738.mp4',
     'https://www.statuslagao.com/whatsapp/videos/new/new-whatsapp-status-video-378.mp4',
     'https://www.statuslagao.com/whatsapp/videos/new/new-whatsapp-status-video-545.mp4',
     'https://www.statuslagao.com/whatsapp/videos/new/new-whatsapp-status-video-522.mp4',
     'https://www.statuslagao.com/whatsapp/videos/new/new-whatsapp-status-video-775.mp4',
     'https://www.statuslagao.com/whatsapp/videos/new/new-whatsapp-status-video-775.mp4',
     'https://www.statuslagao.com/whatsapp/videos/new/new-whatsapp-status-video-534.mp4',
     'https://www.statuslagao.com/whatsapp/videos/new/new-whatsapp-status-video-522.mp4',
     'https://www.statuslagao.com/whatsapp/videos/new/new-whatsapp-status-video-201.mp4',
     'https://www.statuslagao.com/whatsapp/videos/new/new-whatsapp-status-video-441.mp4',
     'https://www.statuslagao.com/whatsapp/videos/new/new-whatsapp-status-video-528.mp4',
     'https://www.statuslagao.com/whatsapp/videos/new/new-whatsapp-status-video-305.mp4',
     'https://www.statuslagao.com/whatsapp/videos/new/new-whatsapp-status-video-516.mp4',
     'https://www.statuslagao.com/whatsapp/videos/new/new-whatsapp-status-video-315.mp4',
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text("Reels",style: TextStyle(color: Colors.white),),
          ],
        ),
      ),
      // width: double.infinity,
      // height: MediaQuery.of(context).size.height,
      body:StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('svideos').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return new Text('Loading...');
            default:
              return PageView.builder( // Changes begin here
                  controller: controller,
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, position) {
                    final document = snapshot.data!.docs[position];

                    // return ListTile(
                    //     title: new Text(document['url']),
                    //     );
                    return Stack(
                        alignment: Alignment.bottomCenter,
                        children:[
                          Container(
                              child: FeedItem(url:document['url'])
                          ),
                          Row (
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(flex: 4, child: Container(
                                height : MediaQuery.of(context).size.height / 10,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        // Text(
                                        //   'Share with someone special 😍! ',
                                        // ),
                                      ],
                                    ),
                                    SizedBox(height: 20.0),
                                  ],
                                ),
                              ),

                              ),
                              Expanded(child: Container(
                                  height : MediaQuery.of(context).size.height /1.75,
                                  child: Column(
                                    children: [
                                      iconDetail(CupertinoIcons.heart, '354k'),
                                      SizedBox(height: 30),
                                      iconDetail(CupertinoIcons.bookmark, '872'),
                                      SizedBox(height: 30),
                                      iconDetail(CupertinoIcons.square_arrow_down_fill, 'Save'),
                                      SizedBox(height: 30),
                                      iconDetail(CupertinoIcons.arrow_turn_up_right, 'Share'),
                                      SizedBox(height: 30),
                                      Icon(CupertinoIcons.ellipsis_vertical, size: 30, color: Colors.white),
                                      SizedBox(height: 50),
                                      CircleAvatar(
                                        radius: 20.0,
                                        backgroundImage:
                                        AssetImage('assets/1.gif'),
                                        backgroundColor: Colors.white24,
                                      )
                                    ],
                                  )
                              ),
                              ),
                            ],
                          )
                        ]
                    );
                  }
              );
          }
        },
      )



    );
  }
  int random(int min, int max) {
    return min + Random().nextInt(max - min);
  }

}
Column iconDetail(IconData icon, String number) {
  return Column(
    children: [
      Icon(icon, size: 25, color: Colors.white,
      ),
      Text(
        '$number',
        style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.normal,
            color: Colors.white
        ),
      )
    ],
  );
}