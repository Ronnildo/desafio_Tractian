import 'package:flutter/material.dart';
import 'package:treeviewapp/service/tree_service.dart';
import 'package:treeviewapp/src/models/locations_model.dart';

class AssetPage extends StatefulWidget {
  final String companieId;
  const AssetPage({
    super.key,
    required this.companieId,
  });

  @override
  State<AssetPage> createState() => _AssetPageState();
}

class _AssetPageState extends State<AssetPage> {
  final TreeService _treeService = TreeService();
  @override
  Widget build(BuildContext context) {
    // print(getLocation());
    return Scaffold(
      appBar: AppBar(
        title: Text("Assets"),
      ),
      body: Column(
        children: [
          FutureBuilder(
            future: _treeService.listLocationAndActive(widget.companieId),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                int i = 0;
                var data = snapshot.data!.values;
                print(data);
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    List tes = data.toList();
                    if (tes[index]["childrens"] != null) {
                      int sublo = tes[index]["childrens"].length;
                      print(tes[index]["childrens"].toString());
                      return ExpansionTile(
                        leading: const Image(
                          width: 24,
                          height: 24,
                          image: AssetImage(
                            "assets/images/location.png",
                          ),
                        ),
                        title: Text(tes[index]["name"].toString()),
                        children: [
                          ExpansionTile(
                            leading: const Image(
                              width: 24,
                              height: 24,
                              image: AssetImage(
                                "assets/images/location.png",
                              ),
                            ),
                            title: i != sublo
                                ? Text(tes[index]["childrens"][i]["name"]
                                    .toString())
                                : const Text(""),
                            children: [
                              ExpansionTile(
                                leading: const Image(
                                  width: 24,
                                  height: 24,
                                  image: AssetImage(
                                    "assets/images/component.png",
                                  ),
                                ),
                                title: Text(""),
                              ),
                            ],
                          ),
                        ],
                      );
                    } else {
                      return ExpansionTile(
                        leading: const Image(
                          width: 24,
                          height: 24,
                          image: AssetImage(
                            "assets/images/component.png",
                          ),
                        ),
                        title: Text("locations.name!"),
                        children: [
                          ExpansionTile(
                              leading: const Image(
                                width: 24,
                                height: 24,
                                image: AssetImage(
                                  "assets/images/active.png",
                                ),
                              ),
                              title: Text(""))
                        ],
                      );
                    }
                  },
                );
              }
              return const CircularProgressIndicator();
            },
          ),
          // ExpansionTile(
          //   title: Text("Location"),
          //   leading: Image(
          //     width: 24,
          //     height: 24,
          //     image: AssetImage("assets/images/location.png"),
          //   ),
          //   children: <Widget>[
          //     ExpansionTile(
          //       title: Text("Sublocation"),
          //       leading: Image(
          //         width: 24,
          //         height: 24,
          //         image: AssetImage("assets/images/location.png"),
          //       ),
          //       children: [
          //         ExpansionTile(
          //           title: Text("Active"),
          //           leading: Image(
          //             width: 24,
          //             height: 24,
          //             image: AssetImage(
          //               "assets/images/active.png",
          //             ),
          //           ),
          //           children: [
          //             ExpansionTile(
          //               title: Text("Subactive"),
          //               leading: Image(
          //                 width: 24,
          //                 height: 24,
          //                 image: AssetImage(
          //                   "assets/images/active.png",
          //                 ),
          //               ),
          //               children: [
          //                 ListTile(
          //                   title: Text("Componente"),
          //                   leading: Image(
          //                     width: 24,
          //                     height: 24,
          //                     image: AssetImage(
          //                       "assets/images/active.png",
          //                     ),
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ],
          //         ),
          //       ],
          //     ),
          //   ],
          // ),
          // ExpansionTile(
          //   title: Text("Location"),
          //   leading: Image(
          //     width: 24,
          //     height: 24,
          //     image: AssetImage("assets/images/location.png"),
          //   ),
          // ),
          // ExpansionTile(
          //   title: Text("Active - External"),
          //   leading: Image(
          //     width: 24,
          //     height: 24,
          //     image: AssetImage(
          //       "assets/images/active.png",
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  Future _getLocation() async {
    Map response = await _treeService.listLocationAndActive(widget.companieId);
    var data = response["locations"].toList().reversed;
    List locations = [];
    for (var i in data) {
      if (i["id"] == i["parendId"]) {
        print("True");
      }
      print(i["id"]);
      locations.add(i);
    }

    return locations;
  }
}
