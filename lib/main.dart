import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:story_image_ai/cards/chat.dart';
import 'package:story_image_ai/firebase_options.dart';
import 'package:story_image_ai/global.dart';
import 'package:story_image_ai/home/Qrscan.dart';
import 'package:story_image_ai/ai/create_ai.dart';
import 'package:story_image_ai/home/generate.dart';
import 'package:story_image_ai/home/homes.dart';
import 'package:story_image_ai/home/search.dart';
import 'package:story_image_ai/home/settings.dart';
import 'package:story_image_ai/home/splash.dart';
import 'package:story_image_ai/model/story.dart';
import 'package:story_image_ai/provider/declare.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Star Wish AI Story Maker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Splash(),
    );
  }
}
bool isDarkModeEnabled=false;
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, this.title="jbhj"});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void initState(){
    dr();
    fy();
  }
  Future<void> fy() async {
    final SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();
    bool away= await asyncPrefs.getBool('night')??false;
    if(gh!=null){
      setState(() {
        isDarkModeEnabled=away;
      });
    }
  }
  void dr()async{
    UserProvider _userprovider = Provider.of(context, listen: false);
    await _userprovider.refreshuser();
  }
  String gh=FirebaseAuth.instance.currentUser!.email!;
  int _selectedIndex = 0;

  List<Widget> tabItems = [
    Center(child: Text("0")),
    Center(child: Text("1")),
    Center(child: Text("2")),
    Center(child: Text("3")),
    Center(child: Text("4"))
  ];

  Widget diu(){
     if(_currentIndex==0){
      return Home2(admin: gh=="hari@gmail.com");
    }else if(_currentIndex==1){
       return Search();
     }else if(_currentIndex==2){
       return QRSCAN();
     }else if(_currentIndex==4){
       return Settingss();
     }
    return Home();
  }
  Future<bool> _onWillPop(BuildContext context) async {
    bool exitApp = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Exit App"),
          content: Text("Are you sure you want to exit?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false), // Stay in the app
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true), // Exit the app
              child: Text("Exit"),
            ),
          ],
        );
      },
    ) ?? false; // If the dialog is dismissed, return false (stay in the app)
    return exitApp;
  }

  @override
  Widget build(BuildContext context) {
    double w=MediaQuery.of(context).size.width;
    return WillPopScope(
        onWillPop: () => _onWillPop(context),
        child: sd(false));
  }

  Widget sd(bool b){
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      body: Center(
        child: diu(),
      ),
      bottomNavigationBar: FlashyTabBar(
        animationCurve: Curves.bounceInOut,
        selectedIndex: _selectedIndex,
        iconSize: 30,
        backgroundColor:Colors.black,
        showElevation: true,
        onItemSelected: (index) => setState(() {
          _selectedIndex = index;
          _currentIndex=index;
        }),
        items: [
          FlashyTabBarItem(
            icon: Icon(Icons.home,color: Colors.white,),
            title: Text('Home',style: TextStyle(color: Colors.white),),
          ),
          FlashyTabBarItem(
            icon: Icon(Icons.search,color: Colors.white),
            title: Text('Search',style: TextStyle(color: Colors.white)),
          ),
          FlashyTabBarItem(
            icon: Icon(Icons.qr_code,color: Colors.white),
            title: Text('Scanner',style: TextStyle(color: Colors.white)),
          ),
          FlashyTabBarItem(
            icon: Icon(Icons.rocket_launch_sharp,color: Colors.white),
            title: Text('AI',style: TextStyle(color: Colors.white)),
          ),
          FlashyTabBarItem(
            icon: Icon(Icons.person,color: Colors.white),
            title: Text('Profile',style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
  int _currentIndex = 0;
}
