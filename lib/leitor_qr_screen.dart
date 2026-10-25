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
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Leia seu QR Code', style: textTheme.headlineSmall),
          const SizedBox(height: 6),
          Text('Aponte a câmera para o QR Code', style: textTheme.bodyMedium),
          const SizedBox(height: 18),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  MobileScanner(onDetect: onDetect),
                  IgnorePointer(
                    child: Center(
                      child: Container(
                        width: 230,
                        height: 230,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 3),
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x66000000),
                              blurRadius: 12,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: onCancel,
            icon: const Icon(Icons.close),
            label: const Text('Cancelar leitura'),
          ),
        ],
      ),
    );
  }
}
