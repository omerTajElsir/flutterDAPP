import 'package:flutter/material.dart';

import '../../../styles/textStyles.dart';

class MyAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final String confirmText;
  final String cancelText;
  final VoidCallback onConfirm;

  const MyAlertDialog({
    Key? key,
    required this.title,
    required this.content,
    required this.onConfirm,
    this.confirmText = 'Exit',
    this.cancelText = 'No',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.only(top: 16),
        // width: MediaQuery.of(context).size.width - 50,
        // margin: EdgeInsets.only(left: 60, right: 60),
        decoration: BoxDecoration(
          color: const Color(0xff272E3F),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: headingStyle,
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.only(left: 25, right: 25, bottom: 19),
              child: Text(
                content,
                style: normalLabelStyle,
                textAlign: TextAlign.center,
              ),
            ),
            Container(color: Colors.blueGrey, height: 0.5),
            Row(
              // crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        cancelText,
                        style: optionStyle.copyWith(color: Colors.red),
                      ),
                    ),
                  ),
                ),
                Container(
                  color: Colors.grey,
                  width: 0.5,
                  height: 43.5,
                ),
                Expanded(
                  child: InkWell(
                    onTap: onConfirm,
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        confirmText,
                        style: optionStyle.copyWith(color: Colors.red),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
