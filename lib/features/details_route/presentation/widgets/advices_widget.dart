import 'package:flutter/material.dart';

class AdviceWidget extends StatelessWidget {
  final String label;
  const AdviceWidget({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.lightbulb_outline),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                label,
                style: TextStyle(fontSize: 16),
              ),
            )
          ],
        )
      ],
    );
  }
}
