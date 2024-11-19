import 'package:flutter/material.dart';

class TreeComponent extends StatefulWidget {
  final String id;
  final String name;
  final List? children;
  final String? type;

  const TreeComponent({
    super.key,
    required this.id,
    required this.name,
    this.children,
    this.type,
  });

  @override
  State<TreeComponent> createState() => _TreeComponentState();
}

class _TreeComponentState extends State<TreeComponent> {
  final Map<String, dynamic> activeImages = {
    "location": "assets/images/location.png",
    "external": "assets/images/component.png",
    "active": "assets/images/active.png",
  };

  @override
  Widget build(BuildContext context) {
    return activeExternalAndComponent();
  }

  Widget activeExternalAndComponent() {
    // print(widget.children.runtimeType);
    final Map<String, dynamic> listPaddings = {
      "location": 0.0,
      "sublocation": 16.0,
      "active": 34.0,
      "subactive": 46.0,
      "subactiveComponent": 80.0,
      "external": 0.0,
    };

    switch (widget.type) {
      case "location":
        Padding(
          padding: EdgeInsets.only(left: listPaddings["location"], top: 5),
          child: Row(
            children: [
              const Icon(Icons.keyboard_arrow_down),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 3),
                child: Image(
                  image: AssetImage(
                    activeImages["location"],
                  ),
                  width: 24,
                  height: 24,
                ),
              ),
              Text(
                widget.name,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ),
            ],
          ),
        );

      case "ativo":
        break;
      case "external":
        break;
      default:
    }
    // Condição 1 se parentId for diferente de nulo
    if (widget.type == "location") {
      //  print(widget.children);
      return Padding(
        padding: EdgeInsets.only(left: listPaddings["location"], top: 5),
        child: Row(
          children: [
            const Icon(Icons.keyboard_arrow_down),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 3),
              child: Image(
                image: AssetImage(
                  activeImages["location"],
                ),
                width: 24,
                height: 24,
              ),
            ),
            Text(
              widget.name,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      );
    }
    if (widget.type == "location" && widget.children!.isEmpty) {
      return Padding(
        padding: EdgeInsets.only(left: listPaddings["sublocation"], top: 5),
        child: Row(
          children: [
            const Icon(Icons.keyboard_arrow_down),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 3),
              child: Image(
                image: AssetImage(
                  activeImages["location"],
                ),
                width: 24,
                height: 24,
              ),
            ),
            Text(
              "",
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      );
    }
    // else if(widget.type == "ativo"  && widget.children != []){
    //   print(widget.children);
    //   return Padding(
    //     padding: EdgeInsets.only(left: listPaddings["sublocation"], top: 5),
    //     child: Row(
    //       children: [
    //         const Icon(Icons.keyboard_arrow_down),
    //         Padding(
    //           padding: const EdgeInsets.only(left: 10, right: 3),
    //           child: Image(
    //             image: AssetImage(
    //               activeImages["location"],
    //             ),
    //             width: 24,
    //             height: 24,
    //           ),
    //         ),
    //         Text(
    //           "Subactive",
    //           style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
    //         ),
    //       ],
    //     ),
    // );
    // }
    // else if(widget.type == "ativo" && widget.children == []){
    //   print(widget.children);
    //   return Padding(
    //     padding: EdgeInsets.only(left: listPaddings["active"], top: 5),
    //     child: Row(
    //       children: [
    //         const Icon(Icons.keyboard_arrow_down),
    //         Padding(
    //           padding: const EdgeInsets.only(left: 10, right: 3),
    //           child: Image(
    //             image: AssetImage(
    //               activeImages["active"],
    //             ),
    //             width: 24,
    //             height: 24,
    //           ),
    //         ),
    //         Text(
    //           "Ativo location",
    //           style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
    //         ),
    //       ],
    //     ),
    //   );
    // }
    // if(widget.type == "ativo" && widget.children != []){
    //   print(widget.children);
    //   return Padding(
    //     padding: EdgeInsets.only(left: listPaddings["active"], top: 5),
    //     child: Row(
    //       children: [
    //         const Icon(Icons.keyboard_arrow_down),
    //         Padding(
    //           padding: const EdgeInsets.only(left: 10, right: 3),
    //           child: Image(
    //             image: AssetImage(
    //               activeImages["active"],
    //             ),
    //             width: 24,
    //             height: 24,
    //           ),
    //         ),
    //         Text(
    //           "Sublocation ativo",
    //           style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
    //         ),
    //       ],
    //     ),
    //   );
    // }

    //          - locationId diferente de nulo ele tem um ativo como pai

    // if (widget.locationId != widget.parentId) {
    //   return Padding(
    //     padding: EdgeInsets.only(left: listPaddings["sublocation"], top: 5),
    //     child: Row(
    //       children: [
    //         const Icon(Icons.keyboard_arrow_down),
    //         Padding(
    //           padding: const EdgeInsets.only(left: 10, right: 3),
    //           child: Image(
    //             image: AssetImage(
    //               activeImages["location"],
    //             ),
    //             width: 24,
    //             height: 24,
    //           ),
    //         ),
    //         Text(
    //           widget.name,
    //           style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
    //         ),
    //         // const Icon(
    //         //   Icons.bolt,
    //         //   color: Color(0xFF52C41A),
    //         //   size: 18,
    //         // ),
    //       ],
    //     ),
    //   );
    // }
    else {
      print(widget.children);
      return Padding(
        padding: const EdgeInsets.only(
          top: 5,
        ),
        child: Row(
          children: [
            const Icon(Icons.keyboard_arrow_down),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 3),
              child: Image(
                image: AssetImage(
                  activeImages["external"],
                ),
                width: 24,
                height: 24,
              ),
            ),
            Text(
              widget.name,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      );
    }
  }
}
