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
          //<a href="https://www.flaticon.com/free-icons/to-do-list" title="to do list icons">To do list icons created by ultimatearm - Flaticon</a>
          children: [
            Image.asset('assets/to-do-list.png',
            height: 50,
            width: 50,),

            SizedBox(
              height: 5,
            ),
            Text('My Wishlist',
              style: TextStyle(fontSize:25, fontWeight: FontWeight.bold),)
          ],
        ),
      ),
    );
  }
}

