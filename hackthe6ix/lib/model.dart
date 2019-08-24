import 'package:flutter/material.dart';

enum ModelAspect { home }

class _Model extends InheritedModel<ModelAspect> {
  static _Model of(BuildContext context) =>
      context.inheritFromWidgetOfExactType(_Model) as _Model;

  const _Model({Key key, @required Widget child})
      : assert(child != null),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(_Model _model) => true;

  @override
  bool updateShouldNotifyDependent(
          _Model _model, Set<ModelAspect> modelAspect) =>
      true;
}

class Model extends StatefulWidget {
  static _Model of(BuildContext context) => _Model.of(context);

  const Model({Key key, @required this.child})
      : assert(child != null),
        super(key: key);

  final Widget child;

  @override
  ModelState createState() => ModelState();
}

class ModelState extends State<Model> {
  @override
  Widget build(BuildContext context) => _Model(child: widget.child);
}
