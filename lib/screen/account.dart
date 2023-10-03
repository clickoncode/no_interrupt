import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:no_interrupt/local/sf.dart';
import 'package:no_interrupt/screen/auth/login.dart';
import 'package:no_interrupt/services/auth.dart';


class AccountSection extends StatefulWidget {
  const AccountSection({Key? key}) : super(key: key);

  @override
  State<AccountSection> createState() => _AccountSectionState();
}

class _AccountSectionState extends State<AccountSection> {
  User? user = FirebaseAuth.instance.currentUser;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Account'),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(48.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CircleAvatar(
                radius: 50,
                  backgroundColor: Colors.transparent,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network(user!.photoURL.toString(),
                      errorBuilder: (_, __, ___) => Center(
                        child: Icon(
                          Icons
                              .person,
                          color: Colors.white,size: 15,
                        ),
                      ),
                    ),
                    // foregroundImage: NetworkImage(),
                  )),
              SizedBox(height: 15),
              Center(
                child: Text(
                  'Hello ,'+user!.displayName.toString(),
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white),
                ),
              ),
              SizedBox(height: 10),
              Divider(
                thickness: 0.7,
                color: Colors.grey,
              ),

              Text(
                user!.email.toString(),
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.white),
              ),

              SizedBox(height: 20),
              OutlinedButton(
                onPressed: () {
                  _showMyDialog();
                   },
                child: Padding(
                  padding: const EdgeInsets.only(left:20.0,right: 20.0),
                  child: Text(
                    'Sign Out',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),

              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(child: Text("Version: 1.0.0",style: TextStyle(fontSize: 12,color: Colors.white),),),
              )
            ],
          ),
        ),
      )
    );
  }
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Are you Sure !',style: TextStyle(fontSize: 16),),

          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                OutlinedButton(
                  child: Padding(
                    padding: const EdgeInsets.only(right:15.0,left: 15.0),
                    child: Text('Yes',style: TextStyle(fontSize: 16,color: Colors.white)),
                  ),
                  onPressed: () async {
                    await HelperFunctions.saveUserLoggedInStatus(
                        false);
                    await HelperFunctions.saveUserapikey("");
                    await HelperFunctions.saveUserchid('');
                    Authentication.signOut(context: context);
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage(),),(Route<dynamic> route)=>false);
                  },
                ),
                OutlinedButton(
                  child: Padding(
                    padding: const EdgeInsets.only(right:15.0,left: 15.0),
                    child: Text('No',style: TextStyle(fontSize: 16,color: Colors.white)),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            )

          ],
        );
      },
    );
  }
}
