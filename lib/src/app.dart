import 'package:flutter/material.dart';
import 'package:treeviewapp/src/features/home/home_page.dart';

class TreeViewApp extends StatelessWidget {
  const TreeViewApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}