import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<bool>(
      builder: (context, snapshot) {
        return Stack(children: <Widget>[
          AnimatedAlign(
            alignment:
                snapshot.hasData ? Alignment.bottomCenter : Alignment.center,
            child: Padding(
              child: Text(
                'community.',
                style: Theme.of(context).textTheme.display4,
                textScaleFactor: .5,
              ),
              padding: EdgeInsets.all(24).copyWith(bottom: 48),
            ),
            curve: Curves.decelerate,
            duration: Duration(milliseconds: 200),
          ),
          AnimatedOpacity(
            child: Stack(children: <Widget>[
              Container(
                alignment: Alignment.bottomRight,
                child: Column(
                  children: <Widget>[
                    Row(children: <Widget>[
                      Expanded(child: Container()),
                      Hero(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Material(
                            child: InkWell(
                              child: Padding(
                                child: Text(
                                  'Sponsor',
                                  style: Theme.of(context).textTheme.display3,
                                ),
                                padding: EdgeInsets.all(12),
                              ),
                              highlightColor: Theme.of(context).canvasColor,
                              onTap: () =>
                                  Navigator.of(context).pushNamed('/sponsor'),
                              splashColor: Theme.of(context).accentColor,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: BorderSide(
                                width: 2,
                                color:
                                    Theme.of(context).textTheme.display3.color,
                              ),
                            ),
                          ),
                        ),
                        tag: 'Sponsor',
                      ),
                    ]),
                    Padding(
                      child: Text('someone',
                          style: Theme.of(context).textTheme.display1),
                      padding: EdgeInsets.all(12),
                    ),
                    Row(children: <Widget>[
                      Expanded(child: Container()),
                      Hero(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Material(
                            child: InkWell(
                              child: Container(
                                alignment: Alignment.topCenter,
                                child: Text(
                                  'in need',
                                  style: Theme.of(context).textTheme.display3,
                                ),
                                padding: EdgeInsets.all(12),
                              ),
                              highlightColor: Theme.of(context).canvasColor,
                              onTap: () =>
                                  Navigator.of(context).pushNamed('/in_need'),
                              splashColor: Theme.of(context).accentColor,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: BorderSide(
                                width: 2,
                                color:
                                    Theme.of(context).textTheme.display3.color,
                              ),
                            ),
                          ),
                        ),
                        tag: 'in need',
                      ),
                    ]),
                    Padding(
                      child: Row(children: <Widget>[
                        Spacer(flex: 3),
                        Text('in your',
                            style: Theme.of(context).textTheme.display1),
                        Spacer(flex: 2),
                      ]),
                      padding: EdgeInsets.all(12),
                    ),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                ),
                padding: EdgeInsets.fromLTRB(0, 0, 12, 120),
              ),
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
                padding: EdgeInsets.fromLTRB(24, 24, 0, 0),
              ),
            ]),
            duration: Duration(milliseconds: 200),
            opacity: snapshot.hasData ? 1 : 0,
          ),
        ]);
      },
      future: Future.delayed(Duration(seconds: 2), () => true),
    ));
  }
}
