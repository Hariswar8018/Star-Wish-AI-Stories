import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:story_image_ai/main.dart';

class TtsSettingsScreen extends StatefulWidget {
  @override
  _TtsSettingsScreenState createState() => _TtsSettingsScreenState();
}

class _TtsSettingsScreenState extends State<TtsSettingsScreen> {
  final FlutterTts _flutterTts = FlutterTts();

  double _volume = 0.5; // Default volume
  double _speechRate = 0.5; // Default speech rate
  double _pitch = 1.0; // Default pitch

  String _testText = "This is a test of your TTS settings.";

  @override
  void initState() {
    super.initState();
    _loadSavedSettings();
  }
  Future<void> _loadSavedSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _volume = prefs.getDouble('volume') ?? 0.5;
      _speechRate = prefs.getDouble('speechRate') ?? 0.5;
      _pitch = prefs.getDouble('pitch') ?? 1.0;
    });
  }
  void _initializeTts() {
    _flutterTts.setVolume(_volume);
    _flutterTts.setSpeechRate(_speechRate);
    _flutterTts.setPitch(_pitch);
  }

  void _updateTtsSettings() {
    _flutterTts.setVolume(_volume);
    _flutterTts.setSpeechRate(_speechRate);
    _flutterTts.setPitch(_pitch);
  }

  Future<void> _testSpeech() async {
    await _flutterTts.stop(); // Stop any ongoing speech before starting a new one
    await _flutterTts.speak(_testText);
  }
  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('volume', _volume);
    await prefs.setDouble('speechRate', _speechRate);
    await prefs.setDouble('pitch', _pitch);
  }
  Future<bool> _onWillPop() async {
    await _saveSettings();
    return true; // Allow the back navigation
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: isDarkModeEnabled?Colors.white:Colors.black,
        appBar: AppBar(
          backgroundColor: isDarkModeEnabled?Colors.white:Colors.black,
          iconTheme: IconThemeData(
            color: isDarkModeEnabled?Colors.black:Colors.white
          ),
          title: Text("TTS Settings",style: TextStyle(color: isDarkModeEnabled?Colors.black:Colors.white),),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Volume",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,color: isDarkModeEnabled?Colors.black:Colors.white),
              ),
              Slider(
                value: _volume,
                onChanged: (value) {
                  setState(() {
                    _volume = value;
                    _updateTtsSettings();
                  });
                },
                min: 0.0,
                max: 1.0,
                divisions: 10,
                label: _volume.toStringAsFixed(1),
              ),
              const SizedBox(height: 10),
              Text(
                "Speech Rate",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,color: isDarkModeEnabled?Colors.black:Colors.white),
              ),
              Slider(
                value: _speechRate,
                onChanged: (value) {
                  setState(() {
                    _speechRate = value;
                    _updateTtsSettings();
                  });
                },
                min: 0.0,
                max: 1.0,
                divisions: 10,
                label: _speechRate.toStringAsFixed(1),
              ),
              const SizedBox(height: 10),
              Text(
                "Pitch",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,color: isDarkModeEnabled?Colors.black:Colors.white),
              ),
              Slider(
                value: _pitch,
                onChanged: (value) {
                  setState(() {
                    _pitch = value;
                    _updateTtsSettings();
                  });
                },
                min: 0.5,
                max: 2.0,
                divisions: 15,
                label: _pitch.toStringAsFixed(1),
              ),
              const SizedBox(height: 20),

              InkWell(
                onTap: _testSpeech,
                child: Center(
                  child: Container(
                      width: MediaQuery.of(context).size.width-40,
                      height: 60,
                      decoration: BoxDecoration(
                          color: Colors.yellowAccent,
                          border: Border.all(
                              color: Colors.yellowAccent,
                              width: 2.5
                          ),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.volume_up_sharp,color: Colors.black),
                          SizedBox(width: 8,),
                          Text(
                            "Test Speech",
                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800, fontSize: 17),
                          ),
                        ],
                      )
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _flutterTts.stop(); // Stop TTS when leaving the screen
    super.dispose();
  }
}
