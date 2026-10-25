import 'package:flutter/material.dart';

class ConfirmedListScreen extends StatelessWidget {

  const ConfirmedListScreen({
    super.key,
    required this.list
  });

  final List<String> list;

  @override
  Widget build(BuildContext context) {

    return Text('Lista de ${list.length} itens');

  }

}