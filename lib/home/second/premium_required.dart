import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:story_image_ai/home/second/premium.dart';
import 'package:story_image_ai/model/send.dart';
class PremiumRequired extends StatefulWidget {
   PremiumRequired({super.key,required this.ed});
int ed;
  @override
  State<PremiumRequired> createState() => _PremiumRequiredState();
}

class _PremiumRequiredState extends State<PremiumRequired> {

  RewardedAd? _rewardedAd;
  bool _isAdLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadRewardedAd();
  }

  void _loadRewardedAd() {
    RewardedAd.load(
      adUnitId: 'ca-app-pub-4345035649216928/9116121857',
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          setState(() {
            _rewardedAd = ad;
            _isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (error) {
          debugPrint('Failed to load rewarded ad: $error');
        },
      ),
    );
  }

  void _showRewardedAd() async {
    if (_isAdLoaded && _rewardedAd != null) {
      _rewardedAd!.show(
        onUserEarnedReward: (ad, reward) async {
          // Reset quota after successful ad view
          final prefs = await SharedPreferences.getInstance();
          final currentTime = DateTime.now().millisecondsSinceEpoch;
          await prefs.setInt('usageCount', 0);
          await prefs.setInt('lastResetTime', currentTime);
          Navigator.pop(context); // Go back to the previous screen
          Send.message(context, "Done !", true);
        },
      );

      // Dispose of the ad after showing
      _rewardedAd!.dispose();
      _rewardedAd = null;
      setState(() {
        _isAdLoaded = false;
      });

      // Load a new ad
      _loadRewardedAd();
    } else {
      Navigator.pop(context);
      Send.message(context, "Ad not ready. Please try again later. !", false);
    }
  }

  @override
  void dispose() {
    _rewardedAd?.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double w=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("assets/expired.gif",height: 100,), SizedBox(height: 10,),
          Text("OOPs ! Today Quota Expired",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,),),
          Text("Either View an AD to once again Reset Quota or consider Premium Plan",textAlign: TextAlign.center,),
          SizedBox(height: 80,),
          InkWell(
            onTap: _showRewardedAd,
            child: Center(
              child: Container(
                  width: w - 26,
                  height: 55,
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
                      Icon(Icons.remove_red_eye),
                      SizedBox(width: 8,),
                      Text(
                        "View Ad",
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800, fontSize: 17),
                      ),
                    ],
                  )
              ),
            ),
          ),
          SizedBox(height: 10,),
          InkWell(
            onTap: (){
              Navigator.push(
                  context, PageTransition(
                  child: Purchase(), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 200)
              ));
            },
            child: Center(
              child: Container(
                  width: w - 26,
                  height: 55,
                  decoration: BoxDecoration(
                      color: Colors.orangeAccent,
                      border: Border.all(
                          color: Colors.orange,
                          width: 2.5
                      ),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.diamond),
                      SizedBox(width: 8,),
                      Text(
                        "Buy Premium",
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800, fontSize: 17),
                      ),
                    ],
                  )
              ),
            ),
          ),
        ],
      ),
    );
  }
}
