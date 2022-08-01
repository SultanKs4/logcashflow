import 'package:flutter/material.dart';

class TextSummaryWidget extends StatelessWidget {
  final String text;
  final Color color;
  const TextSummaryWidget({
    Key? key,
    required this.text,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: color,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
