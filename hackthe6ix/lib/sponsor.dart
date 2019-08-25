import 'package:cookie_jar/cookie_jar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hackthe6ix/app.dart';
import 'package:location/location.dart';
import 'package:path_provider/path_provider.dart';

class Sponsor extends StatefulWidget {
  @override
  _SponsorState createState() => _SponsorState();
}

class _SponsorState extends State<Sponsor> {
  GoogleMapController mapController;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Scaffold(
              body: Center(
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(
                          Theme.of(context).accentColor))));
        return StreamBuilder<DocumentSnapshot>(
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Scaffold(
                    body: Center(
                        child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(
                                Theme.of(context).accentColor))));
              final _ = snapshot.data;
              return Scaffold(
                body: GoogleMap(
                  onMapCreated: (_mapController) =>
                      mapController = _mapController,
                  initialCameraPosition: CameraPosition(
                      target: LatLng(_['latitude'], _['longitude']), zoom: 8),
                  markers: <Marker>{
                    for (int index = 0; index < _['purchases'].length; index++)
                      Marker(
                        markerId:
                            MarkerId(_['purchases'][index]['id'].toString()),
                        position: LatLng(_['purchases'][index]['lat'],
                            _['purchases'][index]['long']),
                        onTap: () => App.session.setData(
                            {'selected_purchase_index': index},
                            merge: true),
                      ),
                  },
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                ),
                bottomSheet: DraggableScrollableSheet(
                  builder: (context, scrollController) {
                    return ListView.builder(
                      controller: scrollController,
                      itemBuilder: (context, index) {
                        if (index == 0)
                          return ListTile(
                            leading:
                                GoogleUserCircleAvatar(identity: App.account),
                            title: Text(
                              snapshot.data['username'],
                              style: Theme.of(context)
                                  .textTheme
                                  .display2
                                  .copyWith(color: Colors.white),
                              textScaleFactor: .5,
                            ),
                            subtitle: Text(
                              '\$${snapshot.data['total'].toStringAsFixed(2)}',
                              style: Theme.of(context)
                                  .textTheme
                                  .display1
                                  .copyWith(color: Colors.white),
                              textScaleFactor: .5,
                            ),
                          );
                        index--;
                        return ListTile(
                          title: Text(
                            '\$${_['purchases'][index]['amount'].toStringAsFixed(2)}',
                            style: Theme.of(context).textTheme.display2,
                            textScaleFactor: .5,
                          ),
                          onTap: () {
                            App.session.setData(
                                {'selected_purchase_index': index},
                                merge: true);
                            mapController.animateCamera(
                                CameraUpdate.newCameraPosition(CameraPosition(
                                    target: LatLng(_['purchases'][index]['lat'],
                                        _['purchases'][index]['long']),
                                    zoom: 20)));
                          },
                          selected: _['selected_purchase_index'] == index,
                          subtitle: Text(
                            'ID: ${_['purchases'][index]['id'].toString()}',
                            style: Theme.of(context).textTheme.display1,
                            textScaleFactor: .5,
                          ),
                          trailing: Text(
                            _['purchases'][index]['store'],
                            style: Theme.of(context).textTheme.display3,
                            textScaleFactor: .5,
                          ),
                        );
                      },
                      itemCount: _['purchases'].length + 1,
                      padding: EdgeInsets.all(12).copyWith(top: 24),
                    );
                  },
                  expand: false,
                ),
              );
            },
            stream: App.session.snapshots());
      },
      future: Future.sync(() async {
        await GoogleSignIn().signOut();
        final googleUser = await GoogleSignIn().signIn();
        App.account = googleUser;
        final auth = await googleUser.authentication;
        final credential = GoogleAuthProvider.getCredential(
          accessToken: auth.accessToken,
          idToken: auth.idToken,
        );
        final _user =
            await FirebaseAuth.instance.signInWithCredential(credential);
        final user = _user.user;
        final location = await Location().getLocation();
        Dio().interceptors.add(CookieManager(
            PersistCookieJar(dir: (await getTemporaryDirectory()).path)));
        final registered = (await Dio().post(
                'https://hack6.azurewebsites.net/login/donor/',
                data: {'uid': user.uid}))
            .data['success'];
        final purchases = (await Dio().get(
                'https://hack6.azurewebsites.net/purchases?lat=${location.latitude}&long=${location.longitude}'))
            .data['purchases'];
        final total =
            (await Dio().get('https://hack6.azurewebsites.net/profile/'))
                .data['total'];
        App.session.setData({
          'latitude': location.latitude,
          'longitude': location.longitude,
          'purchases': purchases,
          'selected_purchase_index': 0,
          'total': total,
          'uid': user.uid,
          'username': user.displayName,
        }, merge: true);
        return registered;
      }),
    );
  }
}
