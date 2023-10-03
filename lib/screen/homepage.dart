import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:is_lock_screen/is_lock_screen.dart';
import 'package:no_interrupt/local/sf.dart';
import 'package:no_interrupt/services/database.dart';
import '../constant/constant.dart';
import 'account.dart';
import 'custom.dart';
import 'explore.dart';
import 'homedata.dart';
import 'library.dart';
class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver{
  User? user = FirebaseAuth.instance.currentUser;

 String  status ='';
  AppLifecycleState ? state;
  int _selectedIndex = 0;
  final _screens = [
    homeData(),
    Explore_Screen(),
    CustomSection(),
    LibrarySection(),
    AccountSection(),
  ];

   @override
   void initState() {
     super.initState();
     Constants().savesafeuserdata();
     Constants().check();
     _appstatus();
     //add an observer to monitor the widget lyfecycle changes
     WidgetsBinding.instance.addObserver(this);


   }

  Future<void> _appstatus() async {
    if(status.isNotEmpty){ await DatabaseService(email: user!.email.toString()).lastactive(status);}
  }
   @override
   void didChangeAppLifecycleState(AppLifecycleState state) async {
     super.didChangeAppLifecycleState(state);
     if (state == AppLifecycleState.inactive) {
       final isLock = await isLockScreen();
       if(isLock!){
         print('app inactive MINIMIZED!');
       }
       print('app inactive in lock screen!');
     } else if (state == AppLifecycleState.resumed) {
       setState(() {
         status = DateTime.now().toString()
         ;
       });
       print('app resumed');
     }
     else if (state == AppLifecycleState.paused) {
       print('app Paused');
     }

   }

   @override
   void dispose() {
     //don't forget to dispose of it when not needed anymore
     WidgetsBinding.instance.removeObserver(this);
     super.dispose();
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Center(
    child: _screens.elementAt(_selectedIndex),
    ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 5.0,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (i) => setState(() => _selectedIndex = i),
        selectedFontSize: 11.0,
        unselectedFontSize: 10.0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_outlined),
            activeIcon: Icon(Icons.camera),
            label: 'Reels',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline,),
            activeIcon: Icon(Icons.add_circle,),
            label: 'Custom',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_add_outlined),
            activeIcon: Icon(Icons.library_add),
            label: 'Library',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            activeIcon: Icon(Icons.account_circle),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
