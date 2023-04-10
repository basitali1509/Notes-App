import 'package:flutter/material.dart';
import 'package:notes_app/Controller/splash_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashScreenController splashScreenController = SplashScreenController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashScreenController.SplashTime(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(

        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              height: 100,
              width: 100,
              child: Image(
                color: Colors.redAccent,
                  image: AssetImage('images/notes_icon_100.png')),),
          ),
          SizedBox(height: 15,),
          Text('Take Notes', style: TextStyle(color: Colors.redAccent, fontSize: 24, fontWeight: FontWeight.w400),),

          SizedBox(height: 100,),
          Center(child: CircularProgressIndicator(
            color: Colors.redAccent, ))
        ],
      ),
    );
  }
}
