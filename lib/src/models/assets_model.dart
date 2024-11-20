class AssetModel {
  String? id;
  String? name;
  String? locationId;
  String? parentId;
  String? sensorType;
  String? status;
  String? gatewayId;
  List? childrens;

  AssetModel({
    this.id,
    this.name,
    this.locationId,
    this.parentId,
    this.sensorType,
    this.status,
    this.gatewayId,
    this.childrens,
  });

  AssetModel.fromJson(Map<String, dynamic> json){
    id = json["id"];
    name = json["name"];
    locationId = json["locationId"];
    parentId = json["parentId"];
    sensorType = json["sensorType"];
    status = json["status"];
    gatewayId = json["gatewayId"];
    childrens != [] ? json["childrens"] : null;
  }
}