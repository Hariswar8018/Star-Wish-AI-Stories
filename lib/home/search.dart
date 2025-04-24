import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:story_image_ai/cards/chat.dart';
import 'package:story_image_ai/home/second/all_stories.dart';
import 'package:story_image_ai/model/story.dart';

import '../main.dart';

class Search extends StatelessWidget {
  Search({super.key});
  TextEditingController text=TextEditingController();
  @override
  Widget build(BuildContext context) {
    double w=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor:isDarkModeEnabled?Colors.white: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: Container(
          width: w-15,height: 45,
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 10,bottom: 6.0,top: 9,right: 12),
            child: TextFormField(
              controller: text,
              decoration: InputDecoration(
                  hintText:" Search Stories",
                  prefixIcon: Icon(Icons.search,color: Colors.blue,),
                  border: InputBorder.none
              ),
              onFieldSubmitted: (String s){
                Navigator.push(
                    context, PageTransition(
                    child: All_Stories(name: s,on:true), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 200)
                ));
              },
              onSaved: ( str){
                String s=str??"None Genere typed";
                Navigator.push(
                    context, PageTransition(
                    child: All_Stories(name: s,on:true), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 200)
                ));
              },
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 12.0,right: 12,top: 15),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("Stories").orderBy("views",descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
              case ConnectionState.none:
                return Center(child: CircularProgressIndicator());
              case ConnectionState.active:
              case ConnectionState.done:
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text("No stories available",style: TextStyle(color: isDarkModeEnabled?Colors.black:Colors.white),));
                }
                List<StoryModel> stories = snapshot.data!.docs.map((doc) => StoryModel.fromJson(doc.data() as Map<String, dynamic>)).toList();
                return GridView.builder(
                  scrollDirection: Axis.vertical, // Scroll vertically
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // 3 items per row
                    crossAxisSpacing: 8.0, // Spacing between columns
                    mainAxisSpacing: 20.0, // Spacing between rows
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
}
