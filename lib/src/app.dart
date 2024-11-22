import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:treeviewapp/src/features/home/home_page.dart';
import 'package:treeviewapp/src/service/tree_service.dart';

class TreeViewApp extends StatelessWidget {
  const TreeViewApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TreeService(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}