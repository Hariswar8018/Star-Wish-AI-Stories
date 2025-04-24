import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:story_image_ai/cards/chat.dart';
import 'package:story_image_ai/model/story.dart';

import '../main.dart';

class All_Stories extends StatefulWidget {
  bool b;
   All_Stories({super.key,required this.b});

  @override
  State<All_Stories> createState() => _All_StoriesState();
}

class _All_StoriesState extends State<All_Stories> {
  @override
  Widget build(BuildContext context) {
    double w=MediaQuery.of(context).size.width;
    double h=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: isDarkModeEnabled?Colors.white:Colors.black,
      appBar: AppBar(
        backgroundColor: isDarkModeEnabled?Colors.white:Colors.black,
        iconTheme: IconThemeData(
          color:  !isDarkModeEnabled?Colors.white:Colors.black
        ),
        title: Text("My Stories",style: TextStyle(color: !isDarkModeEnabled?Colors.white:Colors.black,),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future:widget.b? FirebaseFirestore.instance
              .collection("users")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('Stories').orderBy("id",descending:true).get():FirebaseFirestore.instance
              .collection("usehkhkllkhrs")
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
                return GridView.builder(
                  scrollDirection: Axis.vertical, // Scroll vertically
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // 3 items per row
                    crossAxisSpacing: 3.0, // Spacing between columns
                    mainAxisSpacing: 7.0, // Spacing between rows
                    childAspectRatio: 0.7, // Adjust to maintain good card proportions
                  ),
                  itemCount: stories.length,
                  itemBuilder: (context, index) {
                    StoryModel story = stories[index];
                    return InkWell(
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
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5), // Rounded corners
                          border: Border.all(
                            color: Colors.white,
                          ),
                          image: DecorationImage(
                            image: NetworkImage(story.picture), // Use the picture from StoryModel
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                );
            }
          },
        ),
      ),
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
}
