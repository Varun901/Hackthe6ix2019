import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:hackthe6ix/app.dart';
import 'package:hackthe6ix/main.dart';

class SignUpInNeedCamera extends StatefulWidget {
  @override
  _SignUpInNeedCameraState createState() => _SignUpInNeedCameraState();
}

class _SignUpInNeedCameraState extends State<SignUpInNeedCamera> {
  CameraController cameraController;

  @override
  void initState() {
    super.initState();
    cameraController =
        CameraController(cameraDescriptions.first, ResolutionPreset.max);
    cameraController.initialize().then((_) => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
    cameraController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<CameraController>(
        builder: (context, snapshot) {
          if (!snapshot.hasData || !snapshot.data.value.isInitialized)
            return Center(
                child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation(Theme.of(context).accentColor)));
          return Stack(
            children: <Widget>[
              ClipRect(
                child: OverflowBox(
                  alignment: Alignment.center,
                  child: FittedBox(
                    child: Container(
                      child: CameraPreview(snapshot.data),
                      height: MediaQuery.of(context).size.height / 3,
                      width: MediaQuery.of(context).size.height /
                          3 *
                          snapshot.data.value.aspectRatio,
                    ),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topRight,
                child: Padding(
                  child: IconButton(
                    icon: Icon(Icons.camera, size: 36),
                    onPressed: () {
                      cameraController.stopImageStream();
                      Navigator.of(context)
                          .pushNamed('/sign_up_in_need_success');
                    },
                  ),
                  padding: EdgeInsets.all(12),
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    colors: <Color>[Colors.transparent, App.kJet],
                    end: Alignment.topRight,
                  ),
                ),
              ),
            ],
            fit: StackFit.passthrough,
          );
        },
        future: Future.sync(() async {
          await cameraController.initialize();
          return cameraController;
        }),
      ),
      height: MediaQuery.of(context).size.height / 3,
      width: double.infinity,
    );
  }
}
