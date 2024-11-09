import 'package:flutter/material.dart';

class TreeComponent extends StatefulWidget {
  final String text;
  final String image;
  final double padding;

  const TreeComponent(
      {super.key,
      required this.text,
      required this.padding,
      required this.image});

  @override
  State<TreeComponent> createState() => _TreeComponentState();
}

class _TreeComponentState extends State<TreeComponent> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: widget.padding, top: 10),
        child: activeExternalAndComponent(widget.padding));
  }

  Widget activeExternalAndComponent(double active) {
    if (active == 80.0) {
      return Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 3),
            child: Image(
              image: AssetImage(
                widget.image,
              ),
              width: 24,
              height: 24,
            ),
          ),
          Text(
            widget.text,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
          ),
          const Icon(
            Icons.bolt,
            color: Color(0xFF52C41A),
            size: 18,
          ),
        ],
      );
    }else if(active == 0.0 && widget.image.split("/")[2].contains("active")){
      return Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 5),
            child: Image(
              image: AssetImage(
                widget.image,
              ),
              width: 24,
              height: 24,
            ),
          ),
          Text(
            widget.text,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
          ),
          const Icon(
            Icons.bolt,
            color: Color(0xFF52C41A),
            size: 18,
          ),
        ],
      );
    } else {
      return Row(
        children: [
          const Icon(Icons.keyboard_arrow_down),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 3),
            child: Image(
              image: AssetImage(
                widget.image,
              ),
              width: 24,
              height: 24,
            ),
          ),
          Text(
            widget.text,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
          ),
        ],
      );
    }
  }
}
