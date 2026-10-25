import 'package:flutter/material.dart';

class CardConfirmed extends StatelessWidget {

  const CardConfirmed({
    super.key,
    required this.name
  });

  final String name;

  @override
  Widget build(BuildContext context) {

    return Text(name);

  }

}