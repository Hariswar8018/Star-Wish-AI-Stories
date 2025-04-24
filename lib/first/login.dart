import 'dart:async';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:page_transition/page_transition.dart';
import 'package:story_image_ai/first/forgot.dart';
import 'package:story_image_ai/first/profile.dart';
import 'package:story_image_ai/global.dart';
import 'package:story_image_ai/main.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';

import '../model/user.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  int i = 0; // Track the index

  @override
  void initState() {
    super.initState();
    f(); // Start the timer
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool b=false;
  @override
  Widget build(BuildContext context) {
    double h=MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        if(b){
          setState(() {
            b=false;
          });
          return false;
        }else{
          return true;
        }
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: b?Container(
          width: w,height: h,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/back.webp"),
                  fit: BoxFit.cover,
                  opacity: 0.1
              ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 10),
              Image.asset("assets/hhh.png", width: w),
              SizedBox(height: 8),
              signup?fg(name, "Your Name", ""):SizedBox(),
              fg(email, "Your Email", ""),
              fg(password, "Your Password", ""),
              SizedBox(height: 5),
              progress?Center(child: CircularProgressIndicator(backgroundColor: Colors.grey,)):InkWell(
                onTap: () async {
                  setState(() {
                    progress=true;
                  });
                  if(signup){
                    try{
                      final us=await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email.text, password: password.text);
                      UserModel user=UserModel(name: name.text,
                          email: email.text, position: "", no: 0, uid: us.user!.uid,
                          pic: "", school: "", other1: "", other2: "");
                      await FirebaseFirestore.instance.collection("users").doc(us.user!.uid).set(user.toJson());
                      Navigator.push(
                          context, PageTransition(
                          child: Profile(user: user, update: false,), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 200)
                      ));
                      Global.showMessage(context, "SignUp Successful",true);
                    }catch(e){
                      Global.showMessage(context, "$e",false);
                    }
                  }else{
                    try{
                      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email.text, password: password.text);
                      Navigator.push(
                          context, PageTransition(
                          child: MyHomePage(title: '',), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 200)
                      ));
                      Global.showMessage(context, "LoggedIn Successful",true);
                    }catch(e){
                      Global.showMessage(context, "$e",false);
                    }
                  }
                  setState(() {
                    progress=false;
                  });
                },
                child:Center(
                  child: Container(
                    width: w - 26,
                    height: 55,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: Colors.yellowAccent,
                            width: 2.5
                        ),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/email.jpg",height: 25,),
                        SizedBox(width: 8,),
                        Text(
                          "Continue with Email",
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800, fontSize: 17),
                        ),
                      ],
                    )
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 13,),
                  TextButton(onPressed: () {
                    setState(() {
                      if(signup){
                        signup=false;
                      }else{
                        signup=true;
                      }
                    });
                  }, child: Text(signup?"Not New? Login ":"New User? Sign Up here",style: TextStyle(color: Colors.white),),),
                  Spacer(),
                  TextButton(onPressed: () {
                    Navigator.push(
                        context, PageTransition(
                        child: Forgot(), type: PageTransitionType.topToBottom, duration: Duration(milliseconds: 800)
                    ));
                  }, child: Text("Forgot Password?",style: TextStyle(color: Colors.white),),),
                  SizedBox(width: 13,),
                ],
              ),
            ],
          ),
        ):Container(
          width: w,height: h,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/back.webp"),
                fit: BoxFit.cover,
                opacity: 0.1
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  children: [
                    Spacer(),
                    Container(
                      width: 80,
                      height: 30,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          border: Border.all(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                          )),
                      child: Text("       "),
                    ),
                    SizedBox(width: 10),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    SizedBox(width: 10),
                    Container(
                      width: 50,
                      height: 30,
                      decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          border: Border.all(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            topLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          )),
                      child: Text(" "),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Spacer(),
                  d(1),
                  d(2),
                  d(3),d(4),
                  SizedBox(width: 10),
                ],
              ),
              SizedBox(height: 15),
              Image.asset("assets/hhh.png", width: w),
              SizedBox(height: 15),
              Text("Let's Login to your Account",style: TextStyle(color: Colors.white,fontSize:20,fontWeight: FontWeight.w700),),
              Text("Account help us to view History and Recommend Better",style: TextStyle(color: Colors.white,fontSize:13,fontWeight: FontWeight.w400),),
              SizedBox(height: 15),
              InkWell(
                onTap: (){
                  setState(() {
                    b=true;
                  });
                },
                child:Center(
                  child: Container(
                      width: w - 26,
                      height: 55,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              color: Colors.yellowAccent,
                              width: 2.5
                          ),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/email.jpg",height: 25,),
                          SizedBox(width: 8,),
                          Text(
                            "Email",
                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800, fontSize: 17),
                          ),
                        ],
                      )
                  ),
                ),
              ),
              SizedBox(height: 10,),
              progress?SizedBox():InkWell(
                onTap: () async{
                  setState(() {
                    progress=true;
                  });
                  try {
                    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
                    final GoogleSignInAuthentication googleAuth = await googleUser!
                        .authentication;
                    final AuthCredential credential = GoogleAuthProvider
                        .credential(
                      accessToken: googleAuth.accessToken,
                      idToken: googleAuth.idToken,
                    );
                    final user = await FirebaseAuth.instance.signInWithCredential(credential);
                    String uid = await FirebaseAuth.instance.currentUser!.uid;
                    String emaill = await FirebaseAuth.instance.currentUser!.email??"";
      
                    try{
                      UserModel user=UserModel(name: name.text,
                          email: emaill, position: "", no: 0, uid: uid,
                          pic: "", school: "", other1: "", other2: "");
                      await FirebaseFirestore.instance.collection("users").doc(uid).set(user.toJson());
                      Navigator.push(
                          context, PageTransition(
                          child: Profile(user: user, update: false,), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 200)
                      ));
                      Global.showMessage(context, "SignUp Successful",true);
                    }catch(e){
                      Global.showMessage(context, "$e", false);
                    }
                    Navigator.push(
                        context, PageTransition(
                        child: MyHomePage(title: '',), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 200)
                    ));
                  }catch(e){
                    print(e);
                    Global.showMessage(context, "$e", false);
                  }
                  setState(() {
                    progress=false;
                  });
                },
                child:Center(
                  child: Container(
                      width: w - 26,
                      height: 55,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              color: Colors.yellowAccent,
                              width: 2.5
                          ),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/google.webp",height: 25,),
                          SizedBox(width: 8,),
                          Text(
                            "Google",
                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800, fontSize: 17),
                          ),
                        ],
                      )
                  ),
                ),
              ),
              SizedBox(height: 10,),
              progress?SizedBox():Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () async{
                      setState(() {
                        progress=true;
                      });
                      try {
                        final FirebaseAuth auth = FirebaseAuth.instance;
      
                        final String? githubToken = await getGitHubToken(); // Implement this method
      
                        if (githubToken == null) {
                          throw Exception("Failed to retrieve GitHub token");
                        }
                        final AuthCredential credential = GithubAuthProvider.credential(githubToken);
                        final UserCredential userCredential =
                        await auth.signInWithCredential(credential);
      
                        String uid=userCredential.user!.uid;
                        String emaill=userCredential.user!.email??"Github Email";
                        try{
                          UserModel user=UserModel(name: name.text,
                              email: emaill, position: "", no: 0, uid: uid,
                              pic: "", school: "", other1: "", other2: "");
                          await FirebaseFirestore.instance.collection("users").doc(uid).set(user.toJson());
                          Navigator.push(
                              context, PageTransition(
                              child: Profile(user: user, update: false,), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 200)
                          ));
                          Global.showMessage(context, "SignUp Successful",true);
                        }catch(e){
                          Global.showMessage(context, "$e", false);
                        }
                        Navigator.push(
                            context, PageTransition(
                            child: MyHomePage(title: '',), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 200)
                        ));
                      }catch(e){
                        print(e);
                        Global.showMessage(context, "$e", false);
                      }
                      setState(() {
                        progress=false;
                      });
                    },
                    child:Center(
                      child: Container(
                          width: w/2 - 19,
                          height: 55,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: Colors.yellowAccent,
                                  width: 2.5
                              ),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset("assets/github.png",height: 25,),
                              SizedBox(width: 8,),
                              Text(
                                "GitHub",
                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800, fontSize: 17),
                              ),
                            ],
                          )
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async{
                      setState(() {
                        progress=true;
                      });
                      try {
                        final FirebaseAuth auth = FirebaseAuth.instance;

                        // Replace these with your Azure app credentials
                        final clientId = "";
                        final redirectUri = "https://heaven-on-this-e-1673398261366.firebaseapp.com/__/auth/handler";
                        final authUrl =
                            "https://login.microsoftonline.com/common/oauth2/v2.0/authorize"
                            "?client_id=$clientId"
                            "&response_type=code"
                            "&redirect_uri=$redirectUri"
                            "&response_mode=query"
                            "&scope=User.Read";

                        // Authenticate the user
                        final result = await FlutterWebAuth.authenticate(
                          url: authUrl,
                          callbackUrlScheme: "https",
                        );

                        // Extract the authorization code
                        final code = Uri.parse(result).queryParameters['code'];

                        if (code == null) {
                          throw Exception("Authorization failed");
                        }

                        // Exchange code for access token (implement this logic in your backend or client-side)
                        final accessToken = await exchangeCodeForAccessTokenn(code, clientId, redirectUri);

                        // Sign in with the obtained access token
                        final AuthCredential credential = OAuthProvider("microsoft.com").credential(
                          accessToken: accessToken,
                        );

                        final UserCredential userCredential =
                        await auth.signInWithCredential(credential);

                        final user = await FirebaseAuth.instance.signInWithCredential(credential);
                        String uid = await FirebaseAuth.instance.currentUser!.uid;
                        String emaill = await FirebaseAuth.instance.currentUser!.email??"";
      
                        try{
                          UserModel user=UserModel(name: name.text,
                              email: emaill, position: "", no: 0, uid: uid,
                              pic: "", school: "", other1: "", other2: "");
                          await FirebaseFirestore.instance.collection("users").doc(uid).set(user.toJson());
                          Navigator.push(
                              context, PageTransition(
                              child: Profile(user: user, update: false,), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 200)
                          ));
                          Global.showMessage(context, "SignUp Successful",true);
                        }catch(e){
                          Global.showMessage(context, "$e", false);
                        }
                        Navigator.push(
                            context, PageTransition(
                            child: MyHomePage(title: '',), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 200)
                        ));
                      }catch(e){
                        print(e);
                        Global.showMessage(context, "$e", false);
                      }
                      setState(() {
                        progress=false;
                      });
                    },
                    child:Center(
                      child: Container(
                          width: w/2 - 19,
                          height: 55,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: Colors.yellowAccent,
                                  width: 2.5
                              ),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset("assets/Microsoft_Logo_512px.png",height: 25,),
                              SizedBox(width: 8,),
                              Text(
                                "Microsoft",
                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800, fontSize: 17),
                              ),
                            ],
                          )
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<String> exchangeCodeForAccessTokenn(String code, String clientId, String redirectUri) async {
    final response = await http.post(
      Uri.parse("https://login.microsoftonline.com/common/oauth2/v2.0/token"),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'client_id': clientId,
        'grant_type': 'authorization_code',
        'code': code,
        'redirect_uri': redirectUri,
        'client_secret': '<Your-Microsoft-Client-Secret>',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['access_token'];
    } else {
      throw Exception("Failed to exchange code for token");
    }
  }
  Future<String?> getGitHubToken() async {
    final clientId = "";
    final redirectUri = "https://heaven-on-this-e-1673398261366.firebaseapp.com/__/auth/handler";

    final authUrl =
        "https://github.com/login/oauth/authorize?client_id=$clientId&redirect_uri=$redirectUri&scope=read:user user:email";

    final result = await FlutterWebAuth.authenticate(
      url: authUrl,
      callbackUrlScheme: "https",
    );

    final code = Uri.parse(result).queryParameters['code'];

    // Exchange code for access token (implement your backend for this)
    final accessToken = await exchangeCodeForAccessToken(code!);
    return accessToken;
  }

  Future<String> exchangeCodeForAccessToken(String code) async {
    // Use your server or GitHub API to exchange the code for an access token
    throw UnimplementedError("Implement the exchange logic");
  }

  bool progress=false;
  bool signup=false;
  Widget fg(TextEditingController ha, String str, String str2) => Padding(
    padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 10),
    child: TextFormField(
      controller: ha,
      keyboardType: TextInputType.text,
      style: TextStyle(color: Colors.white), // ✅ Makes typed text white
      decoration: InputDecoration(
        labelText: str,
        labelStyle: TextStyle(color: Colors.white), // ✅ Makes label text white
        hintText: str2,
        hintStyle: TextStyle(color: Colors.white70), // ✅ Makes hint text white with slight opacity
        isDense: true,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white), // ✅ White border
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white), // ✅ White border when not focused
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 2.0), // ✅ Thicker white border when focused
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


  TextEditingController name=TextEditingController();
  TextEditingController email=TextEditingController();
  TextEditingController verify=TextEditingController();
  TextEditingController password=TextEditingController();
  Widget d(int j) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(
        width: 9,
        height: 9,
        decoration: BoxDecoration(shape: BoxShape.circle, color: i != j ? Colors.white : Colors.grey),
      ),
    );
  }

  void f() {
    Timer.periodic(Duration(milliseconds: 300), (timer) {
      setState(() {
        if (i >= 5) {
          i = 0; // Reset to 1
        } else {
          i++;
        }
      });
    });
  }
}
