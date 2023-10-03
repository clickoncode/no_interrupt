

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:no_interrupt/local/sf.dart';

import '../screen/custom.dart';

class Constants {
  //
  static late String Defaultkey= '';

  static late String API_KEY = '';
   // static  String API_KEY = 'AIzaSyCEy26MdYAe6__ud8Zn6FZyuFLr2TAo9qc';
  static  String Channel_id = '';
   static  String  Channel_id2 = '';
   static  String  Channel_id3 = '';

  static  String fetch_id = '';
  // static  String Channel_id ='UCq-Fj5jknLsUf-MWSy4_brA';

  static List<Contact2> id = List.empty(growable: true);
   //
   void savesafeuserdata() async{
     if (API_KEY.length !=0 && fetch_id.length !=0) {
       await HelperFunctions.saveUserapikey(API_KEY).then((value) {
         print('save  successfully key');
       });
       await HelperFunctions.saveUserchid(fetch_id).then((value) {
         print('save  successfully chid');
       });
     }
   }
 Future<void> check() async {
   if(id.isEmpty){
         Channel_id = fetch_id ;
   }
   else{
      Channel_id = id[0].channelid;
   }
 }

 Future getuserdeatils() async{
  User? user = FirebaseAuth.instance.currentUser;
  FirebaseFirestore.instance
      .collection('user')
      .doc(user!.email)
      .get()
      .then((DocumentSnapshot documentSnapshot) async {
    if (documentSnapshot.exists) {
       API_KEY =  documentSnapshot.get('apikey');
       Defaultkey =  documentSnapshot.get('defaultkey');
      fetch_id  = documentSnapshot.get('default_channel');
    }
    else{
      print('not getting data');
    }
  }
  );
}

   // List<String> url =  [
   //   'https://www.statuslagao.com/whatsapp/videos/new/new-whatsapp-status-video-298.mp4',
   //   'https://www.statuslagao.com/whatsapp/videos/new/new-whatsapp-status-video-528.mp4',
   //   'https://www.statuslagao.com/whatsapp/videos/new/new-whatsapp-status-video-520.mp4',
   //   'https://www.statuslagao.com/whatsapp/videos/new/new-whatsapp-status-video-273.mp4',
   //   'https://www.statuslagao.com/whatsapp/videos/new/new-whatsapp-status-video-361.mp4',
   //   'https://www.statuslagao.com/whatsapp/videos/new/new-whatsapp-status-video-808.mp4',
   //   'https://www.statuslagao.com/whatsapp/videos/new/new-whatsapp-status-video-904.mp4',
   //   'https://www.statuslagao.com/whatsapp/videos/new/new-whatsapp-status-video-831.mp4',
   //   'https://www.statuslagao.com/whatsapp/videos/new/new-whatsapp-status-video-413.mp4',
   //   'https://www.statuslagao.com/whatsapp/videos/new/new-whatsapp-status-video-605.mp4',
   //   'https://www.statuslagao.com/whatsapp/videos/new/new-whatsapp-status-video-567.mp4',
   //   'https://www.statuslagao.com/whatsapp/videos/new/new-whatsapp-status-video-313.mp4',
   //   'https://www.statuslagao.com/whatsapp/videos/new/new-whatsapp-status-video-223.mp4',
   //   'https://assets.mixkit.co/videos/preview/mixkit-a-girl-blowing-a-bubble-gum-at-an-amusement-park-1226-large.mp4',
   //   'https://www.statuslagao.com/whatsapp/videos/new/new-whatsapp-status-video-851.mp4',
   // ];
   // static List urls = [];
   //  Random(){
   //   urls = shuffle(url);
   //   print(urls);
   // }
   // List shuffle(List array) {
   //   var random = Random(); //import 'dart:math';
   //
   //   // Go through all elementsof list
   //   for (var i = array.length - 1; i > 0; i--) {
   //
   //     // Pick a random number according to the lenght of list
   //     var n = random.nextInt(i + 1);
   //     var temp = array[i];
   //     array[i] = array[n];
   //     array[n] = temp;
   //   }
   //   return array;
   // }
}