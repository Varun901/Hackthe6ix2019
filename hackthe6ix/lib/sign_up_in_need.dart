import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_camera_ml_vision/flutter_camera_ml_vision.dart';
import 'package:hackthe6ix/main.dart';

class SignUpInNeed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: <Widget>[
            Text(
              'Please take a photo of your tax assessment. It should look like this.',
              style: Theme.of(context).textTheme.display1,
              textScaleFactor: .6,
            ),
            Container(height: 6),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset('assets/tax_assessment.jpg'),
            ),
            Container(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Material(
                child: InkWell(
                  child: SignUpInNeedCamera(),
                  highlightColor: Theme.of(context).canvasColor,
                  onTap: () => Navigator.of(context).pushNamed('/sponsor'),
                  splashColor: Theme.of(context).accentColor,
                ),
              ),
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.end,
        ));
  }
}

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
    cameraController.initialize().then((_) {
      if (!mounted) return;
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    cameraController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<CameraController>(
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(
                child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation(Theme.of(context).accentColor)));
          return ClipRect(
            child: OverflowBox(
              alignment: Alignment.center,
              child: FittedBox(
                child: Container(
                  child: CameraPreview(snapshot.data),
                  height: 180,
                  width: 180 * snapshot.data.value.aspectRatio,
                ),
                fit: BoxFit.fitWidth,
              ),
            ),
          );
        },
        future: cameraController,
      ),
      height: 180,
      width: double.infinity,
    );
  }
}
