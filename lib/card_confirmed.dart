import 'package:flutter/material.dart';

class CardConfirmed extends StatelessWidget {
  const CardConfirmed({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: Theme.of(context).colorScheme.primary
                  .withValues(alpha: 0.1),
              child: Icon(
                Icons.person_outline,
                color: Theme.of(context).colorScheme.primary,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(name, style: Theme.of(context).textTheme.titleMedium),
            ),
            const Icon(Icons.check_circle, color: Color(0xFF218653)),
          ],
        ),
      ),
    );
  }
}
