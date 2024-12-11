import 'package:flutter/material.dart';

class ActiveComponent extends StatefulWidget {
  final String name;
  final String status;
  const ActiveComponent({
    super.key,
    required this.name,
    required this.status,
  });

  @override
  State<ActiveComponent> createState() => _ActiveComponentState();
}

class _ActiveComponentState extends State<ActiveComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, top: 10, bottom: 10),
      child: Row(
        children: [
          const Image(image: AssetImage("assets/images/component.png"), height: 20,),
          const SizedBox(
            width: 10,
          ),
          Text(widget.name),
          Icon(
            widget.status == "alert" ? Icons.circle : Icons.bolt,
            color: widget.status == "alert" ? Colors.red : Colors.green,
            size: 20,
          ),
        ],
      ),
    );
  }
}
