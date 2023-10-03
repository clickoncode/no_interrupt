import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomSliverAppBar extends StatelessWidget {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: false,
      pinned: true,
      leadingWidth: 100.0,
      leading: Padding(
          padding: const EdgeInsets.only(left: 3.0, top: 13),
          child: Stack(children:[
            Icon (
              Icons.play_circle_outline,
              size: 25,
              color: Colors.red,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: const Text.rich(
                TextSpan(
                  text: ' V',
                  style: TextStyle(
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.red,
                    shadows: [
                      Shadow(
                        blurRadius: 2.0, // shadow blur
                        color: Colors.black, // shadow color
                        offset:
                            Offset(2.0, 2.0), // how much shadow will be shown
                      ),
                    ],
                  ),
                  children: <TextSpan>[
                    TextSpan(
                        text: 'TUBE',
                        style: TextStyle(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              blurRadius: 2.0, // shadow blur
                              color: Colors.black, // shadow color
                              offset: Offset(
                                  2.0, 1.0), // how much shadow will be shown
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            ),
          ])),
      actions: [
        // IconButton(
        //   icon: const Icon(Icons.notifications_outlined),
        //   onPressed: () {},
        // ),
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {},
        ),
        IconButton(
          iconSize: 20.0,
          icon: CircleAvatar(
              backgroundColor: Colors.white,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.network(user!.photoURL.toString(),errorBuilder: (_, __, ___) => Center(
                  child: Icon(
                    Icons
                        .person,
                    color: Colors.white,size: 15,
                  ),
                ),),
                // foregroundImage: NetworkImage(),
              )),
          onPressed: () {},

        ),
      ],
    );
  }
}
