import 'package:flutter/material.dart';
import 'package:bloombyte_inventory_application/Pages/home page.dart';
import 'package:bloombyte_inventory_application/Pages/request page.dart';
import 'package:bloombyte_inventory_application/Pages/profile page.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const HomePage(),
    RequestPage(),
    ProfilePage(),
  ];

  final List<IconData> _icons = [
    Icons.home_outlined,
    Icons.receipt_long_outlined,
    Icons.person_outline,
  ];

  final List<IconData> _activeIcons = [
    Icons.home,
    Icons.receipt_long,
    Icons.person,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: Container(
        height: 65,
        decoration: const BoxDecoration(
          color: Colors.black,
          boxShadow: [BoxShadow(color: Colors.black45, blurRadius: 10)],
        ),
        child: Row(
          children: List.generate(_icons.length, (index) {
            final bool isSelected = _selectedIndex == index;
            return Expanded(
              child: _NavItem(
                icon: isSelected ? _activeIcons[index] : _icons[index],
                isSelected: isSelected,
                onTap: () {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              ),
            );
          }),
        ),
      ),
    );
  }
}

class _NavItem extends StatefulWidget {
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      onTap: widget.onTap,
      child: Center(
        child: AnimatedScale(
          scale: _pressed ? 0.8 : 1.0,
          duration: const Duration(milliseconds: 120),
          curve: Curves.easeOut,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Icon(widget.icon, size: 28, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
