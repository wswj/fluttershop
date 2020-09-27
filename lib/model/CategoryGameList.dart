class CategoryGamesList {
  bool success;
  String msg;
  Data data;

  CategoryGamesList({this.success, this.msg, this.data});

  CategoryGamesList.fromJson(Map<String, dynamic> json) {
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
  List<Game> game;
  Page page;

  Data({this.game, this.page});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['game'] != null) {
      game = new List<Game>();
      json['game'].forEach((v) {
        game.add(new Game.fromJson(v));
      });
    }
    page = json['page'] != null ? new Page.fromJson(json['page']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.game != null) {
      data['game'] = this.game.map((v) => v.toJson()).toList();
    }
    if (this.page != null) {
      data['page'] = this.page.toJson();
    }
    return data;
  }
}

class Game {
  int id;
  String creater;
  String name;
  String desc;
  String systemcfg;
  double price;
  Null discount;
  int ctime;
  int utime;
  int stat;
  Null kinds;
  List<Tags> tags;
  List<String> img;

  Game(
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

  Game.fromJson(Map<String, dynamic> json) {
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

class Page {
  int num;
  int pages;
  int current;
  int size;
  int startPos;

  Page({this.num, this.pages, this.current, this.size, this.startPos});

  Page.fromJson(Map<String, dynamic> json) {
    num = json['num'];
    pages = json['pages'];
    current = json['current'];
    size = json['size'];
    startPos = json['startPos'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['num'] = this.num;
    data['pages'] = this.pages;
    data['current'] = this.current;
    data['size'] = this.size;
    data['startPos'] = this.startPos;
    return data;
  }
}