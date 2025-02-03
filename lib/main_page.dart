import 'package:flutter/material.dart';
import 'dart:io';

void main() => runApp(const MyApp());

/// main application widget
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'The Cookbook';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title),
          shape: Border(
              bottom: BorderSide(
                  color: Colors.black,
                  width: 4
              )
          ),
          elevation: 4,),
        body: ListWidget(),
      ),
    );
  }
}

/// stateful widget that the main application instantiates
class ListWidget extends StatefulWidget {
  const ListWidget({Key? key}) : super(key: key);

  @override
  State<ListWidget> createState() => _ListWidgetState();
}


class _ListWidgetState extends State<ListWidget> {
  @override
  Widget build(BuildContext context) {
    return
      Scaffold();
  }
}