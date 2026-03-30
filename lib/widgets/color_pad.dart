import 'package:flutter/material.dart';
import '../models/game_state.dart';

class ColorPad extends StatelessWidget {
  const ColorPad({
    super.key,
    required this.gameColor,
    required this.onTap,
    this.highlighted = false,
    this.enabled = true,
    this.baseColor,
  });

  final GameColor gameColor;
  final VoidCallback onTap;
  final bool highlighted;
  final bool enabled;
  final Color? baseColor;

  @override
  Widget build(BuildContext context) {
    final Color baseColor = this.baseColor ?? gameColor.color;
    final Color cardColor = highlighted
        ? Color.lerp(baseColor, Colors.white, 0.28)!
        : baseColor;

    return AnimatedScale(
      duration: const Duration(milliseconds: 170),
      scale: highlighted ? 1.03 : 1,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 170),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: highlighted
                  ? baseColor.withAlpha(190)
                  : Colors.black.withAlpha(80),
              blurRadius: highlighted ? 20 : 8,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: enabled ? onTap : null,
            borderRadius: BorderRadius.circular(20),
            child: SizedBox(
              width: 220,
              height: 170,
              child: Center(
                child: Text(
                  gameColor.label,
                  style: const TextStyle(
                    fontFamily: 'Sora',
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: 0.2,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
