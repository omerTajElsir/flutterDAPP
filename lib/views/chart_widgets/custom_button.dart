import 'package:flutter/material.dart';
import 'package:flutter_app/theme/theme_data.dart';

class CustomButton extends StatelessWidget {
  final void Function() onPressed;
  final Widget child;
  final double? width;
  final Color? color;

  const CustomButton({
    Key? key,
    required this.child,
    required this.onPressed,
    this.width,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(30)),
        child: child,
      ),
    );
    SizedBox(
      width: width ?? 30,
      height: 30,
      child: RawMaterialButton(
        elevation: 0,
        fillColor: color ?? Theme.of(context).background,
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
