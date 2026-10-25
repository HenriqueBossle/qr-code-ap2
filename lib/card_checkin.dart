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
    final textTheme = Theme.of(context).textTheme;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 260,
            child: Image.network(
              'https://images.squarespace-cdn.com/content/v1/58d09402db29d660e4781a57/1759526539438-G6NB2WWX7FG87EBUT6L6/_Sanchez_Danny_LA_COMIC_CON-13.jpg?format=1000w',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: const Color(0xFFECEBFA),
                alignment: Alignment.center,
                child: Icon(
                  Icons.celebration_outlined,
                  color: Theme.of(context).colorScheme.primary,
                  size: 42,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.verified_outlined,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Seu ingresso está quase pronto!',
                        style: textTheme.titleMedium,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _AttendeeDetail(label: 'Nome', value: name),
                const SizedBox(height: 10),
                _AttendeeDetail(label: 'E-mail', value: email),
                const SizedBox(height: 18),
                Text(
                  'Parabens você deu o primeiro passo no cadastro!',
                  style: textTheme.bodyLarge,
                ),
                const SizedBox(height: 4),
                Text(
                  'Agora leia o QRCode para terminar o Check-In',
                  style: textTheme.bodyMedium,
                ),
                if (dataQrCode.isNotEmpty) ...[
                  const SizedBox(height: 18),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFE9EAF1)),
                      ),
                      child: QrImageView(data: dataQrCode, size: 180),
                    ),
                  ),
                ],
                if (scanResult.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEAF7F0),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.check_circle_outline,
                          color: Color(0xFF218653),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'QR Code lido: $scanResult',
                            style: textTheme.bodyMedium?.copyWith(
                              color: const Color(0xFF176B42),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: 18),
                ElevatedButton.icon(
                  onPressed: onStartReadingTicket,
                  icon: const Icon(Icons.qr_code_scanner),
                  label: const Text('Ler QRCode de outro dispositivo'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AttendeeDetail extends StatelessWidget {
  const _AttendeeDetail({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text.rich(
            TextSpan(
              style: Theme.of(context).textTheme.bodyLarge,
              children: [
                TextSpan(
                  text: '$label: ',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                TextSpan(text: value),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
