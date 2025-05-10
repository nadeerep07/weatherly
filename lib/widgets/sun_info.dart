import 'package:flutter/material.dart';

class SunInfo extends StatelessWidget {
  const SunInfo({
    super.key,
    required this.icon,
    required this.label,
    required this.time,
  });

  final IconData icon;
  final String label;
  final String? time;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: icon == Icons.wb_sunny ? Colors.yellow : Colors.deepPurple,
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
              time ?? '',
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
