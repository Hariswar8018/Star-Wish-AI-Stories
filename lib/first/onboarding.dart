import 'package:flutter_overboard/flutter_overboard.dart';
import 'package:flutter/material.dart';
import 'package:story_image_ai/first/login.dart';

class OnboardingPage extends StatefulWidget {
  OnboardingPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _globalKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      body: OverBoard(
        allowScroll: true,
        pages: pages,
        showBullets: true,
        inactiveBulletColor: Colors.blue,
        // backgroundProvider: NetworkImage('https://picsum.photos/720/1280'),
        skipCallback: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => Login()));
        },
        finishCallback: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => Login()));
        },
      ),
    );
  }

  final pages = [
    PageModel(
        color: const Color(0xFF0097A7),
        imageAssetPath: 'assets/watercolor-illustration-boy-girl-reading-books-370726961-Photoroom.png',
        title: 'Read Novels/Stories',
        body: 'We have 4+ Genere to choose Short Stories / Novels from ! Choose the one you like Most',
        doAnimateImage: true),
    PageModel(
        color: const Color(0xFF536DFE),
        imageAssetPath: 'assets/anxious-student-studying-with-calculator-books_1282444-261957-removebg-preview.png',
        title: 'Generate with AI',
        body: 'Got No Idea? No Problem ! Use our AI to Generate Stories',
        doAnimateImage: true),
    PageModel(
        color:  Colors.orange.shade500,
        imageAssetPath: 'assets/artificial-intelligence-concept-ai-chip-machine-learning-analysis-information-digital-brain-with-neural-network-chatbot-modern-flat-cartoon-style-illustration-on-white-background-vector-removebg-previ.png',
        title: 'New Machine Learning',
        body: 'Lazy ? Our Machine Learning Algorithm will choose the Best Story',
        doAnimateImage: true),
    PageModel(
        color: const Color(0xFF9B90BC),
        imageAssetPath: 'assets/cartoon-girl-listening-music-with-headphones-generative-ai_958098-16371-removebg-preview.png',
        title: 'Now use TTS',
        body: 'You could now Listen to Stories with our TTS',
        doAnimateImage: true),
    PageModel(
        color: Colors.indigo,
        imageAssetPath: 'assets/cartoon-girl-holding-stack-books-isolated-white_776894-192068-removebg-preview.png',
        title: 'Welcome to our App',
        body: 'Start into the World of Sci-Fiction, Fantasy, and Thriller',
        doAnimateImage: true),
  ];
}
