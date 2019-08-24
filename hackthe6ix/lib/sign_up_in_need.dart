import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_camera_ml_vision/flutter_camera_ml_vision.dart';

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
            Container(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset('assets/tax_assessment.jpg'),
            ),
            Container(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Material(
                child: InkWell(
                  child: Padding(
                    child: SignUpInNeedCamera(),
                    padding: EdgeInsets.all(12),
                  ),
                  highlightColor: Theme.of(context).canvasColor,
                  onTap: () => Navigator.of(context).pushNamed('/sponsor'),
                  splashColor: Theme.of(context).accentColor,
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
  Future<CameraController> cameraController;

  @override
  void initState() {
    super.initState();
    cameraController = availableCameras().then((cameraDescriptions) =>
        CameraController(cameraDescriptions[0], ResolutionPreset.max))
      ..then((cameraController) => cameraController.initialize().then((_) {
            if (!mounted) return;
            setState(() {});
          }));
  }

  @override
  void dispose() {
    super.dispose();
    cameraController?.then((cameraController) => cameraController.dispose());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          FutureBuilder<CameraController>(
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Center(
                    child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(
                            Theme.of(context).accentColor)));
              return AspectRatio(
                aspectRatio: snapshot.data.value.aspectRatio,
                child: CameraPreview(snapshot.data),
              );
            },
            future: cameraController,
          )
        ],
        fit: StackFit.expand,
        overflow: Overflow.clip,
      ),
      height: 120,
    );
  }
}
