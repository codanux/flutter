import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_app/profile/profile.dart';
import './google_maps_view_model.dart';
  
class GoogleMapsView extends GoogleMapsViewModel {

  @override
  Widget build(BuildContext context) {
   return new Scaffold(
      body: Stack(
        children: <Widget>[
          buildGoogleMap(),
          bottomListView,
        ],
      ),
      //floatingActionButton: buildFloatingActionButton(),
    );
  }

  Widget listViewMarkers() {
    return PageView.builder(
      controller: PageController(viewportFraction: 0.8),
      onPageChanged: (index) => controller.animateCamera(CameraUpdate.newLatLng(markerList[index].latlng)),
      scrollDirection: Axis.horizontal,
      itemCount: markerList.length,
      itemBuilder: (context, index){
        return Card(
          child:  ListTile(
            title: Text(markerList[index].country),
          ),
        );
    });
  }

  GoogleMap buildGoogleMap() {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: kGooglePlex,
      onMapCreated: (map) {
        controller = map;
        initMapItemList();
      },
      markers: _createMarker(),
      myLocationButtonEnabled: false,
    );
  }

}

extension MapsViewExt on GoogleMapsView {

    Set<Marker> _createMarker(){
    return markerList.map((e) =>  Marker(
        markerId: MarkerId(e.hashCode.toString()),
        position: e.latlng,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        onTap: () => {
          showModalBottomSheet(
            context: context, 
            builder: (context) {
              return Column(
                 children: <Widget>[
                   ListTile(
                     title: Text(e.country),
                     onTap: () {
                        Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Profile(model: e)),
                        );
                     },
                   )
                 ],  
              );
            }
          )
        },
      )).toSet();
  }


  Widget get bottomListView => Positioned(
    bottom: 20,
    left: -(pageWidth(context) * 0.05),
    right: 5,
    height: 100,
    child: markerList.isEmpty ? loadingWidget : listViewMarkers()
  );

  FloatingActionButton buildFloatingActionButton() {
    return FloatingActionButton.extended(
      onPressed: () {},
      label: Text('To the lake!'),
      icon: Icon(Icons.directions_boat),
    );
  }

  Widget get loadingWidget => Center(
    child: CircularProgressIndicator(),
  );

}