import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app/theme/theme_data.dart';

import 'custom_button.dart';

class ToolBar extends StatelessWidget {
  const ToolBar({
    Key? key,
    required this.onZoomInPressed,
    required this.onZoomOutPressed,
    required this.interval,
    required this.intervals,
    required this.onIntervalChange,
  }) : super(key: key);

  final void Function() onZoomInPressed;
  final void Function() onZoomOutPressed;
  final void Function(String) onIntervalChange;
  final List<String> intervals;
  final String interval;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 60,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 15,
          ),
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: intervals.length,
                itemBuilder: (BuildContext ctxt, int index) {
                  return Center(
                    child: Container(
                      margin: EdgeInsets.only(left: 20),
                      child: InkWell(
                        onTap: () {
                          onIntervalChange(intervals[index]);
                        },
                        child: Text(
                          intervals[index],
                          style: interval == intervals[index]
                              ? TextStyle(color: Colors.amber)
                              : TextStyle(color: Colors.white70),
                        ),
                      ),
                    ),
                  );
                }),
          ),
          CustomButton(
            onPressed: onZoomInPressed,
            child: Icon(
              Icons.zoom_in,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          CustomButton(
            onPressed: onZoomOutPressed,
            child: Icon(
              Icons.zoom_out,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: 15,
          ),
        ],
      ),
    );
  }
}
