import 'package:flutter/material.dart';
import 'package:my_app/google_maps/google_maps_model.dart';
import './profile_view.dart';

class Profile extends StatefulWidget {
  
  final MapModel model;

  const Profile({Key key, this.model}) : super(key: key);

  @override
  ProfileView createState() => new ProfileView(this.model);
}
  
