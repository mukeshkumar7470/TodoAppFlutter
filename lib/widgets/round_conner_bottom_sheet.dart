import 'package:flutter/material.dart';

class RoundConnerBototmSheet extends StatelessWidget {
  Widget child;

  RoundConnerBototmSheet(this.child);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0))),
          child: child),
    );
  }
}