import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:story_image_ai/cards/all_stories.dart';
import 'package:story_image_ai/first/login.dart';
import 'package:story_image_ai/first/profile.dart';
import 'package:story_image_ai/global.dart';
import 'package:story_image_ai/home/second/premium.dart';
import 'package:story_image_ai/home/second/settings_tts.dart';
import 'package:story_image_ai/model/user.dart';
import 'package:story_image_ai/provider/declare.dart';
import 'package:url_launcher/url_launcher.dart';

import '../main.dart';

class Settingss extends StatefulWidget {
   Settingss({super.key});

  @override
  State<Settingss> createState() => _SettingssState();
}

class _SettingssState extends State<Settingss> {


 Widget c(double w,String s,Widget r,String g){
   return Container(
     width: w/3-20,
     height: w/3-40,
     decoration: BoxDecoration(
         color:!isDarkModeEnabled? Global.blac:Colors.white,
         borderRadius: BorderRadius.circular(6),
         border: Border.all(color: Colors.black,width: 0.4)
     ),
     child: Padding(
       padding: const EdgeInsets.all(9.0),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Text(s,style: TextStyle(color:!isDarkModeEnabled?  Colors.white:Colors.black,fontSize: 12),),
           r,
           Spacer(),
           Row(
             children: [
               Spacer(),
               Text(g,style: TextStyle(color: !isDarkModeEnabled?  Colors.white:Colors.black,fontSize: 18),),
               SizedBox(width: 5,)
             ],
           )
         ],
       ),
     ),
   );
 }

   Widget c2(double w,String s,Widget r,String g){
     return Container(
       width: w/2-20,
       height: w/3-40,
       decoration: BoxDecoration(
         color: !isDarkModeEnabled? Global.blac:Colors.white,
         borderRadius: BorderRadius.circular(6),
         border: Border.all(color: Colors.black,width: 0.4)
       ),
       child: Padding(
         padding: const EdgeInsets.all(9.0),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Text(s,style: TextStyle(color:  !isDarkModeEnabled?  Colors.white:Colors.black,fontSize: 12),),
             r,
             Spacer(),
             Row(
               children: [
                 Spacer(),
                 Text(g,style: TextStyle(color:  !isDarkModeEnabled?  Colors.white:Colors.black,fontSize: 18),),
                 SizedBox(width: 5,)
               ],
             )
           ],
         ),
       ),
     );
   }

  @override
  Widget build(BuildContext context) {
    UserModel? _user = Provider.of<UserProvider>(context).getUser;
    double w=MediaQuery.of(context).size.width;
    double h=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: isDarkModeEnabled?Colors.white:Colors.black,
      body: Container(
        width: w,height: h,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/back.webp"),
                fit: BoxFit.cover,opacity: 0.1)
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 75,),
              InkWell(
                onTap: (){
                  Navigator.push(
                      context, PageTransition(
                      child: Profile(user: _user, update: true,), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 200)
                  ));
                },
                child: Center(
                  child: Container(
                    width: w-30,
                  decoration: BoxDecoration(
                    color:!isDarkModeEnabled? Global.blac:Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.black,width: 0.3
                    )
                  ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(_user!.pic),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(_user.name,style: TextStyle(color: isDarkModeEnabled?Colors.black:Colors.white,fontSize: 20,fontWeight: FontWeight.w700),),
                            Text(_user.email,style: TextStyle(color: isDarkModeEnabled?Colors.black:Colors.white,fontSize: 17,fontWeight: FontWeight.w400),),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10,),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                 children: [
                   InkWell(
                       onTap: (){
                         Navigator.push(
                             context, PageTransition(
                             child: Purchase(), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 200)
                         ));
                       },
                       child: c(w, "Subscription", Icon(Icons.diamond,color: !isDarkModeEnabled?  Colors.white:Colors.black,), "No")),
                   InkWell(
                       onTap: (){
                         Navigator.push(
                             context, PageTransition(
                             child: All_Stories(b: true,), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 200)
                         ));
                       },
                       child: c(w, "AI Stories", Icon(Icons.view_carousel,color: !isDarkModeEnabled?  Colors.white:Colors.black), "0")),
                   InkWell(
                       onTap: (){
                         Navigator.push(
                             context, PageTransition(
                             child: All_Stories(b: false,), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 200)
                         ));
                       },
                       child: c(w, "Public Post", Icon(Icons.remove_red_eye,color: !isDarkModeEnabled?  Colors.white:Colors.black), "0")),
                 ],
               ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                      onTap: () async {
                        setState(() {
                          isDarkModeEnabled=!isDarkModeEnabled;
                        });
                        final SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();
                        await asyncPrefs.setBool('night', !isDarkModeEnabled);
                      },
                      child: c2(w, "Night Light", Icon(Icons.nightlight,color: !isDarkModeEnabled?  Colors.white:Colors.black,), isDarkModeEnabled?"No":"Yes")),
                  InkWell(
                      onTap: (){
                        Navigator.push(
                            context, PageTransition(
                            child: TtsSettingsScreen(), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 200)
                        ));
                      },
                      child: c2(w, "Text to Speech", Icon(Icons.volume_up,color: !isDarkModeEnabled?  Colors.white:Colors.black), "No")),
                ],
              ),
               SizedBox(height: 10,),
              InkWell(
                onTap: (){
                  Navigator.push(
                      context, PageTransition(
                      child: Profile(user: _user, update: true,), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 200)
                  ));
                },
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                        color:isDarkModeEnabled?Colors.white: Global.blac,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)
                        ),
                        border: Border.all(
                            color: Colors.black,width: 0.3
                        )
                    ),
                    width: w-20,
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Row(
                        children: [
                          Icon(Icons.person,color:isDarkModeEnabled?Colors.black: Colors.white),
                          SizedBox(width: 7,),
                          Text("User Profile",style: TextStyle(color:isDarkModeEnabled?Colors.black: Colors.white,fontWeight: FontWeight.w500),)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                  onTap: () async {
                    Navigator.push(
                        context, PageTransition(
                        child: Purchase(), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 200)
                    ));
                  },
                  child: r(w,"Subscriptions", Icon(Icons.subscriptions,color:isDarkModeEnabled?Colors.black: Colors.white),)),
              InkWell(
                  onTap: () async {
                    final Uri _url = Uri.parse('https://sites.google.com/view/starwishterms/termscondition');
                    if (!await launchUrl(_url)) {
                      throw Exception('Could not launch $_url');
                    }
                  },
                  child: r(w,"Terms & Condition", Icon(Icons.language,color: isDarkModeEnabled?Colors.black:Colors.white),)),
              InkWell(
                  onTap: () async {
                    final Uri _url = Uri.parse('https://sites.google.com/view/starwishterms/privacy_policy');
                    if (!await launchUrl(_url)) {
                      throw Exception('Could not launch $_url');
                    }
                  },
                  child: r(w,"Privacy", Icon(Icons.privacy_tip,color:isDarkModeEnabled?Colors.black: Colors.white),)),
              InkWell(
                  onTap: () async {
                    try{
                      FirebaseAuth auth = FirebaseAuth.instance;
                      await auth.sendPasswordResetEmail(email: _user!.email);
                      Global.showMessage(context, "Reset Email Sended",true);
                    }catch(e){
                      Global.showMessage(context, "$e",false);
                    }
                  },
                  child: r(w,"ResetPassword", Icon(Icons.lock_reset,color: isDarkModeEnabled?Colors.black:Colors.white),)),
              InkWell(
                onTap: (){
                  FirebaseAuth auth = FirebaseAuth.instance;
                  auth.signOut().then((res) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) =>Login()),
                    );
                  });
                },
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                        color:isDarkModeEnabled?Colors.white: Global.blac,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)
                        ),
                        border: Border.all(
                            color: Colors.black,width: 0.3
                        )
                    ),
                    width: w-20,
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Row(
                        children: [
                          Icon(Icons.login,color: Colors.red),
                          SizedBox(width: 7,),
                          Text("Log Out",style: TextStyle(color: Colors.red,fontWeight: FontWeight.w500),)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 60,),
            ],
          ),
        ),
      ),
    );
  }

  Widget r1(double w, String str,Widget r,Widget r1)=>Center(
    child: Container(
      decoration: BoxDecoration(
        color: isDarkModeEnabled?Colors.white:Global.blac,
      ),
      width: w-20,
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Row(
          children: [
            r,
            SizedBox(width: 7,),
            Text(str,style: TextStyle(color:isDarkModeEnabled?Colors.black: Colors.white,fontWeight: FontWeight.w500),),
            Spacer(),
            r1,
          ],
        ),
      ),
    ),
  );

  Widget r(double w, String str,Widget r)=>Center(
    child: Container(
      decoration: BoxDecoration(
        color: isDarkModeEnabled?Colors.white:Global.blac,
          border: Border.all(
              color: Colors.black,width: 0.3
          )
      ),
      width: w-20,
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Row(
          children: [
            r,
            SizedBox(width: 7,),
            Text(str,style: TextStyle(color:isDarkModeEnabled?Colors.black: Colors.white,fontWeight: FontWeight.w500),)
          ],
        ),
      ),
    ),
  );
}
