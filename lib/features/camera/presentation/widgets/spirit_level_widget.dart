import 'package:flutter/material.dart';

/// Horizontal spirit level indicator showing a balance line with center bubble.
class SpiritLevelWidget extends StatelessWidget {
  const SpiritLevelWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IgnorePointer(
        child: Container(
          width: 192,
          height: 2,
          color: Colors.white.withValues(alpha: 0.4),
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: <Widget>[
              Container(
                width: 32,
                height: 10,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.6),
                    width: 1,
                  ),
                  color: Colors.black.withValues(alpha: 0.4),
                ),
                alignment: Alignment.center,
                child: Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: Color(0xFF34D399), // emerald-400
                    shape: BoxShape.circle,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Color(0xFF34D399),
                        blurRadius: 4,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
