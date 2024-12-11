import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:treeviewapp/src/features/asset/widgets/active.dart';
import 'package:treeviewapp/src/service/tree_service.dart';
import 'package:treeviewapp/src/models/childrens_model.dart';

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
  // final TreeService _treeService = TreeService();
  final TextEditingController _controller = TextEditingController();
  bool clickEnergy = false;
  bool clickCritico = false;

  @override
  void initState() {
    Provider.of<TreeService>(context, listen: false)
        .listLocationAndActive(widget.companieId);
    super.initState();
  }

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
              child: TextField(
                controller: _controller,
                onSubmitted: (e){
                  Provider.of<TreeService>(context, listen: false).filterInputActive(widget.companieId, e);
                },
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
                    onTap: clickSensorEnergy,
                    child: Container(
                      width: 150,
                      height: 40,
                      decoration: BoxDecoration(
                        color:
                            clickEnergy ? Colors.blue : const Color(0xFFFFFFFF),
                        border: Border.all(
                          color: const Color(0xFF8E98A3),
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.bolt,
                            color: clickEnergy
                                ? Colors.white
                                : const Color(0xFF8E98A3),
                          ),
                          Text(
                            "Sensor de Energia",
                            style: TextStyle(
                              color: clickEnergy ? Colors.white : Colors.black,
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
                    onTap: clickSensorAlert,
                    child: Container(
                      width: 100,
                      height: 40,
                      decoration: BoxDecoration(
                        color: clickCritico
                            ? Colors.blue
                            : const Color(0xFFFFFFFF),
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
              child: Consumer<TreeService>(
                builder: (context, value, child) {
                  var data = value.data.values.toList();
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        // print(data);
                        TreeModel tree = TreeModel.fromJson(data[index]);
                        if (data[index]["sensorId"] != null) {
                          return ActiveComponent(
                              name: data[index]["name"],
                              status: data[index]["status"]);
                        }
                        Childrens? children = sublocations(tree.childrens!);
                        if (children != null) {
                          return ExpansionTile(
                            leading: children.locationId != null ||
                                    children.parentId != null
                                ? const Image(
                                    image: AssetImage(
                                        "assets/images/location.png"),
                                    height: 30,
                                  )
                                : const Image(
                                    image: AssetImage(
                                        "assets/images/component.png"),
                                    height: 30,
                                  ),
                            title: Text(tree.name!),
                            children: tree.childrens!.map((act) {
                              return act.sensorType == null
                                  ? ExpansionTile(
                                      leading: act.parentId != null
                                          ? const Image(
                                              image: AssetImage(
                                                  "assets/images/location.png"),
                                              height: 30,
                                            )
                                          : const Image(
                                              image: AssetImage(
                                                  "assets/images/active.png"),
                                              height: 30,
                                            ),
                                      title: Text(act.name!),
                                      children: act.childrens != null
                                          ? act.childrens!.map((comp) {
                                              return ActiveComponent(
                                                  name: comp.name!,
                                                  status: comp.status!);
                                            }).toList()
                                          : [],
                                    )
                                  : ActiveComponent(
                                      name: act.name!,
                                      status: act.status!,
                                    );
                            }).toList(),
                          );
                        }
                        return Container();
                      });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget listEnergy(List sensors){
  //   return ExpansionTile(title: );
  // }

  Widget listData(String name, List childrens) {
    return ExpansionTile(
      leading: const Image(
        image: AssetImage("assets/images/location.png"),
        height: 20,
      ),
      title: Text(name),
      children: childrens.map(
        (en) {
          return ExpansionTile(
            leading: en.locationId != null || en.parentId != null
                ? const Image(
                    image: AssetImage("assets/images/location.png"),
                    height: 20,
                  )
                : const Image(
                    image: AssetImage("assets/images/active.png"),
                    height: 20,
                  ),
            title: Text(en.name!),
            children: en.childrens != null
                ? en.childrens!.map(
                    (act) {
                      return ActiveComponent(
                        name: act.name!,
                        status: act.status!,
                      );
                    },
                  ).toList()
                : [],
          );
        },
      ).toList(),
    );
  }

  clickSensorEnergy() {
    if (!clickEnergy) {
      if (clickCritico) {
        setState(() {
          clickCritico = false;
        });
      }
      setState(() {
        clickEnergy = true;
      });
      Provider.of<TreeService>(context, listen: false).filterSensorEnergy();
    } else {
      setState(() {
        clickEnergy = false;
      });
      Provider.of<TreeService>(context, listen: false)
          .listLocationAndActive(widget.companieId);
    }
  }

  clickSensorAlert() {
    if (!clickCritico) {
      if (clickEnergy) {
        setState(() {
          clickEnergy = false;
        });
      }
      setState(() {
        clickCritico = true;
      });
      Provider.of<TreeService>(context, listen: false).filterSensorAlert();
    } else {
      setState(() {
        clickCritico = false;
      });
      Provider.of<TreeService>(context, listen: false)
          .listLocationAndActive(widget.companieId);
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

  external(List data) {
    for (int i = 0; i < data.length;) {
      return data[i];
    }
    // return childrenFil.name;
  }
}
