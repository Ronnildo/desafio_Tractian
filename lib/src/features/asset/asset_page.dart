import 'package:flutter/material.dart';
import 'package:treeviewapp/service/tree_service.dart';
import 'package:treeviewapp/src/models/assets_model.dart';
import 'package:treeviewapp/src/models/childrens_model.dart';
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
  final TextEditingController _controller = TextEditingController();
  bool clickSensor = false;
  bool clickCritico = false;

  @override
  Widget build(BuildContext context) {
    // print(getLocation());
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_new,
            size: 24,
            color: Colors.white,
          ),
        ),
        title: const Text(
          "Assets",
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF17192D),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  size: 20,
                ),
                prefixIconColor: const Color(0xFF8E98A3),
                hintText: "Buscar Ativo ou Local",
                hintStyle: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF8E98A3),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: setColorClickSensor,
                  child: Container(
                    width: 150,
                    height: 40,
                    decoration: BoxDecoration(
                      color:
                          clickSensor ? Colors.blue : const Color(0xFFFFFFFF),
                      border: Border.all(
                        color: const Color(0xFF8E98A3),
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.bolt,
                          color: clickSensor
                              ? Colors.white
                              : const Color(0xFF8E98A3),
                        ),
                        Text(
                          "Sensor de Energia",
                          style: TextStyle(
                            color: clickSensor ? Colors.white : Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                InkWell(
                  onTap: setColorClickCritico,
                  child: Container(
                    width: 100,
                    height: 40,
                    decoration: BoxDecoration(
                      color:
                          clickCritico ? Colors.blue : const Color(0xFFFFFFFF),
                      border: Border.all(
                        color: const Color(0xFF8E98A3),
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.info,
                          color: clickCritico
                              ? Colors.white
                              : const Color(0xFF8E98A3),
                        ),
                        Text(
                          "Crítico",
                          style: TextStyle(
                            color: clickCritico ? Colors.white : Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Scrollbar(
            child: FutureBuilder(
              future: _treeService.listLocationAndActive(widget.companieId),
              builder: (context, snapshot) {
                // print(snapshot.data!.values);
                if (snapshot.hasData) {
                  var data = snapshot.data!.values;
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      var assets = data.toList();
                      // print(assets[index]);
                      TesteModel testeModel =
                          TesteModel.fromJson(assets[index]);
                      ChildrenFil external =
                          ChildrenFil.fromJson(assets[index]);
                      if (testeModel.childrens != null) {
                        Childrens? subloc = sublocations(testeModel.childrens!);
                        ChildrenFil comp = ChildrenFil.fromJson(assets[index]);
                        if (subloc != null) {
                          return ExpansionTile(
                              leading: const Image(
                                width: 24,
                                height: 24,
                                image: AssetImage(
                                  "assets/images/location.png",
                                ),
                              ),
                              title: Text(testeModel.name!),
                              children: testeModel.childrens!.map((e) {
                                return Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: ExpansionTile(
                                    leading: Image(
                                      width: 24,
                                      height: 24,
                                      image: (e.locationId != null &&
                                              e.parentId == null)
                                          ? const AssetImage(
                                              "assets/images/component.png",
                                            )
                                          : const AssetImage(
                                              "assets/images/location.png",
                                            ),
                                    ),
                                    trailing: null,
                                    title: Row(
                                      children: [
                                        Text(e.name!),
                                        (e.sensorId != null &&
                                                e.parentId == null &&
                                                e.locationId != null)
                                            ? Icon(
                                                e.status != "alert"
                                                    ? Icons.bolt
                                                    : Icons.circle,
                                                color: e.status == "alert"
                                                    ? const Color(0xFFED3833)
                                                    : Colors.green,
                                                size: 20,
                                              )
                                            : const Icon(null),
                                      ],
                                    ),
                                    children: e.childrens != null
                                        ? e.childrens!.map((c) {
                                            // if (c != null && c.childrens != []) {
                                            //   ChildrenFil? child = childFil(c.childrens!);
                                            // if (child != null) {
                                            // print(child.status);
                                            // print(child.parentId);

                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 40),
                                              child: Row(
                                                children: [
                                                  const Image(
                                                    width: 24,
                                                    height: 24,
                                                    image: AssetImage(
                                                      "assets/images/component.png",
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(c.name!),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      c.sensorId != null
                                                          ? Icon(
                                                              c.status ==
                                                                      "alert"
                                                                  ? Icons.circle
                                                                  : Icons.bolt,
                                                              color: c.status ==
                                                                      "alert"
                                                                  ? const Color(
                                                                      0xFFED3833)
                                                                  : Colors
                                                                      .green,
                                                              size: 20,
                                                            )
                                                          : const Icon(null),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            );

                                            // return Container();
                                          }).toList()
                                        : [],
                                  ),
                                );
                              }).toList());
                        }
                      }
                      if (external.status != null) {
                        return Container(
                          padding: const EdgeInsets.only(left: 20),
                          child: Row(
                            children: [
                              const Image(
                                width: 24,
                                height: 24,
                                image: AssetImage(
                                  "assets/images/component.png",
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(external.name!),
                              const Icon(
                                Icons.bolt,
                                color: Colors.green,
                              ),
                            ],
                          ),
                        );
                      }
                      // print(childrenFil!.id);
                      return ExpansionTile(
                        leading: const Image(
                          width: 24,
                          height: 24,
                          image: AssetImage(
                            "assets/images/location.png",
                          ),
                        ),
                        title: Text(external.name!),

                        // enabled: false,
                        dense: true,
                      );
                    },
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }

  setColorClickSensor() {
    if (clickSensor) {
      setState(() {
        clickSensor = false;
      });
    } else {
      setState(() {
        clickSensor = true;
      });
    }
  }

  setColorClickCritico() {
    if (clickCritico) {
      setState(() {
        clickCritico = false;
      });
    } else {
      setState(() {
        clickCritico = true;
      });
    }
  }

  sublocations(List sublocations) {
    for (int i = 0; i < sublocations.length;) {
      return sublocations[i];
    }
  }

  actives(List<Childrens> actives) {
    // print(actives[0].id);
    for (int i = 0; i <= actives.length;) {
      return actives[i];
    }
    return Childrens();
  }

  childFil(List<ChildrenFil> childrenFil) {
    for (int i = 0; i < childrenFil.length;) {
      return childrenFil[i];
    }
    // return childrenFil.name;
  }

  Future _getLocation() async {
    Map response = await _treeService.listLocationAndActive(widget.companieId);
    var data = response["locations"].toList().reversed;
    List locations = [];
    for (var i in data) {
      if (i["id"] == i["parendId"]) {
        print("True");
      }
      print(i);
      locations.add(i);
    }

    return locations;
  }
}
