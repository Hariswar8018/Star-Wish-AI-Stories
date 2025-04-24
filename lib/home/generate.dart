import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:story_image_ai/cards/chat.dart';
import 'package:story_image_ai/firebase_options.dart';
import 'package:story_image_ai/global.dart';
import 'package:story_image_ai/ai/create_ai.dart';
import 'package:story_image_ai/home/splash.dart';
import 'package:story_image_ai/model/story.dart';
import 'package:story_image_ai/model/user.dart';
import 'package:story_image_ai/provider/declare.dart';
import 'dart:math';

import '../main.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String yiop(int y){
    if(y==0){
      return "Conversation";
    }else if(y==1){
      return "Short Story";
    }else {
      return "Invites";
    }
  }
  int review=0;
  Widget f(double w, int yes)=>InkWell(
    onTap: (){
      setState(() {
        review=yes;
      });
      print(review);
    },
    child: Container(
      width: w/2-30,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: yes==review?Colors.yellowAccent:Global.blac,
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            yes==0?Icon(Icons.chat,size: 25,color: Colors.black,):Icon(Icons.book,size: 25,color: Colors.black,),
            Text(yiop(yes),
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color:yes==review? Colors.black:Colors.white)),
          ],
        ),
      ),
    ),
  );
  bool on=false;
  @override
  Widget build(BuildContext context) {
    double w=MediaQuery.of(context).size.width;
    double h=MediaQuery.of(context).size.height;
    UserModel? _user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
        backgroundColor: isDarkModeEnabled?Colors.white:Colors.black,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.black,
          title: Text("Generate / My Stories",style: TextStyle(color: Colors.white),),
        ),
        body: Container(
          width: w,height: h,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/back.webp"),
                  fit: BoxFit.cover,opacity: 0.1)
          ),
          child: SingleChildScrollView(
            child: Column(
                children:[
                  Container(
                    width:w,height:170,
                    decoration:BoxDecoration(
                        image:DecorationImage(image: AssetImage("assets/ff1f2ccb-f5eb-4f26-b02c-b85961c112be.webp"),fit:BoxFit.cover)
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0,top: 20),
                        child: Icon(Icons.star,color: isDarkModeEnabled?Colors.black: Colors.white,),
                      ),
                      ty("Generate Story"),
                      Spacer(),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Center(
                      child: Container(
                          width: w-20,
                          height: 55,
                          decoration: BoxDecoration(
                            color: Global.blac,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              // specify the radius for the top-left corner
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              // specify the radius for the top-right corner
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              f(w, 0),
                              f(w, 1),
                            ],
                          )
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            InkWell(
                                onTap: (){
                                  setState(() {
                                    on=true;
                                    i=0;
                                  });
                                },
                                child: s(char1,"Character 1","assets/61b207789faa5df7fc7e3f6a3dba9cdb.jpg")),
                            SizedBox(height: 10,),
                            InkWell(
                                onTap: (){
                                  setState(() {
                                    on=true;
                                    i=1;
                                  });
            
                                },
                                child: s(situation,"Situation","assets/aikatsu.jpg")),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            InkWell(
                                onTap: (){
            
                                  setState(() {
                                    on=true;
                                    i=2;
                                  });
            
                                },
                                child: s(char2,"Character 2","assets/Sakuraba.Laura.600.3812395.jpg")),
                            SizedBox(height: 10,),
                            InkWell(
                                onTap: (){
                                  setState(() {
                                    on=true;
                                    i=3;
                                  });
            
                                },
                                child: s(mood,"Mood","assets/doodle-emoticon-face-icon-set-600nw-2479174063.webp")),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            InkWell(
                                onTap: (){

                                  setState(() {
                                    on=true;
                                    i=4;
                                  });
                                },
                                child: s(background,"Background","assets/japan-anime-city-street-igs1edg9sezpe55u.jpg")),
                            SizedBox(height: 10,),
                            InkWell(
                                onTap: (){
                                  setState(() {
                                    on=true;
                                    i=5;
                                  });
                                },
                                child: s(picture,"Genere","assets/aikatsu1.jpg")),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                 i==5? Row(
                   children: [
                     g("Sci-Fiction"),g('Novel'),g('Fantasy'),g('Adventure'),g('Mystery')
                   ],
                 ): c(),
                  SizedBox(height: 15,),
                  InkWell(
                      onTap: (){
                        if(char1.text.isEmpty||char2.text.isEmpty||situation.text.isEmpty||mood.text.isEmpty){
                          Global.showMessage(context, "Type all Character 1, 2, Situation and about Mood",false);
                          return ;
                        }
                        Navigator.push(
                            context, PageTransition(
                            child: ChatScreen(str:tyup(), admin: false, character1name: getF(char1.text), picture: _user!.pic, conversationstyle: review==0, genere: hh, names: '',), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 200)
                        ));
                      },
                      child: Uiu()),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Icon(Icons.access_alarm,color: isDarkModeEnabled?Colors.black: Colors.white,),
                      ),
                      ty("Your Creation"),
                      Spacer(),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 180,
                      child: FutureBuilder(
                        future: FirebaseFirestore.instance
                            .collection("users")
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .collection('Stories').orderBy("id",descending:true).get(),
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                            case ConnectionState.none:
                              return Center(child: CircularProgressIndicator());
                            case ConnectionState.active:
                            case ConnectionState.done:
                              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                                return Center(child: Text("No stories available"));
                              }
                              List<StoryModel> stories = snapshot.data!.docs
                                  .map((doc) => StoryModel.fromJson(doc.data() as Map<String, dynamic>))
                                  .toList();
                              return Container(
                                width:w,height:220,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal, // Enable horizontal scrolling
                                  itemCount: stories.length,
                                  itemBuilder: (context, index) {
                                    StoryModel story = stories[index];
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0), // Adds spacing
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => ChatStoryScreen(
                                                story: story, // Pass the StoryModel object
                                              ),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          width: 130,
                                          height: 180,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(6), // Rounded corners
                                            border: Border.all(
                                              color: isDarkModeEnabled?Colors.black:Colors.white,
                                            ),
                                            image: DecorationImage(
                                              image: AssetImage(assetsend(story.description)), // Use the picture from StoryModel
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                          }
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                ]
            ),
          ),
        )
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  String assetsend(String genere){
    if(genere=="Sci-Fiction"){
      return "assets/science.jpg";
    }else if(genere=="Novel"){
      return "assets/novel.webp";
    }else if(genere=="Adventure"){
      return "assets/adventure.jpg";
    }else if(genere=="Mystery"){
      return "assets/mystery.jpg";
    }else{
      return "assets/fantasy.jpg";
    }
  }
  String hh="Fantasy";
  Widget g(String f)=>InkWell(
    onTap: (){
      setState(() {
        hh=f;
        picture.text=hh;
      });
    },
    child: Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: hh==f?Colors.blue:Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 8,right: 8,top: 4,bottom: 4),
            child: Text(f,style: TextStyle(color:hh==f?Colors.white: Colors.black),),
          )),
    ),
  );

  String getF(String input) {
    return input.split(RegExp(r'\s+'))[0];
  }
  int i=0;
  String tyup(){
    return "Write a Story in ${review==0?"Chat Format":"Paragraph Format with suitable Space between paragraph"} where character 1 name ${getF(char1.text)} and Character 2 name ${char2.text} in a Situation ${situation.text} with a Mood of ${mood.text} with ${background.text} Background in ${hh} Genere";
  }

  Widget c() {
    if(!on){
      return SizedBox();
    }
    if(i==0){
      return fg(char1, "Type About Character 1", "Character Name Ayush");
    }else if(i==1){
      return  fg(situation, "Type About Situation", "Inside a School");
    }else if(i==2){
      return fg(char2, "Type About Character 2", "Character Name Aysha");
    }else if(i==4){
      return fg(background, "Type About Background", "In Forest");
    }else if(i==5){
      return fg(picture, "Type Language", "English");
    }else{
      return fg(mood, "Type About Mood", "Characters are both Angry");
    }
  }
  TextEditingController char1=TextEditingController();

  TextEditingController char2=TextEditingController();

  TextEditingController situation=TextEditingController();

  TextEditingController mood=TextEditingController();
  TextEditingController background=TextEditingController();
  TextEditingController picture=TextEditingController();
  Widget fg(TextEditingController ha, String str, String str2) => Padding(
    padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 10),
    child: TextFormField(
      controller: ha,
      keyboardType: TextInputType.text,
      style: TextStyle(color:isDarkModeEnabled?Colors.black: Colors.white), // ✅ Makes typed text white
      decoration: InputDecoration(
        labelText: str,
        labelStyle: TextStyle(color:isDarkModeEnabled?Colors.black: Colors.white), // ✅ Makes label text white
        hintText: str2,
        hintStyle: TextStyle(color: isDarkModeEnabled?Colors.black:Colors.white70), // ✅ Makes hint text white with slight opacity
        isDense: true,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: isDarkModeEnabled?Colors.black:Colors.white), // ✅ White border
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color:isDarkModeEnabled?Colors.black: Colors.white), // ✅ White border when not focused
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: isDarkModeEnabled?Colors.black:Colors.white, width: 2.0), // ✅ Thicker white border when focused
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please type It';
        }
        return null;
      },
    ),
  );


  Widget ty(String str){
    return Text("   "+str,style: TextStyle(color:isDarkModeEnabled?Colors.black: Colors.white,fontSize: 18,fontWeight: FontWeight.w700,letterSpacing: 1.2),);
  }

  Widget s(TextEditingController c,String s, String pic){
    return Container(
      width: MediaQuery.of(context).size.width/3-16,
      height: 80,
      decoration: BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(pic),opacity: c.text.isEmpty?0.6:0.3)
      ),
      child: Center(child: c.text.isEmpty?Text(s,style: TextStyle(color: Colors.white),):Icon(Icons.verified,color: Colors.green,)),
    );
  }
}

class BorderPainter extends CustomPainter {
  final double progress;

  BorderPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..shader = SweepGradient(
        startAngle: 0,
        endAngle: 2 * pi,
        colors: [
          Colors.blue,
          Colors.purple,
          Colors.red,
          Colors.orange,
          Colors.yellow,
          Colors.green,
          Colors.blue,
        ],
        stops: [progress, progress + 0.2, progress + 0.4, progress + 0.6, progress + 0.8, 1.0, 1.0],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;

    final RRect rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(20),
    );

    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(BorderPainter oldDelegate) => true;
}

class Uiu extends StatefulWidget {
  const Uiu({super.key});

  @override
  State<Uiu> createState() => _UiuState();
}

class _UiuState extends State<Uiu>with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Timer _timer;
  int _counter = 0; // Variable to update UI
  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(milliseconds: 5000), (Timer t) {
      updateUI();
    });
    _controller = AnimationController(
      vsync: this,
      duration: Duration(microseconds: 5000),
    )..repeat();
  }
  void updateUI() {
    setState(() {
      _counter++; // Update UI
    });
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double w=MediaQuery.of(context).size.width;
    double h=MediaQuery.of(context).size.height;
    return Center(
      child: Stack(
        children: [
          Container(
            height:45,width:w-40,
            decoration:BoxDecoration(
              borderRadius:BorderRadius.circular(15),
              color:Colors.black,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.4), // Shadow color with transparency
                  spreadRadius: 5, // The extent to which the shadow spreads
                  blurRadius: 7, // The blur radius of the shadow
                  offset: Offset(0, 3), // The position of the shadow
                ),
              ],
            ),
            child: Center(child: Text("Generate",style:TextStyle(color:Colors.white))),
          ),
          CustomPaint(
            size: Size(w - 40, 45),
            painter: BorderPainter(progress: _controller.value),
          ),
        ],
      ),
    );
  }
}
