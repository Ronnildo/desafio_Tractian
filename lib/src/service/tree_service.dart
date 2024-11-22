import 'package:flutter/material.dart';

import 'package:treeviewapp/src/repository/asset_repository.dart';
import 'package:treeviewapp/src/repository/location_repository.dart';

class TreeService extends ChangeNotifier {
  final LocationRepository _locationRepository = LocationRepository();
  final AssetRepository _assetRepository = AssetRepository();

  Map<String, dynamic> _data = {};
  bool sensorEnergy = false;
  bool sensorAlert = false;
  List? _filters;

  get filters => _filters;
  get data => _data;

  Future listLocationAndActive(String companieId, bool sernsorEnergy) async {
    Map<String, dynamic> _listActives = {};
    try {
      List dataLocation = await _locationRepository.getLocations(companieId);
      List dataAsset = await _assetRepository.getAssets(companieId);
      _listActives["locations"] = dataLocation;
      _listActives["actives"] = dataAsset;

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
            loc["childrens"].forEach((tes) {
              if (tes["id"] == act["parentId"]) {
                tes["childrens"] = act;
              } else {
                tes["childrens"] = [];
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
      if(sensorEnergy == true){
        _data = await filterSensorEnergy(companieId);
        notifyListeners();
        return;
      }
      _data = mapHierarchy;
      notifyListeners();
      return _data;
    } catch (err) {
      throw err.toString();
    }
  }

  Future filterInputLocation(String companieId, String input) async {
    print(_data);
    Map<String, dynamic> dataLocation = await listLocationAndActive(companieId, sensorAlert);

    _filters = dataLocation.values.toList();
    for (int i = 0; i < _filters!.length; i++) {
      if (_filters![i]["name"].contains(input)) {
        return _filters![i];
      }
    }
  }

  Future filterInputActive(String companieId, String input) async {
    Map<String, dynamic> dataLocation = await listLocationAndActive(companieId, sensorEnergy);

    _filters = dataLocation.values.toList();
    for (int i = 0; i < data.length; i++) {
      if (_filters![i]["childrens"].isNotEmpty) {
        for (int j = 0; j < _filters![i]["childrens"].length; j++) {
          if (_filters![i]["childrens"][j]["name"].contains(input)) {
            return _filters![i];
          } else {
            if (_filters![i]["childrens"][j]["childrens"].isNotEmpty) {
              for (int k = 0;
                  k < _filters![i]["childrens"][j]["childrens"].length;
                  k++) {
                if (_filters![i]["childrens"][j]["childrens"][k]["name"]
                    .contains(input)) {
                  return _filters![i];
                }
              }
              // print(_filters![i]["childrens"][j]["childrens"]);
            }
          }
        }
        // return _filters![i];
      }
    }
  }

  // Filtro para sensores de energia
  Future filterSensorEnergy(String companieId) async {
    Map<String, dynamic> dataLocation = await listLocationAndActive(companieId, sensorEnergy);

    _filters = dataLocation.values.toList();

    for (int i = 0; i < data.length; i++) {
      if (_filters![i]["childrens"].isNotEmpty) {
        for (int j = 0; j < _filters![i]["childrens"].length; j++) {
          if (_filters![i]["childrens"][j]["sensorType"] == "energy") {
            return _filters!;
          } else {
            if (_filters![i]["childrens"][j]["childrens"].isNotEmpty) {
              for (int k = 0;
                  k < _filters![i]["childrens"][j]["childrens"].length;) {
                if (_filters![i]["childrens"][j]["childrens"][k]
                        ["sensorType"] ==
                    "energy") {
                  return _filters![i];
                } else {
                  return;
                }
              }
              // print(_filters!["childrens"][j]["childrens"]);
            }
          }
        }
        // return _filters!;
      }
    }
  }

  // Filtro para Sensor Crítico
  Future filterSensorAlert(String companieId) async {
    Map<String, dynamic> dataLocation = await listLocationAndActive(companieId, sensorAlert);

    _filters = dataLocation.values.toList();

    for (int i = 0; i < data.length; i++) {
      if (_filters![i]["childrens"].isNotEmpty) {
        for (int j = 0; j < _filters![i]["childrens"].length; j++) {
          if (_filters![i]["childrens"][j]["status"] == "alert") {
            return _filters![i];
          } else {
            if (_filters![i]["childrens"][j]["childrens"].isNotEmpty) {
              for (int k = 0;
                  k < _filters![i]["childrens"][j]["childrens"].length;) {
                if (_filters![i]["childrens"][j]["childrens"][k]["status"] ==
                    "alert") {
                  return _filters![i];
                } else {
                  return;
                }
              }
              // print(_filters![i]["childrens"][j]["childrens"]);
            }
          }
        }
        // return _filters![i];
      }
    }
  }
}

