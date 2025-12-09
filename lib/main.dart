import 'package:flutter/material.dart';
import 'dart:ui';
import 'components/vending_machines_widget.dart';
import 'components/microwave_widget.dart';
import 'components/printer2_widget.dart';
import 'components/printer3_widget.dart';
import 'components/mens_bathroom_widget.dart';
import 'components/womens_bathroom_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BYUI Campus Map',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF73956F)),
        useMaterial3: true,
      ),
      home: const HomePageWidget(),
    );
  }
}

// Color Palette
class AppColors {
  static const charcoalBlue = Color(0xFF454851);
  static const sageGreen = Color(0xFF73956F);
  static const mutedTeal = Color(0xFF7BAE7F);
  static const celadon = Color(0xFF95D7AE);
  static const peachFuzz = Color(0xFFF2C3A5);
}

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({super.key});

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: AppColors.peachFuzz,
        appBar: AppBar(
          backgroundColor: AppColors.charcoalBlue,
          automaticallyImplyLeading: false,
          title: Center(
            child: Text(
              _currentPage == 0
                  ? 'Floor 1 - Facility Map'
                  : _currentPage == 1
                  ? 'Floor 2 - Facility Map'
                  : 'Floor 3 - Facility Map',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          centerTitle: true,
          elevation: 2,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              // Interactive Map in the center
              Expanded(
                child: _currentPage == 0
                    ? MapPage(floorNumber: 1)
                    : _currentPage == 1
                    ? MapPage(floorNumber: 2)
                    : MapPage(floorNumber: 3),
              ),
              // Bottom buttons
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _currentPage = 0;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _currentPage == 0
                            ? AppColors.sageGreen
                            : AppColors.mutedTeal,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        minimumSize: Size(double.infinity, 85),
                      ),
                      child: Text('1', style: TextStyle(fontSize: 32)),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _currentPage = 1;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _currentPage == 1
                            ? AppColors.celadon
                            : AppColors.mutedTeal,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        minimumSize: Size(double.infinity, 85),
                      ),
                      child: Text('2', style: TextStyle(fontSize: 32)),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _currentPage = 2;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _currentPage == 2
                            ? AppColors.sageGreen
                            : AppColors.mutedTeal,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        minimumSize: Size(double.infinity, 85),
                      ),
                      child: Text('3', style: TextStyle(fontSize: 32)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MapPage extends StatelessWidget {
  final int floorNumber;

  const MapPage({super.key, required this.floorNumber});

  @override
  Widget build(BuildContext context) {
    return InteractiveMap(floorNumber: floorNumber);
  }
}

class InteractiveMap extends StatefulWidget {
  final int floorNumber;

  const InteractiveMap({super.key, required this.floorNumber});

  @override
  State<InteractiveMap> createState() => _InteractiveMapState();
}

class _InteractiveMapState extends State<InteractiveMap> {
  final TransformationController _transformationController =
      TransformationController();

  // Bathroom locations 
  List<BathroomPin> _getBathroomPins() {
    if (widget.floorNumber == 2) {
      return [
        BathroomPin(x: 0.55, y: 0.40, label: 'Men\'s', type: BathroomType.mens),
        BathroomPin(
          x: 0.55,
          y: 0.32,
          label: 'Women\'s',
          type: BathroomType.womens,
        ),
      ];
    } else if (widget.floorNumber == 1) {
      return [
        // Bathroom near room 125
        BathroomPin(
          x: 0.50,
          y: 0.55,
          label: 'Men\'s - Near Room 125',
          type: BathroomType.mens,
        ),
        BathroomPin(
          x: 0.5,
          y: 0.45,
          label: 'Women\'s - Near Room 125',
          type: BathroomType.womens,
        ),
        // Bathroom near room 141 (bottom left)
        BathroomPin(
          x: 0.15,
          y: 0.75,
          label: 'Men\'s - Near Room 141',
          type: BathroomType.mens,
        ),
        BathroomPin(
          x: 0.2,
          y: 0.80,
          label: 'Women\'s - Near Room 141',
          type: BathroomType.womens,
        ),
      ];
    } else if (widget.floorNumber == 3) {
      return [
        BathroomPin(
          x: 0.55,
          y: 0.4,
          label: 'Men\'s - Floor 3',
          type: BathroomType.mens,
        ),
        BathroomPin(
          x: 0.55,
          y: 0.3,
          label: 'Women\'s - Floor 3',
          type: BathroomType.womens,
        ),
      ];
    }
    return [];
  }

  // Facility locations 
  List<FacilityPin> _getFacilityPins() {
    if (widget.floorNumber == 2) {
      return [
        FacilityPin(
          x: 0.65,
          y: 0.5,
          label: 'Vending Machines',
          type: FacilityType.vendingMachine,
        ),
        FacilityPin(
          x: 0.25,
          y: 0.5,
          label: 'Microwave',
          type: FacilityType.microwave,
        ),
        FacilityPin(
          x: 0.75,
          y: 0.27,
          label: 'Printer',
          type: FacilityType.printer2,
        ),
      ];
    } else if (widget.floorNumber == 3) {
      return [
        FacilityPin(
          x: 0.82,
          y: 0.3,
          label: 'Printer',
          type: FacilityType.printer3,
        ),
      ];
    }
    return [];
  }

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth = constraints.maxWidth * 0.95;
          final maxHeight = constraints.maxHeight * 0.95;

          double mapWidth, mapHeight;
          if (maxWidth / maxHeight > 3 / 2) {
            mapHeight = maxHeight;
            mapWidth = mapHeight * 3 / 2;
          } else {
            mapWidth = maxWidth;
            mapHeight = mapWidth * 2 / 3;
          }

          return InteractiveViewer(
            transformationController: _transformationController,
            minScale: 0.5,
            maxScale: 4.0,
            boundaryMargin: const EdgeInsets.all(20),
            child: Container(
              width: mapWidth,
              height: mapHeight,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.charcoalBlue, width: 3),
                color: Colors.white,
              ),
              child: Stack(
                children: [
                  // Map image or placeholder
                  Positioned.fill(
                    child: Image.asset(
                      widget.floorNumber == 2
                          ? 'assets/second-floor.png'
                          : widget.floorNumber == 1
                          ? 'assets/first-floor.png'
                          : 'assets/third-floor.png',
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        // Final fallback: placeholder
                        return Container(
                          color: AppColors.peachFuzz.withOpacity(0.3),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.map,
                                  size: 100,
                                  color: AppColors.charcoalBlue,
                                ),
                                SizedBox(height: 16),
                                Text(
                                  'Floor ${widget.floorNumber} Map\nPlace image in: assets/${widget.floorNumber == 1
                                      ? 'first'
                                      : widget.floorNumber == 2
                                      ? 'second'
                                      : 'third'}-floor.png',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppColors.charcoalBlue,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  // Bathroom pins overlay
                  ..._getBathroomPins().map(
                    (pin) => Positioned(
                      left: pin.x * mapWidth - 20,
                      top: pin.y * mapHeight - 40,
                      child: BathroomPinWidget(pin: pin),
                    ),
                  ),
                  // Facility pins overlay
                  ..._getFacilityPins().map(
                    (pin) => Positioned(
                      left: pin.x * mapWidth - 20,
                      top: pin.y * mapHeight - 40,
                      child: FacilityPinWidget(pin: pin),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

enum BathroomType { mens, womens }

class BathroomPin {
  final double x;
  final double y;
  final String label;
  final BathroomType type;

  BathroomPin({
    required this.x,
    required this.y,
    required this.label,
    required this.type,
  });
}

class BathroomPinWidget extends StatelessWidget {
  final BathroomPin pin;

  const BathroomPinWidget({super.key, required this.pin});

  IconData _getIcon() {
    switch (pin.type) {
      case BathroomType.mens:
        return Icons.man;
      case BathroomType.womens:
        return Icons.woman;
    }
  }

  Color _getColor() {
    switch (pin.type) {
      case BathroomType.mens:
        return AppColors.charcoalBlue;
      case BathroomType.womens:
        return AppColors.celadon;
    }
  }

  void _showBathroomDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: pin.type == BathroomType.mens
                ? MensBathroomWidget(location: pin.label)
                : WomensBathroomWidget(location: pin.label),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showBathroomDetails(context),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: _getColor(),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(_getIcon(), color: Colors.white, size: 24),
          ),
          Container(width: 2, height: 8, color: _getColor()),
        ],
      ),
    );
  }
}

// Facility Types
enum FacilityType { vendingMachine, microwave, printer2, printer3 }

class FacilityPin {
  final double x;
  final double y;
  final String label;
  final FacilityType type;

  FacilityPin({
    required this.x,
    required this.y,
    required this.label,
    required this.type,
  });
}

class FacilityPinWidget extends StatelessWidget {
  final FacilityPin pin;

  const FacilityPinWidget({super.key, required this.pin});

  IconData _getIcon() {
    switch (pin.type) {
      case FacilityType.vendingMachine:
        return Icons.fastfood_rounded;
      case FacilityType.microwave:
        return Icons.microwave_sharp;
      case FacilityType.printer2:
      case FacilityType.printer3:
        return Icons.print_sharp;
    }
  }

  Color _getColor() {
    return AppColors.celadon;
  }

  void _showFacilityDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: _getWidgetForType(),
          ),
        );
      },
    );
  }

  Widget _getWidgetForType() {
    switch (pin.type) {
      case FacilityType.vendingMachine:
        return VendingMachinesWidget();
      case FacilityType.microwave:
        return MicrowaveWidget();
      case FacilityType.printer2:
        return Printer2Widget();
      case FacilityType.printer3:
        return Printer3Widget();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showFacilityDetails(context),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: _getColor(),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(_getIcon(), color: Colors.white, size: 24),
          ),
          Container(width: 2, height: 8, color: _getColor()),
        ],
      ),
    );
  }
}
