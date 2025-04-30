import 'package:flutter/material.dart';

class UploadButtonWidget extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const UploadButtonWidget({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  State<UploadButtonWidget> createState() => _UploadButtonWidgetState();
}

class _UploadButtonWidgetState extends State<UploadButtonWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTapDown: (_) => controller.forward(),
        onTapUp: (_) {
          controller.reverse();
          widget.onPressed();
        },
        onTapCancel: () => controller.reverse(),
        child: AnimatedBuilder(
          animation: scaleAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: scaleAnimation.value,
              child: child,
            );
          },
          child: Container(
            height: 120,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.primary.withBlue(
                    (Theme.of(context).colorScheme.primary.blue + 40).clamp(0, 255),
                  ),
                ],
              ),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  widget.icon,
                  size: 36,
                  color: Colors.white,
                ),
                const SizedBox(height: 10),
                Text(
                  widget.label,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}