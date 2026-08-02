import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<_Category> _categories = [
    _Category(
      image: 'assets/images/net2.png',
      title: 'Networking/System security Installation',
      imageHeight: 95,
    ),
    _Category(
      image: 'assets/images/satellite.png',
      title: 'Satellite/CCTV Installation',
      imageHeight: 95,
    ),
    _Category(
      image: 'assets/images/solar.png',
      title: 'Solar PV Installation/Maintenance',
      imageHeight: 95,
    ),
    _Category(
      image: 'assets/images/computer.png',
      title: 'Computer Hardware Repair/Maintenance',
      imageHeight: 95,
    ),
    _Category(
      image: 'assets/images/electrical.png',
      title: 'Home Electrical Appliances/Repair',
      imageHeight: 95,
    ),
    _Category(
      image: 'assets/images/creative.png',
      title: 'Creative Media/Digital Media Production',
      imageHeight: 95,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.only(top: 24, bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/invent.png',
                    height: 70,
                    width: 70,
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "CATEGORIES",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Container(height: 1.2, color: Colors.black),

            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 48,
                  vertical: 20,
                ),
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  final category = _categories[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _CategoryCard(
                      image: category.image,
                      title: category.title,
                      imageHeight: category.imageHeight,
                      onTap: () {},
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Category {
  final String image;
  final String title;
  final double imageHeight;

  _Category({
    required this.image,
    required this.title,
    required this.imageHeight,
  });
}

class _CategoryCard extends StatefulWidget {
  final String image;
  final String title;
  final double imageHeight;
  final VoidCallback onTap;

  const _CategoryCard({
    required this.image,
    required this.title,
    required this.imageHeight,
    required this.onTap,
  });

  @override
  State<_CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<_CategoryCard> {
  bool _pressed = false;
  Offset? _pointerDownPosition;
  static const double _scrollCancelThreshold = 10.0;

  static const double _cardHeight = 200;

  void _resetPress() {
    if (_pressed) setState(() => _pressed = false);
    _pointerDownPosition = null;
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      behavior: HitTestBehavior.opaque,
      onPointerDown: (event) {
        _pointerDownPosition = event.position;
        setState(() => _pressed = true);
      },
      onPointerMove: (event) {
        if (_pointerDownPosition == null) return;
        final distance = (event.position - _pointerDownPosition!).distance;
        if (distance > _scrollCancelThreshold) {
          _resetPress();
        }
      },
      onPointerUp: (event) {
        final wasStillPressed = _pressed;
        _resetPress();
        if (wasStillPressed) {
          widget.onTap();
        }
      },
      onPointerCancel: (_) => _resetPress(),
      child: AnimatedScale(
        scale: _pressed ? 0.95 : 1.0,
        duration: const Duration(milliseconds: 40),
        curve: Curves.easeOut,
        child: Container(
          width: double.infinity,
          height: _cardHeight,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: widget.imageHeight,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Image.asset(
                    widget.image,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Icon(
                          Icons.broken_image_outlined,
                          size: 40,
                          color: Colors.grey,
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
