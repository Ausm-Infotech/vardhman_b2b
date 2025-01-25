import 'package:flutter/material.dart';
import 'package:vardhman_b2b/constants.dart';

class NavRailContainer extends StatelessWidget {
  final String title;
  final Widget child;

  const NavRailContainer({
    super.key,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(
              color: VardhmanColors.dividerGrey,
              width: 0.5,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: child,
        ),
        Positioned(
          top: -8,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Text(
              title,
            ),
          ),
        )
      ],
    );
  }
}
