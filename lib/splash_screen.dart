import 'dart:async';
import 'package:flutter/material.dart';
import 'package:musicplayer/MusicPages/SlidePage.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => SlidePage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.black,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                  child: Text(
                "Tune Ax",
                style: TextStyle(
                    fontSize: 100,
                    color: Colors.white,
                    fontFamily: "Gemunu",
                    fontWeight: FontWeight.w600),
              )),
              SizedBox(height: 100),
              Text(
                "Easely controll your music listening",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                    fontFamily: "Titil",
                    fontWeight: FontWeight.normal),
              ),
              SizedBox(height: 20),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              )
            ],
          ),
        ),
      ],
    );
  }
}


// class SplashScreen extends StatefulWidget {
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Timer(Duration(seconds: 3), () {
//       Navigator.of(context)
//           .pushReplacement(MaterialPageRoute(builder: (_) => SlidePage()));
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Container(
//         width: MediaQuery.of(context).size.width,
//         height: MediaQuery.of(context).size.height,
//         child: Image.asset(
//           "assets/Welcome To.png",
//           height: MediaQuery.of(context).size.height,
//           width: MediaQuery.of(context).size.width,
//           fit: BoxFit.cover,
//         ),
//       ),
//     );
//   }
// }
