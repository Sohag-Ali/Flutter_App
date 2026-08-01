import 'package:flutter/material.dart';

class SensorCard extends StatefulWidget {
  final IconData icon;
  final String value;
  final String unit;
  final String title;
  final Color color;
  final VoidCallback? onTap;

  const SensorCard({
    super.key,
    required this.icon,
    required this.value,
    required this.unit,
    required this.title,
    required this.color,
    this.onTap,
  });

  @override
  State<SensorCard> createState() => _SensorCardState();
}

class _SensorCardState extends State<SensorCard> {
  bool _isPressed = false;
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        onTap: widget.onTap,
        child: AnimatedScale(
          scale: _isPressed ? 0.96 : (_isHovered ? 1.02 : 1.0),
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeOutCubic,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: widget.color.withValues(alpha: 0.16),
                width: 1.0,
              ),
              boxShadow: [
                BoxShadow(
                  color: widget.color.withValues(alpha: _isHovered ? 0.12 : 0.04),
                  blurRadius: _isHovered ? 12 : 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Compact thin circular border ring
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 1.0,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: widget.color.withValues(alpha: 0.04),
                        border: Border.all(
                          color: widget.color,
                          width: 2.0,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(widget.icon, color: widget.color, size: 20),
                          const SizedBox(height: 2),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text(
                                widget.value,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                  color: Color(0xFF1E3A27),
                                  height: 1.0,
                                ),
                              ),
                              if (widget.unit.isNotEmpty) ...[
                                const SizedBox(width: 2),
                                Text(
                                  widget.unit,
                                  style: TextStyle(
                                    fontSize: 10.5,
                                    fontWeight: FontWeight.w700,
                                    color: widget.color.withValues(alpha: 0.85),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 6),

                // Bengali Parameter Title below circle
                Text(
                  widget.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF203326),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
