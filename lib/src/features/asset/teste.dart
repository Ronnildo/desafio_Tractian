import 'package:flutter/material.dart';
import 'package:treeviewapp/service/tree_service.dart';

class Teste extends StatefulWidget {
  final String companieId;
  const Teste({super.key, required this.companieId});

  @override
  State<Teste> createState() => _TesteState();
}

class _TesteState extends State<Teste> {
  TreeService treeService = TreeService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getLocationsActive(),
        builder: (context, snapshot) => ListView(
          children: [
            Text(snapshot.data.toString()),
          ],
        ),
      ),
    );
  }

  Future<Map<String, dynamic>> getLocationsActive() async {
    Map<String, dynamic> response =
        await treeService.listLocationAndActive(widget.companieId);
    var locations = response["locations"];
    var actives = response["actives"];
    // debugPrint("Locations: $locations \n");
    // debugPrint("Actives: $actives \n");

    Map<String, dynamic> mapLocations = {};

    // Locais
    for (var loc in locations) {
      // debugPrint("locations: $loc \n");
      mapLocations[loc["id"]] = {
        "name": loc["name"],
        "childrens": [],
      };
    }
    // sublocais
    for (var loc in locations) {
      if (loc["parentId"] != null) {
        mapLocations[loc["parentId"]]["childrens"].add(loc);
      }
    }

    // ativos e component externo
    for (var act in actives) {
      if (act["locationId"] == null && act["parentId"] == null) {
        mapLocations[act["id"]] = {
          "name": act["name"],
          "status": act["status"],
          "sensorId": act["sensorId"],
          "sensorType": act["sensorType"],
          "gateway": act["gatewayId"],
          "childrens": [],
        };
      } else if (act["sensorId"] == null && act["locationId"] != null) {
        mapLocations[act["locationId"]]["childrens"].add(act);
      } else if (act["sensorId"] == null && act["parentId"] != null) {
        for (var loc in mapLocations.values) {
          loc["childrens"].forEach((tes) {
            if (tes["id"] == act["parentId"]) {
              tes["childrens"] = act;
            }
            else{
              tes["childrens"] = [];
            }
            // print(tes["id"]);
          });
        }
      } else if (act["sensorType"] != null && act["locationId"] != null) {
        for (var loc in mapLocations.values) {
          loc["childrens"].add(act);
        }
      }
    }

    for (var act in actives) {
      if (act["sensorType"] != null && act["parentId"] != null) {
        print(act);
        for (var loc in mapLocations.values) {
          // print(loc);
          loc["childrens"].forEach((tes) {
            print(tes);
            if (act["parentId"] == tes["id"]) {
              tes["childrens"] = act;
            }else{
              tes["childrens"] = [];
            }
          });
        }
      }
    }
    // print(mapLocations["656733b1664c41001e91d9ed"]);

    print("Locations: ${mapLocations.values} \n");
    return mapLocations;
  }
}
