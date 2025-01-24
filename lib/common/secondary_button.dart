import 'package:flutter/material.dart';
import 'package:vardhman_b2b/constants.dart';

class SecondaryButton extends StatefulWidget {
  final Future<void> Function()? onPressed;
  final String text;
  final IconData? iconData;
  final bool wait;

  const SecondaryButton({
    super.key,
    this.iconData,
    required this.text,
    required this.onPressed,
    this.wait = true,
  });

  @override
  State<SecondaryButton> createState() => _SecondaryButtonState();
}

class _SecondaryButtonState extends State<SecondaryButton> {
  bool isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (widget.onPressed != null) {
          setState(() {
            isProcessing = true;
          });

          if (widget.wait) {
            await Future.delayed(
              const Duration(
                milliseconds: 500,
              ),
            );
          }

          await widget.onPressed!();

          setState(() {
            isProcessing = false;
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: VardhmanColors.dividerGrey,
            width: 1.5,
          ),
          color: widget.onPressed == null || isProcessing
              ? VardhmanColors.dividerGrey
              : Colors.white,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            isProcessing
                ? const SizedBox(
                    height: 16,
                    width: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      valueColor: AlwaysStoppedAnimation(
                        VardhmanColors.red,
                      ),
                    ),
                  )
                : widget.iconData == null
                    ? const SizedBox(width: 0.0, height: 0.0)
                    : Icon(
                        widget.iconData,
                        color: widget.onPressed != null
                            ? VardhmanColors.darkGrey
                            : Colors.white,
                        size: 18,
                      ),
            if ((widget.iconData != null || isProcessing) &&
                widget.text.isNotEmpty)
              const SizedBox(width: 8),
            if (widget.text.isNotEmpty)
              Text(
                widget.text,
                style: const TextStyle(
                  fontSize: 13,
                  color: VardhmanColors.darkGrey,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
