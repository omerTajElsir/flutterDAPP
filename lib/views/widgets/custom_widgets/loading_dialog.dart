import 'package:flutter/material.dart';
import 'package:flutter_app/styles/textStyles.dart';

class LoadingDialog extends StatelessWidget {
  final String title;
  final String content;
  final Function() onCancel;

  const LoadingDialog({
    Key? key,
    required this.title,
    required this.content,
    required this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xff272E3F),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(
              color: Colors.white,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: headingStyle,
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.only(left: 25, right: 25, bottom: 0),
              child: Wrap(
                children: [
                  Text(
                    "$content",
                    style: normalLabelStyle,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.only(
                  left: 25, right: 25, bottom: 0, top: 10),
              child: InkWell(
                onTap: onCancel,
                child: Text(
                  "Cancel",
                  style: normalLabelStyle.copyWith(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
