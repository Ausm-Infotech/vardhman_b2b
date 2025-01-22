import 'package:flutter/material.dart';

class HeaderView extends StatelessWidget {
  final Widget? leading, trailing, title, tabBar;
  final double elevation;

  const HeaderView({
    super.key,
    this.leading,
    this.trailing,
    this.title,
    this.elevation = 4.0,
    this.tabBar,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: elevation,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 12.0,
              top: 12,
              right: 12,
              bottom: tabBar != null ? 0 : 12,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                if (leading != null) leading!,
                if (title != null) ...[
                  const SizedBox(width: 8),
                  Expanded(
                    child: title!,
                  ),
                ],
                if (trailing != null) ...[const SizedBox(width: 8), trailing!],
              ],
            ),
          ),
          if (tabBar != null) ...[
            const SizedBox(
              height: 4,
            ),
            tabBar!
          ],
        ],
      ),
    );
  }
}
