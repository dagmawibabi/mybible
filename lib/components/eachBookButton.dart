import 'package:flutter/material.dart';

class EachBookButton extends StatefulWidget {
  const EachBookButton({
    super.key,
    required this.book,
  });

  final String book;

  @override
  State<EachBookButton> createState() => _EachBookButtonState();
}

class _EachBookButtonState extends State<EachBookButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: 15.0,
      ),
      padding: const EdgeInsets.only(
        top: 15.0,
        bottom: 15.0,
        left: 15.0,
        right: 10.0,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey[800]!,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Text(
        widget.book.toString(),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16.0,
          // fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
