import 'package:flutter/material.dart';
import 'dart:ui';

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
          leading: IconButton(
            icon: Icon(Icons.menu, color: Colors.white, size: 24),
            onPressed: () {
              print('Menu button pressed ...');
            },
          ),
          title: Align(
            alignment: AlignmentDirectional(0, -1),
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
          centerTitle: false,
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

  // Bathroom locations based on the map image (normalized coordinates 0-1)
  // These positions are relative to the image dimensions
  final List<BathroomPin> bathroomPins = [
    // Upper section bathrooms
    BathroomPin(x: 0.32, y: 0.28, label: 'Restroom', type: BathroomType.unisex),
    BathroomPin(x: 0.59, y: 0.28, label: 'Men\'s', type: BathroomType.mens),
    BathroomPin(
      x: 0.595,
      y: 0.32,
      label: 'Women\'s',
      type: BathroomType.womens,
    ),
    BathroomPin(x: 0.63, y: 0.32, label: 'Unisex', type: BathroomType.unisex),
    BathroomPin(
      x: 0.595,
      y: 0.365,
      label: 'Accessible',
      type: BathroomType.accessible,
    ),

    // Middle section bathrooms
    BathroomPin(
      x: 0.515,
      y: 0.35,
      label: 'Restroom',
      type: BathroomType.womens,
    ),
    BathroomPin(x: 0.535, y: 0.315, label: 'Restroom', type: BathroomType.mens),
    BathroomPin(
      x: 0.857,
      y: 0.3,
      label: 'Accessible',
      type: BathroomType.accessible,
    ),
    BathroomPin(
      x: 0.04,
      y: 0.58,
      label: 'Accessible',
      type: BathroomType.accessible,
    ),

    // Lower section bathrooms
    BathroomPin(x: 0.14, y: 0.62, label: 'Restroom', type: BathroomType.unisex),
    BathroomPin(
      x: 0.635,
      y: 0.615,
      label: 'Restroom',
      type: BathroomType.accessible,
    ),
  ];

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final mapWidth = constraints.maxWidth;
        final mapHeight = constraints.maxHeight;

        return InteractiveViewer(
          transformationController: _transformationController,
          minScale: 0.5,
          maxScale: 4.0,
          boundaryMargin: const EdgeInsets.all(20),
          child: Container(
            width: mapWidth,
            height: mapHeight,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
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
                ...bathroomPins.map(
                  (pin) => Positioned(
                    left: pin.x * mapWidth - 20,
                    top: pin.y * mapHeight - 40,
                    child: BathroomPinWidget(pin: pin),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

enum BathroomType { mens, womens, unisex, accessible }

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
      case BathroomType.accessible:
        return Icons.accessible;
      case BathroomType.unisex:
        return Icons.wc;
    }
  }

  Color _getColor() {
    switch (pin.type) {
      case BathroomType.mens:
        return AppColors.charcoalBlue;
      case BathroomType.womens:
        return AppColors.celadon;
      case BathroomType.accessible:
        return AppColors.sageGreen;
      case BathroomType.unisex:
        return AppColors.mutedTeal;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${pin.label} (${pin.type.name})'),
            duration: const Duration(seconds: 2),
          ),
        );
      },
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
