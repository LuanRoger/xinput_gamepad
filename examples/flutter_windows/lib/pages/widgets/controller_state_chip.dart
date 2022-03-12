import 'package:flutter/material.dart';

class ControllerStateChip extends StatelessWidget {
  final String text;
  final bool connected;
  final Color color;

  const ControllerStateChip(this.text, this.connected,
      {Key? key, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 110,
      height: 40,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Container(
          color: Colors.grey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      width: 10,
                      height: 10,
                      color: connected ? Colors.green : Colors.red,
                    )),
                Text(
                  text,
                  style: const TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
