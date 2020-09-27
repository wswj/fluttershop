import 'dart:convert';

class CategoryModel{
  //List<dynamic> kindList;
  int id;
  String name;
  List<CategoryModel1> childList;
  CategoryModel({
    this.id,
    this.name,
    this.childList
  });
  factory CategoryModel.fromJson(dynamic json){
    //print("获取的json数据为${json}");
    return CategoryModel(
      id: json["id"],
      name: json["name"],
      //childList: [json.toString()]
      childList: [CategoryModel1.fromJson(json),CategoryModel1.fromJson(json),CategoryModel1.fromJson(json)]
    );
  }

  //CategoryModel1 get value => null;
}

class KindModel{
  List<CategoryModel> data;
  KindModel({
    this.data
  });
  factory KindModel.fromJson(List json){
    return KindModel(
      data: json.map((i)=>CategoryModel.fromJson((i))).toList()
    );
  }
}

class CategoryModel1{
  //List<dynamic> kindList;
  int id;
  String name;
  //List<CategoryModel1> childList=[];
  CategoryModel1({
    this.id,
    this.name,
    //this.childList
  });
  factory CategoryModel1.fromJson(dynamic json){
    //print("获取的jsons数据为${json}");
    return CategoryModel1(
      id: json["id"],
      name: json["name"],
      //childList: [json.toString()]
      //childList: [CategoryModel1().fromJson(json)]
    );
  }
}
