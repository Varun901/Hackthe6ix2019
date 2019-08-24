import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class InNeed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Hero(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              child: Material(
                child: Container(
                  alignment: Alignment.topCenter,
                  child: Text(
                    'in need',
                    style: Theme.of(context).textTheme.display3,
                  ),
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
              height: double.infinity,
              padding: EdgeInsets.all(12),
              width: double.infinity,
            ),
          ),
          tag: 'in need',
        ),
      ),
    );
  }
}
