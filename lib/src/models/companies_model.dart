class Companies {
  String? id;
  String? name;

  Companies({this.id, this.name});

  Companies.fromJson(Map<String, dynamic> json){
    id = json["id"];
    name = json["name"];
  }
}