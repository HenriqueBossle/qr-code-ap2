import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CardCheckin extends StatelessWidget {
  const CardCheckin({
    super.key,
    required this.name,
    required this.email,
    required this.dataQrCode,
    required this.scanResult,
    required this.onStartReadingTicket,
  });

  final String name;
  final String email;
  final String dataQrCode;
  final String scanResult;
  final VoidCallback onStartReadingTicket;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Image.network(
              'https://images.squarespace-cdn.com/content/v1/58d09402db29d660e4781a57/1759526539438-G6NB2WWX7FG87EBUT6L6/_Sanchez_Danny_LA_COMIC_CON-13.jpg?format=1000w',
              width: 350,
              errorBuilder: (context, error, stackTrace) => const SizedBox(
                width: 350,
                child: Text('Imagem indisponível'),
              ),
            ),
            Text('Nome: $name'),
            Text('E-mail: $email'),
            const Text('Parabens você deu o primeiro passo no cadastro!'),
            const Text('Agora leia o QRCode para terminar o Check-In'),
            if (dataQrCode.isNotEmpty) QrImageView(data: dataQrCode, size: 200),
            if (scanResult.isNotEmpty) Text('QR Code lido: $scanResult'),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: onStartReadingTicket,
              child: const Text('Ler QRCode de outro dispositivo'),
            ),
          ],
        ),
      ),
    );
  }
}
