import 'package:treeviewapp/src/repository/asset_repository.dart';
import 'package:treeviewapp/src/repository/location_repository.dart';

class TreeService {
  final LocationRepository _locationRepository = LocationRepository();
  final AssetRepository _assetRepository = AssetRepository();

  final Map<String, dynamic> listActives = {};
  Future<Map<String, dynamic>> listLocationAndActive(String companieId) async {
    try {
      List dataLocation = await _locationRepository.getLocations(companieId);
      List dataAsset = await _assetRepository.getAssets(companieId);
      listActives["locations"] = dataLocation;
      listActives["actives"] = dataAsset;
      // debugPrint("Locations: $locations \n");
      // debugPrint("Actives: $actives \n");

      Map<String, dynamic> mapLocations = {};

      // Locais
      for (var loc in dataLocation) {
        // debugPrint("locations: $loc \n");
        mapLocations[loc["id"]] = {
          "name": loc["name"],
          "childrens": [],
        };
      }
      // sublocais
      for (var loc in dataLocation) {
        if (loc["parentId"] != null) {
          mapLocations[loc["parentId"]]["childrens"].add(loc);
        }
      }

      // ativos e component externo
      for (var act in dataAsset) {
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
              } else {
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

      for (var act in dataAsset) {
        if (act["sensorType"] != null && act["parentId"] != null) {
          for (var loc in mapLocations.values) {
            loc["childrens"].forEach((tes) {
              if (act["parentId"] == tes["id"]) {
                tes["childrens"].add(act);
              } else {
                tes["childrens"] = [];
              }
            });
          }
        }
      }
      // for(var i in mapLocations.values){
      //   print(i);
      // }
      // print(mapLocations.values);
      return mapLocations;
    } catch (err) {
      throw err.toString();
    }
  }
}
