import 'package:flutter/material.dart';

/// Vending machines on the second floor
class VendingMachinesWidget extends StatelessWidget {
  const VendingMachinesWidget({super.key});

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
                          'assets/Vending-2-286-1.jpg',
                          width: 300,
                          height: 280,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: 300,
                              height: 280,
                              color: Colors.grey[300],
                              child: Icon(
                                Icons.fastfood_rounded,
                                size: 80,
                                color: Colors.grey[600],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(0, 0.25),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'Vending machines on the second\nfloor they offer drinks, snacks\nand actual meals.',
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
