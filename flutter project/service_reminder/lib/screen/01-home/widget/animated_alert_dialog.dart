import 'package:flutter/material.dart';

class AnimatedAlertDialog extends StatefulWidget {
  final String title;
  final Widget content;
  final List<Widget> actions;
  const AnimatedAlertDialog({
    super.key,
    required this.title,
    required this.actions,
    required this.content,
  });
  @override
  // ignore: library_private_types_in_public_api
  _AnimatedAlertDialogState createState() => _AnimatedAlertDialogState();
}

class _AnimatedAlertDialogState extends State<AnimatedAlertDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<double> _transformAnimation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.fastOutSlowIn,
      ),
    );
    _transformAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutBack,
      ),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? child) {
        return Opacity(
          opacity: _opacityAnimation.value,
          child: Transform.scale(
            scale: _transformAnimation.value,
            child: AlertDialog(
              contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
              title: Text(widget.title),
              content: widget.content,
              actions: widget.actions,
              actionsAlignment: MainAxisAlignment.center,
            ),
          ),
        );
      },
    );
  }
}
