import 'dart:convert' show json;

class GameDetail {
  bool success;
  String msg;
  Data data;

  GameDetail({
    this.success,
    this.msg,
    this.data,
  });

  factory GameDetail.fromJson(jsonRes) => jsonRes == null
      ? null
      : GameDetail(
          success: jsonRes['success'],
          msg: jsonRes['msg'],
          data: Data.fromJson(jsonRes['data']),
        );
  Map<String, dynamic> toJson() => {
        'success': success,
        'msg': msg,
        'data': data,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Data {
  int id;
  String creater;
  String name;
  String desc;
  String systemcfg;
  double price;
  Object discount;
  int ctime;
  int utime;
  int stat;
  Object kinds;
  List<Tags> tags;
  List<String> img;

  Data({
    this.id,
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
    this.img,
  });

  factory Data.fromJson(jsonRes) {
    if (jsonRes == null) return null;
    List<Tags> tags = jsonRes['tags'] is List ? [] : null;
    if (tags != null) {
      for (var item in jsonRes['tags']) {
        if (item != null) {
          tags.add(Tags.fromJson(item));
        }
      }
    }

    List<String> img = jsonRes['img'] is List ? [] : null;
    if (img != null) {
      for (var item in jsonRes['img']) {
        if (item != null) {
          img.add(item);
        }
      }
    }

    return Data(
      id: jsonRes['id'],
      creater: jsonRes['creater'],
      name: jsonRes['name'],
      desc: jsonRes['desc'],
      systemcfg: jsonRes['systemcfg'],
      price: jsonRes['price'],
      discount: jsonRes['discount'],
      ctime: jsonRes['ctime'],
      utime: jsonRes['utime'],
      stat: jsonRes['stat'],
      kinds: jsonRes['kinds'],
      tags: tags,
      img: img,
    );
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'creater': creater,
        'name': name,
        'desc': desc,
        'systemcfg': systemcfg,
        'price': price,
        'discount': discount,
        'ctime': ctime,
        'utime': utime,
        'stat': stat,
        'kinds': kinds,
        'tags': tags,
        'img': img,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Tags {
  int id;
  String name;

  Tags({
    this.id,
    this.name,
  });

  factory Tags.fromJson(jsonRes) => jsonRes == null
      ? null
      : Tags(
          id: jsonRes['id'],
          name: jsonRes['name'],
        );
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}
