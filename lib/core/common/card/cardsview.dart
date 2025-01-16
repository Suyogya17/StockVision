import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  final String title;
  final Color color;
  final double width;
  final double height;

  const MyCard({
    super.key,
    required this.title,
    required this.color,
    this.width = 200.0, // Default width
    this.height = 100.0, // Default height
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
