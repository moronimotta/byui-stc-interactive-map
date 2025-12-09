import 'package:flutter/material.dart';

/// Women's bathroom information widget
class WomensBathroomWidget extends StatelessWidget {
  final String location;

  const WomensBathroomWidget({super.key, required this.location});

  String _getImagePath() {
    if (location.contains('141') || location.contains('145')) {
      return 'Bathroom-1-145.jpg';
    } else if (location.contains('Floor 2') || location.contains('276')) {
      return 'Bathroom-2-276.jpg';
    } else if (location.contains('Floor 3') || location.contains('330')) {
      return 'Bathroom-3-330.jpg';
    }
    return 'Bathroom-2-276.jpg';
  }

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
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          _getImagePath(),
                          width: 300,
                          height: 280,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: 300,
                              height: 280,
                              color: Colors.pink.shade100,
                              child: Icon(
                                Icons.woman,
                                size: 80,
                                color: Colors.pink.shade700,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(0, 0.2),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'Women\'s Restroom\n\n$location\n\nAvailable for student and faculty use.',
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
