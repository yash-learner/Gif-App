import 'package:flutter/material.dart';
import 'package:gitsearche/gify_deno_hacko.dart';
void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gif Search Engine',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HackOnPage(),
    );
  }
}