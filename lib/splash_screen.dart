import 'dart:async';
import 'package:flutter/material.dart';
import 'package:list_maker/main_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    super.initState();
    Timer(Duration(milliseconds: 2500),()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> MyApp())));

  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //Legally obliged to say this I believe, so
          //https://www.flaticon.com/free-icons/food-and-restaurantFood and restaurant icons created by Freepik - Flaticon</a>
          children: [
            Image.asset('assets/frying-pan.png',
            height: 50,
            width: 50,),

            SizedBox(
              height: 5,
            ),
            Text('The Cookbook',
              style: TextStyle(fontSize:25, fontWeight: FontWeight.bold),)
          ],
        ),
      ),
    );
  }
}

