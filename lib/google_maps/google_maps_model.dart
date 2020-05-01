import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapModel {
  String country;
  double lat;
  double lng;

  MapModel({this.country, this.lat, this.lng});

  MapModel.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country'] = this.country;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }

  LatLng get latlng => LatLng(this.lat, this.lng);
}

