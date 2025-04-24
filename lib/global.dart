import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class Global{
  static Color blac = Color(0xff23262B);

  static void showMessage(BuildContext context,String str, bool green) async{
    await Flushbar(
      titleColor: Colors.white,
      message: "Lorem Ipsum is simply dummy text of the printing and typesetting industry",
      flushbarPosition: FlushbarPosition.BOTTOM,
      flushbarStyle: FlushbarStyle.FLOATING,
      reverseAnimationCurve: Curves.linear,
      forwardAnimationCurve: Curves.elasticOut,
      backgroundColor: green?Colors.green:Colors.red,
      boxShadows: [BoxShadow(color: Colors.blue, offset: Offset(0.0, 2.0), blurRadius: 3.0)],
      backgroundGradient: green?LinearGradient(colors: [Colors.green, Colors.green.shade400]):LinearGradient(colors: [Colors.red, Colors.redAccent.shade400]),
      isDismissible: false,
      duration: Duration(seconds: 3),
      icon: green? Icon(
        Icons.verified,
        color: Colors.white,
      ): Icon(
        Icons.warning,
        color: Colors.white,
      ),
      showProgressIndicator: true,
      progressIndicatorBackgroundColor: Colors.white,
      messageText: Text(
        str,
        style: TextStyle(fontSize: 16.0, color: Colors.white, fontFamily: "ShadowsIntoLightTwo"),
      ),
    ).show(context);
  }
  static Widget button(String s,double w,Color r){
    return Center(
      child: Container(
        height:45,width:w-40,
        decoration:BoxDecoration(
          borderRadius:BorderRadius.circular(7),
          color:r,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4), // Shadow color with transparency
              spreadRadius: 5, // The extent to which the shadow spreads
              blurRadius: 7, // The blur radius of the shadow
              offset: Offset(0, 3), // The position of the shadow
            ),
          ],
        ),
        child: Center(child: Text(s,style: TextStyle(
            color: Colors.black,
            fontFamily: "RobotoS",fontWeight: FontWeight.w800
        ),)),
      ),
    );
  }
}