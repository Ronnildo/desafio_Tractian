import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
                    onTap: setColorclickEnergy,
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
                    onTap: setColorClickCritico,
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
                  print(clickEnergy);
                  var data = value.data.values.toList();
                  // var filter = value.energy.values.toList();
                  // print(data);
                  return clickEnergy
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            TesteModel testeModel =
                                TesteModel.fromJson(data[index]);

                            Childrens? subloc =
                                sublocations(testeModel.childrens!);
                            if (subloc != null) {
                              return ExpansionTile(
                                  leading: const Image(
                                    width: 24,
                                    height: 24,
                                    image: AssetImage(
                                      "assets/images/location.png",
                                    ),
                                  ),
                                  title: Text(
                                    testeModel.name!,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  children: testeModel.childrens!.map((e) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(left: 20.0),
                                      child: (e.locationId != null &&
                                              e.parentId == null &&
                                              e.sensorId != null)
                                          ? Row(
                                              children: [
                                                Text(
                                                  e.name!,
                                                  style: const TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                (e.sensorId != null &&
                                                        e.parentId == null &&
                                                        e.locationId != null)
                                                    ? Icon(
                                                        e.status != "alert"
                                                            ? Icons.bolt
                                                            : Icons.circle,
                                                        color:
                                                            e.status == "alert"
                                                                ? const Color(
                                                                    0xFFED3833)
                                                                : Colors.green,
                                                        size: 20,
                                                      )
                                                    : const Icon(null),
                                              ],
                                            )
                                          : ExpansionTile(
                                              leading: Image(
                                                width: 24,
                                                height: 24,
                                                image: const AssetImage(
                                                  "assets/images/location.png",
                                                ),
                                              ),
                                              trailing: null,
                                              title: Row(
                                                children: [
                                                  Text(
                                                    e.name!,
                                                    style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                  (e.sensorId != null &&
                                                          e.parentId == null &&
                                                          e.locationId != null)
                                                      ? Icon(
                                                          e.status != "alert"
                                                              ? Icons.bolt
                                                              : Icons.circle,
                                                          color: e.status ==
                                                                  "alert"
                                                              ? const Color(
                                                                  0xFFED3833)
                                                              : Colors.green,
                                                          size: 20,
                                                        )
                                                      : const Icon(null),
                                                ],
                                              ),
                                              children: e.childrens != null
                                                  ? e.childrens!.map((c) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 40),
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
                                                                Text(
                                                                  c.name!,
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  width: 10,
                                                                ),
                                                                c.sensorId !=
                                                                        null
                                                                    ? Icon(
                                                                        c.status ==
                                                                                "alert"
                                                                            ? Icons.circle
                                                                            : Icons.bolt,
                                                                        color: c.status ==
                                                                                "alert"
                                                                            ? const Color(0xFFED3833)
                                                                            : Colors.green,
                                                                        size:
                                                                            20,
                                                                      )
                                                                    : const Icon(
                                                                        null),
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
                            // print(data);

                            return Container(
                              padding: const EdgeInsets.only(left: 20),
                              child: Row(
                                children: [
                                  Image(
                                      width: 24,
                                      height: 24,
                                      image: testeModel.childrens == null
                                          ? const AssetImage(
                                              "assets/images/location.png",
                                            )
                                          : const AssetImage(
                                              "assets/images/component.png",
                                            )),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    testeModel.name!,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const Icon(
                                    Icons.bolt,
                                    color: Colors.green,
                                  ),
                                ],
                              ),
                            );
                          },
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            TesteModel testeModel =
                                TesteModel.fromJson(data[index]);
                            ChildrenFil external =
                                ChildrenFil.fromJson(data[index]);
                            if (testeModel.childrens != null) {
                              Childrens? subloc =
                                  sublocations(testeModel.childrens!);
                              if (subloc != null) {
                                return ExpansionTile(
                                    leading: const Image(
                                      width: 24,
                                      height: 24,
                                      image: AssetImage(
                                        "assets/images/location.png",
                                      ),
                                    ),
                                    title: Text(
                                      testeModel.name!,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    children: testeModel.childrens!.map((e) {
                                      return (e.locationId != null &&
                                              e.parentId == null &&
                                              e.sensorId != null)
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 50.0, bottom: 10),
                                              child: Row(
                                                children: [
                                                  const Image(
                                                    width: 24,
                                                    height: 24,
                                                    image: AssetImage(
                                                      "assets/images/component.png",
                                                    ),
                                                  ),
                                                  Text(
                                                    e.name!,
                                                    style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                  (e.sensorId != null &&
                                                          e.parentId == null &&
                                                          e.locationId != null)
                                                      ? Icon(
                                                          e.status != "alert"
                                                              ? Icons.bolt
                                                              : Icons.circle,
                                                          color: e.status ==
                                                                  "alert"
                                                              ? const Color(
                                                                  0xFFED3833)
                                                              : Colors.green,
                                                          size: 20,
                                                        )
                                                      : const Icon(null),
                                                ],
                                              ),
                                            )
                                          : ExpansionTile(
                                              leading: const Image(
                                                width: 24,
                                                height: 24,
                                                image: AssetImage(
                                                  "assets/images/location.png",
                                                ),
                                              ),
                                              trailing: null,
                                              title: Row(
                                                children: [
                                                  Text(
                                                    e.name!,
                                                    style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                  (e.sensorId != null &&
                                                          e.parentId == null &&
                                                          e.locationId != null)
                                                      ? Icon(
                                                          e.status != "alert"
                                                              ? Icons.bolt
                                                              : Icons.circle,
                                                          color: e.status ==
                                                                  "alert"
                                                              ? const Color(
                                                                  0xFFED3833)
                                                              : Colors.green,
                                                          size: 20,
                                                        )
                                                      : const Icon(null),
                                                ],
                                              ),
                                              children: e.childrens != null
                                                  ? e.childrens!.map((c) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 40),
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
                                                                Text(
                                                                  c.name!,
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  width: 10,
                                                                ),
                                                                c.sensorId !=
                                                                        null
                                                                    ? Icon(
                                                                        c.status ==
                                                                                "alert"
                                                                            ? Icons.circle
                                                                            : Icons.bolt,
                                                                        color: c.status ==
                                                                                "alert"
                                                                            ? const Color(0xFFED3833)
                                                                            : Colors.green,
                                                                        size:
                                                                            20,
                                                                      )
                                                                    : const Icon(
                                                                        null),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      );

                                                      // return Container();
                                                    }).toList()
                                                  : [],
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
                                    Text(
                                      external.name!,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
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
                },
              ),
              // FutureBuilder(
              //   future: _treeService.listLocationAndActive(widget.companieId),
              //   builder: (context, snapshot) {
              //     if (snapshot.hasData) {
              //       return ListView.builder(
              //         shrinkWrap: true,
              //         itemCount: snapshot.data!.length,
              //         itemBuilder: (context, index) {
              //           var assets = snapshot.data.values.toList();
              //           // print(assets);
              //           TesteModel testeModel =
              //               TesteModel.fromJson(assets[index]);
              //           ChildrenFil external =
              //               ChildrenFil.fromJson(assets[index]);
              // if (testeModel.childrens != null) {
              //   Childrens? subloc =
              //       sublocations(testeModel.childrens!);

              // if (subloc != null) {
              //   return ExpansionTile(
              //       leading: const Image(
              //         width: 24,
              //         height: 24,
              //         image: AssetImage(
              //           "assets/images/location.png",
              //         ),
              //       ),
              //       title: Text(
              //         testeModel.name!,
              //         style: const TextStyle(
              //           fontSize: 16,
              //           fontWeight: FontWeight.w500,
              //         ),
              //       ),
              // children: testeModel.childrens!.map((e) {
              //   return Padding(
              //     padding: const EdgeInsets.only(left: 20.0),
              //     child: ExpansionTile(
              //       leading: Image(
              //         width: 24,
              //         height: 24,
              //         image: (e.locationId != null &&
              //                 e.parentId == null &&
              //                 e.sensorId == null)
              //             ? const AssetImage(
              //                 "assets/images/active.png",
              //               )
              //             : const AssetImage(
              //                 "assets/images/location.png",
              //               ),
              //       ),
              //       trailing: null,
              //       title: Row(
              //         children: [
              //           Text(
              //             e.name!,
              //             style: const TextStyle(
              //               fontSize: 15,
              //               fontWeight: FontWeight.w400,
              //             ),
              //           ),
              //           (e.sensorId != null &&
              //                   e.parentId == null &&
              //                   e.locationId != null)
              //               ? Icon(
              //                   e.status != "alert"
              //                       ? Icons.bolt
              //                       : Icons.circle,
              //                   color: e.status == "alert"
              //                       ? const Color(0xFFED3833)
              //                       : Colors.green,
              //                   size: 20,
              //                 )
              //               : const Icon(null),
              //         ],
              //       ),
              //       children: e.childrens != null
              //           ? e.childrens!.map((c) {
              //               return Padding(
              //                 padding: const EdgeInsets.only(
              //                     left: 40),
              //                 child: Row(
              //                   children: [
              //                     const Image(
              //                       width: 24,
              //                       height: 24,
              //                       image: AssetImage(
              //                         "assets/images/component.png",
              //                       ),
              //                     ),
              //                     const SizedBox(
              //                       width: 10,
              //                     ),
              //                     Row(
              //                       children: [
              //                         Text(
              //                           c.name!,
              //                           style:
              //                               const TextStyle(
              //                             fontSize: 14,
              //                             fontWeight:
              //                                 FontWeight.w400,
              //                           ),
              //                         ),
              //                         const SizedBox(
              //                           width: 10,
              //                         ),
              //                         c.sensorId != null
              //                             ? Icon(
              //                                 c.status ==
              //                                         "alert"
              //                                     ? Icons
              //                                         .circle
              //                                     : Icons
              //                                         .bolt,
              //                                 color: c.status ==
              //                                         "alert"
              //                                     ? const Color(
              //                                         0xFFED3833)
              //                                     : Colors
              //                                         .green,
              //                                 size: 20,
              //                               )
              //                             : const Icon(null),
              //                       ],
              //                     ),
              //                   ],
              //                 ),
              //               );

              //               // return Container();
              //             }).toList()
              //           : [],
              //     ),
              //   );
              // }).toList());
              //             }
              //           }
              //           if (external.status != null) {
              // return Container(
              //   padding: const EdgeInsets.only(left: 20),
              //   child: Row(
              //     children: [
              //       const Image(
              //         width: 24,
              //         height: 24,
              //         image: AssetImage(
              //           "assets/images/component.png",
              //         ),
              //       ),
              //       const SizedBox(
              //         width: 10,
              //       ),
              //       Text(
              //         external.name!,
              //         style: const TextStyle(
              //           fontSize: 16,
              //           fontWeight: FontWeight.w500,
              //         ),
              //       ),
              //       const Icon(
              //         Icons.bolt,
              //         color: Colors.green,
              //       ),
              //     ],
              //   ),
              // );
              //           }
              //           // print(childrenFil!.id);
              //           return ExpansionTile(
              //             leading: const Image(
              //               width: 24,
              //               height: 24,
              //               image: AssetImage(
              //                 "assets/images/location.png",
              //               ),
              //             ),
              //             title: Text(external.name!),

              //             // enabled: false,
              //             dense: true,
              //           );
              //         },
              //       );
              //     }
              //     return const Center(child: CircularProgressIndicator());
              //   },
              // ),
            ),
          ],
        ),
      ),
    );
  }

  setColorclickEnergy() {
    if (clickEnergy) {
      setState(() {
        clickEnergy = false;
        Provider.of<TreeService>(context, listen: false).listLocationAndActive(widget.companieId);
      });
    } else {
      setState(() {
        clickEnergy = true;

        clickCritico = false;

        Provider.of<TreeService>(context, listen: false).filterSensorEnergy();
      });
    }
  }

  setColorClickCritico() {
    if (clickCritico) {
      setState(() {
        clickCritico = false;
        Provider.of<TreeService>(context, listen: false).listLocationAndActive(widget.companieId);
      });
    } else {
      setState(() {
        clickEnergy = false;
        clickCritico = true;
        Provider.of<TreeService>(context, listen: false).filterSensorAlert();
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
}
