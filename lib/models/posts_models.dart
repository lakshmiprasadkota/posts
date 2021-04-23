// To parse this JSON data, do
//
//     final posts = postsFromJson(jsonString);

import 'dart:convert';

Posts postsFromJson(String str) => Posts.fromJson(json.decode(str));

String postsToJson(Posts data) => json.encode(data.toJson());

class Posts {
  Posts({
    this.success,
    this.data,
  });

  bool success;
  Data data;

  factory Posts.fromJson(Map<String, dynamic> json) => Posts(
    success: json["success"] == null ? null : json["success"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "data": data == null ? null : data.toJson(),
  };
}

class Data {
  Data({
    this.memes,
  });

  List<Meme> memes;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    memes: json["memes"] == null ? null : List<Meme>.from(json["memes"].map((x) => Meme.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "memes": memes == null ? null : List<dynamic>.from(memes.map((x) => x.toJson())),
  };
}

class Meme {
  Meme({
    this.id,
    this.name,
    this.url,
    this.width,
    this.height,
    this.boxCount,
  });

  String id;
  String name;
  String url;
  int width;
  int height;
  int boxCount;

  factory Meme.fromJson(Map<String, dynamic> json) => Meme(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    url: json["url"] == null ? null : json["url"],
    width: json["width"] == null ? null : json["width"],
    height: json["height"] == null ? null : json["height"],
    boxCount: json["box_count"] == null ? null : json["box_count"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "url": url == null ? null : url,
    "width": width == null ? null : width,
    "height": height == null ? null : height,
    "box_count": boxCount == null ? null : boxCount,
  };
}
