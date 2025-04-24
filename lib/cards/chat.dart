
import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:story_image_ai/global.dart';
import 'package:story_image_ai/home/second/settings_tts.dart';
import 'package:story_image_ai/model/story.dart';


class ChatStoryScreen extends StatefulWidget {
  final StoryModel story;

  ChatStoryScreen({required this.story});

  @override
  _ChatStoryScreenState createState() => _ChatStoryScreenState();
}

class _ChatStoryScreenState extends State<ChatStoryScreen> {
  late List<MessageModel> messages; // Use MessageModel for messages
  final ScrollController _scrollController = ScrollController();

  Future<void> gh() async {
    try {
      await FirebaseFirestore.instance
          .collection("Stories").doc(widget.story.id).update({
        "views": FieldValue.increment(1),
      });
    }catch(e){

    }
  }
  @override
  void initState() {
    jop();
    super.initState();
    gh();
    messages = widget.story.messages; // Directly use messages from StoryModel
    scrollToBottom();
    _loadSavedSettings();
  }
  void _initializeTts() {
    _flutterTts.setVolume(_volume);
    _flutterTts.setSpeechRate(_speechRate);
    _flutterTts.setPitch(_pitch);
  }
  Future<void> jop() async {
    final SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();
    bool away= await asyncPrefs.getBool('night')??false;
    int texsize=await asyncPrefs.getInt("textsize")??16;
    setState(() {
      ison=away;
      textsize=texsize;
    });
  }
  int textsize=16;
  void scrollToBottom() {
    Future.delayed(Duration(milliseconds: 300), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeOut,
        );
      }
    });
  }
  final FlutterTts _flutterTts = FlutterTts();

  double _volume = 0.5; // Default volume
  double _speechRate = 0.5; // Default speech rate
  double _pitch = 1.0; // Default pitch

  Future<void> _loadSavedSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _volume = prefs.getDouble('volume') ?? 0.5;
      _speechRate = prefs.getDouble('speechRate') ?? 0.5;
      _pitch = prefs.getDouble('pitch') ?? 1.0;
    });
  }
  Future<void> _t(String str) async {
    await _flutterTts.stop(); // Stop any ongoing speech before starting a new one
    await _flutterTts.speak(str);
  }
  bool ison=false;
  @override
  Widget build(BuildContext context) {
    double w=MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () async {
              await Navigator.push(
                  context, PageTransition(
                  child: TtsSettingsScreen(), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 200)
              ));
              _loadSavedSettings();
             },
            child: Icon(Icons.volume_up_sharp, color: Colors.blueAccent),
          ),
          SizedBox(width: 5,),
          InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    width: w,
                    color: Colors.white,
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Report Content',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: Colors.red),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(left: 18.0,right: 18),
                          child: Text('Report this Content to Admin. If found Offensive/Vulgar/Harmful Content, This Story will be Deleted.',textAlign: TextAlign.center,),
                        ),
                        SizedBox(height: 20),
                        InkWell(
                            onTap: () async {
                              try {
                                await FirebaseFirestore.instance.collection("Report").doc("Report_Doc").set({
                                  "ReportedStories":FieldValue.arrayUnion([widget.story.id]),
                                });
                                Navigator.pop(context);
                                Navigator.pop(context);
                                Global.showMessage(context, "Reported Successfully",true);
                              } catch (e) {
                                Navigator.pop(context);
                                Global.showMessage(context, "$e",true);
                              }
                            },
                            child:Center(child: Global.button("Report Now", w, Colors.yellow))),
                        SizedBox(height: 20),
                      ],
                    ),
                  );
                },
              );
            },
            child: Icon(Icons.report, color: Colors.red),
          ),
          SizedBox(width: 5,),
          InkWell(
            onTap: () {
              Share.share('Hello ! I got New App name *Star Wish AI Story Generator* that have many Stories from Romance to Horror ! Also you could make your Own Story by Gemini AI here. \n\nSo, What are you waiting for?\nDownload now from PlayStore');
            },
            child: Icon(Icons.share_outlined, color: Colors.blueAccent),
          ),
          SizedBox(width: 10,),
        ],
        title: Column(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundImage: NetworkImage(widget.story.picture), // Use the story picture
            ),
            Text(widget.story.char1, style: TextStyle(fontSize: 12, color: Colors.black)), // Show character name
          ],
        ),
        backgroundColor: Colors.grey.shade100,
        iconTheme: IconThemeData(
            color: Colors.blueAccent
        ),
      ),
      body: Container(
        color:ison?Colors.white: Colors.grey[900],
        child: widget.story.conversation_style?Column(
          children: [
            Expanded(
              child: messages.isEmpty
                  ? Center(
                child: Text("No messages yet!", style: TextStyle(color: Colors.white)),
              )
                  : ListView.builder(
                controller: _scrollController,
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return chatBubble(
                      messages[index].text,
                      messages[index].isMe,w
                  );
                },
              ),
            ),
          ],
        ):AlternateColorParagraph( widget.story.Story)
      )
    );
  }

  Widget AlternateColorParagraph(String paragraph){
    final lines = paragraph.trim().split(RegExp(r'\s{2,}'));

    return ListView.builder(
      itemCount: lines.length,
      itemBuilder: (context, index) {
        final isEven = index % 2 == 0;
        return Padding(
          padding: const EdgeInsets.only(left: 8.0,right: 8,top: 4),
          child: InkWell(
            onTap: (){
              _t(lines[index]);
            },
            child:lines[index]=="<br>"?SizedBox(): Container(
              decoration: BoxDecoration(
                  color:  Colors.white,
                  borderRadius: BorderRadius.circular(8)
              ),
              padding: const EdgeInsets.all(16.0),
              child: Text(
                lines[index],
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
  Widget chatBubble(String message, bool isMe,double w) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: InkWell(
        onTap: (){
          _t(message);
        },
        child: Container(
          width: w-55,
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: isMe ? Color(0xff49B5FD) : Color(0xffE6E5EB),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
              bottomLeft: isMe ? Radius.circular(16) : Radius.circular(0),
              bottomRight: isMe ? Radius.circular(0) : Radius.circular(16),
            ),
          ),
          child: Text(
            message,
            style: TextStyle(color:  !isMe ? Colors.black:Colors.white, fontSize: textsize.toDouble()),
          ),
        ),
      ),
    );
  }
}

