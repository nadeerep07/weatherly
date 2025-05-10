import 'package:flutter/material.dart';

class TempInfo extends StatelessWidget {
  const TempInfo({
    super.key,
    required this.icon,
    required this.label,
    required this.temp,
  });

  final IconData icon;
  final String label;
  final double? temp;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: icon == Icons.thermostat ? Colors.green : Colors.blue,
          size: 50,
        ),
        const SizedBox(width: 5),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              '${temp?.toString()}°C',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w300,
                color: Colors.white.withValues(alpha: .7),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
