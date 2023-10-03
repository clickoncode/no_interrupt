import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:no_interrupt/constant/constant.dart';
import 'package:no_interrupt/local/sf.dart';
import 'package:no_interrupt/services/auth.dart';
import '../../services/database.dart';
import '../homepage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isSigningIn = false;
  double getSmallDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 2 / 3;

  double getBiglDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 7 / 8;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xA8252527),
      body: Stack(
        children: <Widget>[
          Positioned(
            right: -getSmallDiameter(context) / 3,
            top: -getSmallDiameter(context) / 3,
            child: Container(
              width: getSmallDiameter(context),
              height: getSmallDiameter(context),
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                      colors: [Color(0xDE3E3E3), Color(0x39E3E3E3)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter)),
            ),
          ),
          Positioned(
            left: -getBiglDiameter(context) / 4,
            top: -getBiglDiameter(context) / 4,
            child: Container(
              width: getBiglDiameter(context),
              height: getBiglDiameter(context),
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                      colors: [Color(0x2FB6ADAD), Color(0x5CE3E3E3)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter)),
            ),
          ),
          Positioned(
            right: -getBiglDiameter(context) / 2,
            bottom: -getBiglDiameter(context) / 2,
            child: Container(
              width: getBiglDiameter(context),
              height: getBiglDiameter(context),
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Color(0x39E3E3E3)),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ListView(
              children: <Widget>[
                Container(
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        // border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10)),
                    margin: const EdgeInsets.fromLTRB(20, 300, 20, 0),
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 25),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.play_circle_outline,
                            size: 50,
                            color: Colors.red,
                          ),
                          const Text.rich(
                            TextSpan(
                              text: ' V',
                              style: TextStyle(
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold,
                                fontSize: 35,
                                color: Colors.red,
                                shadows: [
                                  Shadow(
                                    blurRadius: 2.0, // shadow blur
                                    color: Colors.white, // shadow color
                                    offset: Offset(2.0,
                                        1.0), // how much shadow will be shown
                                  ),
                                ],
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'TUBE',
                                    style: TextStyle(
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 35,
                                      color: Colors.white,
                                      shadows: [
                                        Shadow(
                                          blurRadius: 2.0, // shadow blur
                                          color: Colors.red, // shadow color
                                          offset: Offset(2.0,
                                              1.0), // how much shadow will be shown
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                          ),
                        ])
                    // Column(
                    //   children:  <Widget>[
                    //     TextField(
                    //       decoration: InputDecoration(
                    //           icon: const Icon(
                    //             Icons.email,
                    //             color: Color(0xFFFF4891),
                    //           ),
                    //           focusedBorder: UnderlineInputBorder(
                    //               borderSide:
                    //               BorderSide(color: Colors.grey.shade100 )),
                    //           labelText: "Email",
                    //           enabledBorder: InputBorder.none,
                    //           labelStyle: const TextStyle(color: Colors.grey)),
                    //     ),
                    //     TextField(
                    //       obscureText: true,
                    //       decoration: InputDecoration(
                    //           icon: const Icon(
                    //             Icons.vpn_key,
                    //             color: Color(0xFFFF4891),
                    //           ),
                    //           focusedBorder: UnderlineInputBorder(
                    //               borderSide:
                    //               BorderSide(color: Colors.grey.shade100)),
                    //           labelText: "Password",
                    //           enabledBorder: InputBorder.none,
                    //           labelStyle: const TextStyle(color: Colors.grey)),
                    //
                    //     )
                    //   ],
                    // ),
                    ),
                // Align(
                //     alignment: Alignment.centerRight,
                //     child: Container(
                //         margin: const EdgeInsets.fromLTRB(0, 0, 20, 10),
                //         child: const Text(
                //           "FORGOT PASSWORD?",
                //           style:
                //           TextStyle(color: Color(0xFFFF4891), fontSize: 11),
                //         ))),
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 0, 10, 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: 45,
                        child: Container(
                          child: Material(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(15),
                              splashColor: Colors.amber,
                              onTap: () async {
                                setState(() {
                                  _isSigningIn = true;
                                });
                                User? user =
                                    await Authentication.signInWithGoogle(
                                        context: context);
                                setState(() {
                                  _isSigningIn = false;
                                });
                                if (user != null) {
                                  FirebaseFirestore.instance
                                      .collection('user')
                                      .doc(user.email)
                                      .get()
                                      .then((DocumentSnapshot
                                          documentSnapshot) async {
                                    if (documentSnapshot.exists) {
                                      Constants().getuserdeatils();
                                      await HelperFunctions
                                          .saveUserLoggedInStatus(true);
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => HomeScreen(),
                                        ),
                                      );
                                    } else {
                                      await DatabaseService(
                                              email: user.email.toString())
                                          .savingUserData(
                                              user.displayName.toString(),
                                              user.email.toString(),
                                              user.uid.toString())
                                          .whenComplete(() async =>
                                              await HelperFunctions
                                                  .saveUserLoggedInStatus(
                                                      true));

                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => HomeScreen(),
                                        ),
                                      );
                                    }
                                  });
                                } else {
                                  showSnackbar(context, Color(0xffb00909),
                                      "Something went wrong!");
                                  setState(() {
                                    _isSigningIn = false;
                                  });
                                }
                              },
                              //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
                              //
                              // },
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    _isSigningIn
                                        ? Text(
                                            "Loading..",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 15,
                                              letterSpacing: 5,
                                              shadows: [
                                                Shadow(
                                                  blurRadius:
                                                      2.0, // shadow blur
                                                  color: Colors
                                                      .black, // shadow color
                                                  offset: Offset(2.0,
                                                      2.0), // how much shadow will be shown
                                                ),
                                              ],
                                            ),
                                          )
                                        : Text(
                                            "Sign with Google",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 15,
                                              letterSpacing: 5,
                                              shadows: [
                                                Shadow(
                                                  blurRadius:
                                                      2.0, // shadow blur
                                                  color: Colors
                                                      .black, // shadow color
                                                  offset: Offset(2.0,
                                                      2.0), // how much shadow will be shown
                                                ),
                                              ],
                                            ),
                                          ),
                                    Icon(
                                      Icons.g_mobiledata_sharp,
                                      color: Colors.white,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.redAccent
                              // gradient: const LinearGradient(
                              //     colors: [
                              //       Color(0xFFB226B2),
                              //       Color(0xFFFF4891)
                              //     ],
                              //     begin: Alignment.topCenter,
                              //     end: Alignment.bottomCenter)
                              ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: FloatingActionButton(
                          backgroundColor: Colors.white,
                          onPressed: () {},
                          mini: true,
                          elevation: 0,
                          child: _isSigningIn
                              ? Container(
                                  height: 15.0,
                                  width: 15.0,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.red,
                                      strokeWidth: 2.0,
                                    ),
                                  ))
                              : const Icon(
                                  Icons.arrow_forward,
                                  color: Colors.redAccent,
                                ),
                        ),
                      ),
                      // FloatingActionButton(
                      //   backgroundColor: Colors.white,
                      //   onPressed: () {},
                      //   mini: true,
                      //   elevation: 0,
                      //   child: const Icon(Icons.g_mobiledata, color: Colors.red,),
                      // ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Text(
                      "A customizable Youtube Player!",
                      style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "\nCreate your own uniterrupted room!",
                      style: TextStyle(
                          fontSize: 11,
                          color: Colors.redAccent,
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                      "\n",
                      style: TextStyle(
                          fontSize: 11,
                          color: Color(0xFFFF4891),
                          fontWeight: FontWeight.w700),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
