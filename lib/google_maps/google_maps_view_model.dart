import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import './google_maps.dart';

import 'package:http/http.dart' as http;

import 'google_maps_model.dart';

abstract class GoogleMapsViewModel extends State<GoogleMaps> {
  
  GoogleMapController controller;

  List<MapModel> markerList = [];

  Future initMapItemList() async {
    final response = await http.get("http://192.168.1.153:8000/api/marker");
    print(response);
    if(response.statusCode == HttpStatus.ok){
      final data = jsonDecode(response.body)["data"];
    
      if (data is List)
      {
        markerList = data.map((e) => MapModel.fromJson(e))
        .cast<MapModel>()
        .toList();
        controller.animateCamera(CameraUpdate.newLatLng(markerList.first.latlng));
        setState(() {});
      } 
    }
  }

  void navigateToRoute(int index) {
    controller.animateCamera(CameraUpdate.newLatLng(markerList[index].latlng));
  }

  final CameraPosition kGooglePlex = CameraPosition(
    target: LatLng(40.981867, 29.0576302),
    zoom: 12,
  );

  double pageWidth(context) => MediaQuery.of(context).size.width;
  double pageHeight(context) => MediaQuery.of(context).size.height;

}
