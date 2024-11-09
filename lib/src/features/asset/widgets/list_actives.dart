import 'package:flutter/material.dart';
import 'package:treeviewapp/src/features/asset/widgets/tree.dart';

class ListActives extends StatefulWidget {
  final String text;
  const ListActives({super.key, required this.text});

  @override
  State<ListActives> createState() => _ListActivesState();
}

class _ListActivesState extends State<ListActives> {
  final Map<String, dynamic> activeImages = {
    "location": "assets/images/location.png",
    "external": "assets/images/external.png",
    "active": "assets/images/active.png",
  };

  final Map<String, dynamic> listPaddings = {
    "location": 0.0,
    "sublocation": 16.0,
    "active": 34.0,
    "subactive": 46.0,
    "subactiveComponent": 80.0,
    "external": 0.0,
  };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          TreeComponent(text: widget.text, padding: listPaddings["location"], image: activeImages["location"]),
          TreeComponent(text: widget.text, padding: listPaddings["sublocation"], image: activeImages["location"]),
          TreeComponent(text: widget.text, padding: listPaddings["active"], image: activeImages["active"]),
          TreeComponent(text: widget.text, padding: listPaddings["subactive"], image: activeImages["active"]),
          TreeComponent(text: "MOTOR RT COAL AF01", padding: listPaddings["subactiveComponent"], image: activeImages["active"]),
          TreeComponent(text: "Fan - External", padding: listPaddings["external"], image: activeImages["active"]),
          
        ],
      ),
    );
  }
}
