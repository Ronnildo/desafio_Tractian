import 'package:flutter/material.dart';
import 'package:treeviewapp/src/repository/asset_repository.dart';
import 'package:treeviewapp/src/repository/location_repository.dart';

class TreeService extends ChangeNotifier {
  final LocationRepository _locationRepository = LocationRepository();
  final AssetRepository _assetRepository = AssetRepository();

  Map<String, dynamic> _data = {};
  Map<String, dynamic> _energy = {};

  get data => _data;
  get energy => _energy;

  Future listLocationAndActive(
    String companieId,
  ) async {
    Map<String, dynamic> listActives = {};

    try {
      List dataLocation = await _locationRepository.getLocations(companieId);
      List dataAsset = await _assetRepository.getAssets(companieId);
      listActives["locations"] = dataLocation;
      listActives["actives"] = dataAsset;

      // print(listActives);

      Map<String, dynamic> mapHierarchy = {};
      // Locais
      for (var loc in dataLocation) {
        mapHierarchy[loc["id"]] = {
          "name": loc["name"],
          "childrens": [],
        };
      }
      // sublocais
      for (var loc in dataLocation) {
        if (loc["parentId"] != null) {
          mapHierarchy[loc["parentId"]]["childrens"].add(loc);
        }
      }

      // ativos e component externo
      for (var act in dataAsset) {
        if (act["locationId"] == null && act["parentId"] == null) {
          mapHierarchy[act["id"]] = {
            "name": act["name"],
            "status": act["status"],
            "sensorId": act["sensorId"],
            "sensorType": act["sensorType"],
            "gateway": act["gatewayId"],
            "childrens": [],
          };
        } else if (act["sensorId"] == null && act["locationId"] != null) {
          mapHierarchy[act["locationId"]]["childrens"].add(act);
        } else if (act["sensorId"] == null && act["parentId"] != null) {
          for (var loc in mapHierarchy.values) {
            loc["childrens"].forEach((data) {
              if (data["id"] == act["parentId"]) {
                data["childrens"] = act;
              } else {
                data["childrens"] = [];
              }
            });
          }
        } else if (act["sensorType"] != null && act["locationId"] != null) {
          for (var loc in mapHierarchy.values) {
            loc["childrens"].add(act);
          }
        }
      }

      for (var act in dataAsset) {
        if (act["sensorType"] != null && act["parentId"] != null) {
          for (var loc in mapHierarchy.values) {
            loc["childrens"].forEach((data) {
              if (act["parentId"] == data["id"]) {
                data["childrens"].add(act);
              } else {
                data["childrens"] = [];
              }
            });
          }
        }
      }

      _data = mapHierarchy;
      notifyListeners();
      // return _data;
    } catch (err) {
      throw err.toString();
    }
  }

  Future filterInputLocation(String input) async {
    List filters = _data.values.toList();
    Map<String, dynamic> data = {};
    for (int i = 0; i < filters.length; i++) {
      if (filters[i]["name"].contains(input)) {
        data["energy"] = filters[i];
      }
    }
    _energy = data;
    notifyListeners();
  }

  Future filterInputActive(String companieId, String input) async {
    List _filters = _data.values.toList();
    for (int i = 0; i < data.length; i++) {
      if (_filters[i]["childrens"].isNotEmpty) {
        for (int j = 0; j < _filters[i]["childrens"].length; j++) {
          if (_filters[i]["childrens"][j]["name"].contains(input)) {
            return _filters[i];
          } else {
            if (_filters[i]["childrens"][j]["childrens"].isNotEmpty) {
              for (int k = 0;
                  k < _filters[i]["childrens"][j]["childrens"].length;
                  k++) {
                if (_filters[i]["childrens"][j]["childrens"][k]["name"]
                    .contains(input)) {
                  return _filters[i];
                }
              }
              // print(_filters[i]["childrens"][j]["childrens"]);
            }
          }
        }
        return _filters[i];
      }
    }
  }

  // Filtro para sensores de energia
  Future filterSensorEnergy() async {
    List data = _data.values.toList();
    Map<String, dynamic> energyFilter = {};
    for (int i = 0; i < data.length; i++) {
      if (data[i]["sensorType"] == "energy") {
        energyFilter["filter"] = data[i];
      } else {
        if (data[i]["childrens"] != null) {
          for (int j = 0; j < data[i]["childrens"].length; j++) {
            if (data[i]["childrens"][j]["sensorType"] == "energy") {
              print(data[i]["childrens"]);
              energyFilter["filter"] = data[i];
            }
          }
        }
      }
    }
    _data = energyFilter;
    // print(_data);
    notifyListeners();
  }

  // Filtro para Sensor Crítico
  Future filterSensorAlert() async {
    List data = _data.values.toList();
    Map<String, dynamic> criticSensor = {};
    for (int i = 0; i < data.length; i++) {
      // print(data[i]["sensorType"]);
      if (data[i]["status"] == "alert") {
        criticSensor["filter"] = data[i];
      }
      for (int j = 0; j < data[i]["childrens"].length; j++) {
        if (data[i]["childrens"][j]["status"] == "alert") {
          criticSensor["filter"] = data[i];
        }
        if (data[i]["childrens"] != null) {
          for (int k = 0;
              k < data[i]["childrens"][j]["childrens"].length;
              k++) {
            if (data[i]["childrens"][j]["childrens"][k]["status"] == "alert") {
              criticSensor["filter"] = data[i];
            }
          }
        }
      }
    }
    _data = criticSensor;
    // print(_data);
    notifyListeners();
  }
}
