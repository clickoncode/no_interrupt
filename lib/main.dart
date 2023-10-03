import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:is_lock_screen/is_lock_screen.dart';
import 'package:no_interrupt/firebase_options.dart';
import '../screen/auth/login.dart';
import 'package:no_interrupt/screen/homepage.dart';
import 'constant/constant.dart';
import 'local/sf.dart';
void main() async{
  final binding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: binding);
  WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.remove();
  await Firebase.initializeApp(
    
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ProviderScope(child: MyApp()));

}
class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  bool _isSignedIn = false;
  @override
  void initState() {
    super.initState();
    getchid();
    getkey();
    getUserLoggedInStatus();

  }
  getUserLoggedInStatus() async {
    await HelperFunctions.getUserLoggedInStatus().then((value) {
      if (value != null) {
        setState(() {
          _isSignedIn = value;
          print(_isSignedIn.toString());
        }
        );
      }
    }
    );
  }
  getkey() async {
    await HelperFunctions.getapi().then((value) {
      if (value != null) {
        setState(() {
          Constants.API_KEY = value;
          print(Constants.API_KEY);
        });
      }
      else{
        print('no value here');
      }
    }
    );
  }
  getchid() async {
    await HelperFunctions.getchid().then((value) {
      if (value != null) {
        setState(() {
          Constants.fetch_id = value;
          print(Constants.fetch_id);
        });
      }
    }
    );
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      title: 'VTUBE',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        bottomNavigationBarTheme:
        const BottomNavigationBarThemeData(selectedItemColor: Colors.white),
      ),
      home:_isSignedIn?HomeScreen():LoginPage(),
    );
  }
}
