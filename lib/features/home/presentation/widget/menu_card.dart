// ===== MenuCard =====
import 'package:flutter/material.dart';

class MenuCard extends StatefulWidget {
  final Gradient gradient;
  final String imageAsset;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const MenuCard({
    super.key,
    required this.gradient,
    required this.imageAsset,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  State<MenuCard> createState() => _MenuCardState();
}

class _MenuCardState extends State<MenuCard> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          isPressed = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          isPressed = false;
        });
        widget.onTap();
      },
      onTapCancel: () {
        setState(() {
          isPressed = false;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        transform: isPressed
            // ignore: deprecated_member_use
            ? (Matrix4.identity()..translate(0, -5, 0))
            : Matrix4.identity(),
        decoration: BoxDecoration(
          gradient: widget.gradient,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              // ignore: deprecated_member_use
              color: Colors.black.withOpacity(isPressed ? 0.3 : 0.08),
              blurRadius: isPressed ? 12 : 8,
              offset: Offset(0, isPressed ? 8 : 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(18),
        child: Row(
          textDirection: TextDirection.rtl,
          children: [
            Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(widget.imageAsset),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    widget.title,
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.subtitle,
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF666666),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}