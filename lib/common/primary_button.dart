import 'package:flutter/material.dart';
import 'package:vardhman_b2b/constants.dart';

class PrimaryButton extends StatefulWidget {
  final Future<void> Function()? onPressed;
  final String text;
  final IconData? iconData;
  final bool wait;

  const PrimaryButton({
    super.key,
    this.iconData,
    required this.text,
    required this.onPressed,
    this.wait = true,
  });

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  bool isProcessing = false;

  @override
  Widget build(BuildContext context) {
    final Color color = widget.onPressed == null
        ? Colors.grey
        : isProcessing
            ? VardhmanColors.darkGrey
            : VardhmanColors.red;

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
          border: Border.all(
            color: color,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(24),
          color: color,
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
                        color: Colors.white,
                        size: 16,
                      ),
            if ((widget.iconData != null || isProcessing) &&
                widget.text.isNotEmpty)
              const SizedBox(width: 8),
            if (widget.text.isNotEmpty)
              Text(
                widget.text,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.white,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
