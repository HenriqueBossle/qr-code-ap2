import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class LeitorQrScreen extends StatelessWidget {
  const LeitorQrScreen({
    super.key,
    required this.onDetect,
    required this.onCancel,
  });

  final void Function(BarcodeCapture capture) onDetect;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Aponte a câmera para o QR Code'),
        Expanded(child: MobileScanner(onDetect: onDetect)),
        ElevatedButton(onPressed: onCancel, child: const Text('Cancelar')),
      ],
    );
  }
}
