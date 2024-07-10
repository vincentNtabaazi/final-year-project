import 'package:flutter/material.dart';

class AuthSnackBar {
  static show(BuildContext context, String message, bool error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        showCloseIcon: true,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(bottom: 30, left: 10, right: 10),
        content: Row(
          children: [
            error
                ? const Icon(
                    Icons.cancel,
                    color: Colors.red,
                  )
                : const Icon(Icons.done, color: Colors.green),
            const SizedBox(
              width: 20,
            ),
            SizedBox(
                width: 252,
                child: Text(
                  message,
                  style: const TextStyle(overflow: TextOverflow.ellipsis),
                )),
          ],
        ),

      
      ),
    );
  }
}
