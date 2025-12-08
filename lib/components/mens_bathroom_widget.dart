import 'package:flutter/material.dart';

/// Men's bathroom information widget
class MensBathroomWidget extends StatelessWidget {
  const MensBathroomWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          width: 375,
          height: 600,
          decoration: BoxDecoration(
            color: Color(0xFF95D7AE),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(width: 2),
          ),
          child: Stack(
            children: [
              Stack(
                children: [
                  Align(
                    alignment: AlignmentDirectional(0, -0.8),
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Container(
                        width: 300,
                        height: 280,
                        decoration: BoxDecoration(
                          color: Colors.blue.shade100,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.man,
                          size: 120,
                          color: Colors.blue.shade700,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(0, 0.2),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'Men\'s Restroom\n\nLocated throughout the building\nfor student and faculty use.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: AlignmentDirectional(1, -1),
                child: Padding(
                  padding: EdgeInsets.all(4),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.close,
                      color: Color(0xFFFF0000),
                      size: 24,
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
