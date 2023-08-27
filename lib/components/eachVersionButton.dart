import 'package:flutter/material.dart';

class EachVersionButton extends StatefulWidget {
  const EachVersionButton({
    super.key,
    required this.versionData,
    required this.isSelected,
  });

  final Map versionData;
  final bool isSelected;

  @override
  State<EachVersionButton> createState() => _EachVersionButtonState();
}

class _EachVersionButtonState extends State<EachVersionButton> {
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
        color: Colors.grey[900]!,
        border: Border.all(
          color: Colors.grey[850]!,
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            spreadRadius: 1.0,
            offset: Offset(3, 4),
          )
        ],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.versionData["ID"].toString(),
                style: TextStyle(
                  color: widget.isSelected == true
                      ? Colors.greenAccent
                      : Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                widget.versionData["title"].toString(),
                style: TextStyle(
                  color: widget.isSelected == true
                      ? Colors.greenAccent.withOpacity(0.7)
                      : Colors.grey[500]!,
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.arrow_forward,
              color:
                  widget.isSelected == true ? Colors.greenAccent : Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
