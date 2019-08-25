import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hackthe6ix/app.dart';
import 'package:hackthe6ix/in_need_barcode.dart';
import 'package:hackthe6ix/sign_up_in_need.dart';
import 'package:location/location.dart';
import 'package:path_provider/path_provider.dart';

class InNeed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<bool>(
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Center(
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(
                          Theme.of(context).accentColor)));
            return Column(children: [
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  'c.',
                  style: Theme.of(context)
                      .textTheme
                      .display4
                      .copyWith(fontWeight: FontWeight.bold),
                  textScaleFactor: .5,
                ),
                padding: EdgeInsets.only(left: 24),
              ),
              Expanded(
                  child: Padding(
                child: Hero(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Material(
                      child: Padding(
                        child: Stack(children: <Widget>[
                          Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              'in need',
                              style: Theme.of(context).textTheme.display3,
                            ),
                          ),
                          if (!snapshot.hasData)
                            Center(
                                child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation(
                                        Theme.of(context).accentColor))),
                          if (snapshot.hasData && !snapshot.data)
                            SignUpInNeed(),
                          if (snapshot.hasData && snapshot.data)
                            InNeedBarcode(),
                        ]),
                        padding: EdgeInsets.all(12),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(
                          width: 2,
                          color: Theme.of(context).textTheme.display3.color,
                        ),
                      ),
                    ),
                  ),
                  tag: 'in need',
                ),
                padding: EdgeInsets.all(12),
              )),
            ]);
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
                    'https://hack6.azurewebsites.net/login/recipient/',
                    data: {
                  'uid': user.uid,
                  'lat': location.latitude,
                  'long': location.longitude,
                }))
                .data['success'];
            final total =
                (await Dio().get('https://hack6.azurewebsites.net/profile/'))
                    .data['total'];
            App.session.setData({
              'latitude': location.latitude,
              'longitude': location.longitude,
              'total': total,
              'uid': user.uid,
              'username': user.displayName,
            }, merge: true);
            return registered;
          }),
        ),
      ),
    );
  }
}
