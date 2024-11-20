class TesteModel {
  String? name;
  List<Childrens>? childrens;

  TesteModel({this.name, this.childrens});

  TesteModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['childrens'] != null) {
      childrens = <Childrens>[];
      json['childrens'].forEach((v) {
        childrens!.add(Childrens.fromJson(v));
      });
    }
  }
}

class Childrens {
  String? id;
  String? gatewayId;
  String? locationId;
  String? name;
  String? parentId;
  String? sensorId;
  String? sensorType;
  String? status;
  List<ChildrenFil>? childrens;

  Childrens(
      {this.id,
      this.locationId,
      this.gatewayId,
      this.name,
      this.parentId,
      this.sensorId,
      this.sensorType,
      this.status,
      this.childrens});

  Childrens.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gatewayId = json['gatewayId'];
    locationId = json['locationId'];
    name = json['name'];
    parentId = json['parentId'];
    sensorId = json['sensorId'];
    sensorType = json['sensorType'];
    status = json['status'];
    if (json['childrens'] != null) {
      childrens = <ChildrenFil>[];
      json['childrens'].forEach((v) {
        childrens!.add(ChildrenFil.fromJson(v));
      });
    }
  }
}

class ChildrenFil {
  String? gatewayId;
  String? id;
  String? locationId;
  String? name;
  String? parentId;
  String? sensorId;
  String? sensorType;
  String? status;

  ChildrenFil(
      {this.gatewayId,
      this.id,
      this.locationId,
      this.name,
      this.parentId,
      this.sensorId,
      this.sensorType,
      this.status});

  ChildrenFil.fromJson(Map<String, dynamic> json) {
    gatewayId = json['gatewayId'];
    id = json['id'];
    locationId = json['locationId'];
    name = json['name'];
    parentId = json['parentId'];
    sensorId = json['sensorId'];
    sensorType = json['sensorType'];
    status = json['status'];
  }
}
