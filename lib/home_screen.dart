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
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primary,
                const Color(0xFF8475F2),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'SEU PRÓXIMO EVENTO',
                      style: textTheme.labelMedium?.copyWith(
                        color: Colors.white.withValues(alpha: 0.8),
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Prepare-se para a Comic Con',
                      style: textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Cadastre-se para garantir seu check-in.',
                      style: textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withValues(alpha: 0.86),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              const Icon(
                Icons.auto_awesome,
                color: Color(0xFFFFD27A),
                size: 38,
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Text('Faça seu cadastro', style: textTheme.headlineSmall),
        const SizedBox(height: 6),
        Text(
          'Preencha seus dados para gerar seu ingresso digital.',
          style: textTheme.bodyMedium,
        ),
        const SizedBox(height: 18),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: nameController,
                  onChanged: (_) => onFormChanged(),
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(
                    labelText: 'Nome completo',
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                ),
                const SizedBox(height: 14),
                TextField(
                  controller: emailController,
                  onChanged: (_) => onFormChanged(),
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'E-mail',
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                ),
                const SizedBox(height: 18),
                ElevatedButton.icon(
                  onPressed:
                      nameController.text.trim().isEmpty ||
                          emailController.text.trim().isEmpty
                      ? null
                      : onGenerateTicket,
                  icon: const Icon(Icons.qr_code_2),
                  label: const Text('Gerar QRCode'),
                ),
              ],
            ),
          ),
        ),
        if (generateTicket) ...[
          const SizedBox(height: 20),
          CardCheckin(
            name: nameController.text,
            email: emailController.text,
            dataQrCode: dataQrCode,
            scanResult: scanResult,
            onStartReadingTicket: onStartReadingTicket,
          ),
        ],
      ],
    );
  }
}
