//游戏详情类
class GameDetail {
  bool success;
  String msg;
  Data data;

  GameDetail({this.success, this.msg, this.data});

  GameDetail.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  int id;
  String creater;
  String name;
  String desc;
  String systemcfg;
  int price;
  Null discount;
  int ctime;
  int utime;
  int stat;
  Null kinds;
  List<Tags> tags;
  List<String> img;

  Data(
      {this.id,
      this.creater,
      this.name,
      this.desc,
      this.systemcfg,
      this.price,
      this.discount,
      this.ctime,
      this.utime,
      this.stat,
      this.kinds,
      this.tags,
      this.img});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    creater = json['creater'];
    name = json['name'];
    desc = json['desc'];
    systemcfg = json['systemcfg'];
    price = json['price'];
    discount = json['discount'];
    ctime = json['ctime'];
    utime = json['utime'];
    stat = json['stat'];
    kinds = json['kinds'];
    if (json['tags'] != null) {
      tags = new List<Tags>();
      json['tags'].forEach((v) {
        tags.add(new Tags.fromJson(v));
      });
    }
    img = json['img'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['creater'] = this.creater;
    data['name'] = this.name;
    data['desc'] = this.desc;
    data['systemcfg'] = this.systemcfg;
    data['price'] = this.price;
    data['discount'] = this.discount;
    data['ctime'] = this.ctime;
    data['utime'] = this.utime;
    data['stat'] = this.stat;
    data['kinds'] = this.kinds;
    if (this.tags != null) {
      data['tags'] = this.tags.map((v) => v.toJson()).toList();
    }
    data['img'] = this.img;
    return data;
  }
}

class Tags {
  int id;
  String name;

  Tags({this.id, this.name});

  Tags.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}