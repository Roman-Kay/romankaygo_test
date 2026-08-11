import 'package:flutter/widgets.dart';

class GlassTapTarget extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;
  final HitTestBehavior behavior;

  const GlassTapTarget({
    super.key,
    required this.child,
    required this.onTap,
    this.behavior = HitTestBehavior.translucent,
  });

  @override
  State<GlassTapTarget> createState() => _GlassTapTargetState();
}

class _GlassTapTargetState extends State<GlassTapTarget> {
  bool _isPointerDown = false;

  @override
  Widget build(BuildContext context) {
    return Listener(
      behavior: widget.behavior,
      onPointerDown: (_) {
        _isPointerDown = true;
      },
      onPointerCancel: (_) {
        _isPointerDown = false;
      },
      onPointerUp: (_) {
        if (!_isPointerDown) return;
        _isPointerDown = false;
        widget.onTap();
      },
      child: widget.child,
    );
  }
}
