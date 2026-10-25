import 'package:flutter/material.dart';

import 'card_checkin.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.generateTicket,
    required this.dataQrCode,
    required this.scanResult,
    required this.onFormChanged,
    required this.onGenerateTicket,
    required this.onStartReadingTicket,
  });

  final TextEditingController nameController;
  final TextEditingController emailController;
  final bool generateTicket;
  final String dataQrCode;
  final String scanResult;
  final VoidCallback onFormChanged;
  final VoidCallback onGenerateTicket;
  final VoidCallback onStartReadingTicket;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          controller: nameController,
          onChanged: (_) => onFormChanged(),
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Name',
          ),
        ),
        TextField(
          controller: emailController,
          onChanged: (_) => onFormChanged(),
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Email',
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed:
              nameController.text.trim().isEmpty ||
                  emailController.text.trim().isEmpty
              ? null
              : onGenerateTicket,
          child: const Text('Gerar QRCode'),
        ),
        const SizedBox(height: 16),
        if (generateTicket)
          CardCheckin(
            name: nameController.text,
            email: emailController.text,
            dataQrCode: dataQrCode,
            scanResult: scanResult,
            onStartReadingTicket: onStartReadingTicket,
          ),
      ],
    );
  }
}
