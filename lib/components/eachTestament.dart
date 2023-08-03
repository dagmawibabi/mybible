import 'package:flutter/material.dart';

class EachTestament extends StatefulWidget {
  const EachTestament({
    super.key,
    required this.testament,
  });

  final String testament;

  @override
  State<EachTestament> createState() => _EachTestamentState();
}

class _EachTestamentState extends State<EachTestament> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // width: double.infinity,
      // width: 200.0,
      margin: const EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: 5.0,
      ),
      padding: const EdgeInsets.only(
        top: 15.0,
        bottom: 15.0,
        left: 25.0,
        right: 25.0,
      ),
      decoration: BoxDecoration(
        color: Colors.greenAccent.withOpacity(0.05),
        border: Border.all(
          color: Colors.grey[800]!,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Text(
        widget.testament,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16.0,
          // fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
