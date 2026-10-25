import 'package:flutter/material.dart';

import 'card_confirmed.dart';

class ConfirmedListScreen extends StatelessWidget {

  const ConfirmedListScreen({
    super.key, 
    required this.list
  });

  final List<String> list;

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [

            Text("Lista dos ${list.length} nomes já confirmados para o evento:"),

            ListView.builder(
                shrinkWrap: true,
                itemCount: list.length,
                itemBuilder: (context, index) {
                    return CardConfirmed(name: list[index]);
                },
            )
            
        ]
    );
    
  }
}
