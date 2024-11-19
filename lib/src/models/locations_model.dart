class LocationsModel {
  String? id;
  String? name;
  String? parentId;

  LocationsModel({this.id, this.name, this.parentId});

  LocationsModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    parentId = json["parentId"];
  }
}