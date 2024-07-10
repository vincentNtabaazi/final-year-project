import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medbridge/src/utils/constants.dart';

class OutButton extends StatefulWidget {
  final String text;
  final VoidCallback onpressed;
  final bool disabled;
  const OutButton({
    super.key,
    required this.text,
    required this.onpressed,
    this.disabled = false,
  });

  @override
  State<OutButton> createState() => _OutButtonState();
}

class _OutButtonState extends State<OutButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.disabled ? null : widget.onpressed,
      child: Material(
        borderRadius: BorderRadius.circular(10),
        elevation: 1,
        child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Constants.primaryColor, width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            height: 50,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: widget.disabled
                      ? const CupertinoActivityIndicator(
                          // strokeWidth: 3,
                          color: Color.fromARGB(255, 8, 33, 99),
                        )
                      : Text(
                          widget.text,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 8, 33, 99),
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        )),
            )),
      ),
    );
  }
}
