class FavImageModel {
  late int id;
  late int width;
  late int height;
  late String url;
  late String photographer;
  late String photographerUrl;
  late int photographerId;
  late String avgColor;
  late bool liked;
  late String alt;
  late Src src;

  FavImageModel.fromJson(Map json) {

    id = json['id'];
    width = json['width'];
    height = json['height'];
    url = json['url'];
    photographer = json['photographer'];
    photographerUrl = json['photographer_url'];
    photographerId = json['photographer_id'];
    avgColor = json['avg_color'];
    liked = (json['liked'] == 1) ? true : false;
    alt = json['alt'];
    src = Src.fromJson(json['src']);
  }
}

class Src {
  late int id;
  late String portrait;

  Src.fromJson(Map json) {
    id = json['id'];
    portrait = json['portrait'];
  }
}
