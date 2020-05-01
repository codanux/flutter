import 'package:flutter/material.dart';
import 'package:my_app/google_maps/google_maps_model.dart';
import './profile_view_model.dart';
  
class ProfileView extends ProfileViewModel {
  final MapModel model;

  ProfileView(this.model);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(model.country),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Open route'),
          onPressed: () {
            
          },
        ),
      )
    );
  }
}