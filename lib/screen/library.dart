import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:no_interrupt/screen/auth/login.dart';
import 'package:no_interrupt/services/auth.dart';


class LibrarySection extends StatefulWidget {
  const LibrarySection({Key? key}) : super(key: key);

  @override
  State<LibrarySection> createState() => _LibrarySectionState();
}

class _LibrarySectionState extends State<LibrarySection> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Personalize'),
        ),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(48.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[

                SizedBox(height: 15),
                Center(
                  child: Text(
                    'Under Development..',
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.white),
                  ),
                ),
                SizedBox(height: 10),
                Divider(
                  thickness: 0.7,
                  color: Colors.grey,
                ),


              ],
            ),
          ),
        )
    );
  }

}
