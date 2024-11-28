import 'package:duidku/shared/theme.dart';
import 'package:flutter/material.dart';

class ModalAlert extends StatelessWidget {
  final String title;
  final String message;
  final Function() completion;
  const ModalAlert({
    super.key,
    required this.title,
    required this.message,
    required this.completion,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      title: Text(title),
      content: Text(
        message,
        style: inter.copyWith(
          fontWeight: medium,
        ),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    side: BorderSide(
                      color: primaryColor,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the modal
                  },
                  child: Text(
                    'Tidak',
                    style: inter.copyWith(
                      fontWeight: medium,
                      color: primaryColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 24,
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the modal
                    completion(); // Run the callback
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                  ),
                  child: Text(
                    'Ya',
                    style: inter.copyWith(
                      fontWeight: medium,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
