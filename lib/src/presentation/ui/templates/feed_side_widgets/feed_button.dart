import 'package:flutter/material.dart';

import '../../../../infrastructure/constants/colors.dart';
import '../../../../infrastructure/resources/helper_services/count_formatter.dart';
import '../../../../infrastructure/screen_size_config/screen_size_config.dart';

class FeedButton extends StatefulWidget {
  const FeedButton({
    super.key,
    required this.alreadyStatus,
    required this.isFormattedCount,
    required this.icon,
    required this.text,
    this.onTap,
  });
  final bool alreadyStatus, isFormattedCount;
  final IconData icon;

  final String text;
  final VoidCallback? onTap;

  @override
  State<FeedButton> createState() => FeedButtonState();
}

class FeedButtonState extends State<FeedButton>
    with SingleTickerProviderStateMixin {
  bool isTriggered = false;
  late AnimationController _controller;
  late Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    setState(() {
      isTriggered = widget.alreadyStatus;
    });
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 1.0, end: 2).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  void _onTapAnimation() {
    if (_controller.status == AnimationStatus.completed) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
  }

  String _getFormattedText(
    String text,
  ) {
    String returnText = text;
    if (widget.isFormattedCount) {
      int parsedCount = int.parse(widget.text);
      if (parsedCount < 0) {
        returnText = CountFormatter().formatCount(
          0,
        );
      } else if (parsedCount == 0) {
        if (isTriggered) {
          returnText = CountFormatter().formatCount(
            int.parse(widget.text) + 1,
          );
        } else {
          returnText = CountFormatter().formatCount(
            int.parse(widget.text),
          );
        }
      } else {
        if (isTriggered) {
          returnText = CountFormatter().formatCount(
            int.parse(widget.text),
          );
        } else {
          returnText = CountFormatter().formatCount(
            int.parse(widget.text) - 1,
          );
        }
      }
    }
    return returnText;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.onTap != null) {
          widget.onTap!();
        }
        setState(() {
          isTriggered = !isTriggered;
        });
        _onTapAnimation();
      },
      child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  widget.icon,
                  color:
                      isTriggered ? ThemeColors().themeDarkColor : Colors.white,
                  size: 30,
                ),
                Text(
                  _getFormattedText(
                    widget.text,
                  ),
                  style: ScreenConfig.theme.textTheme.labelSmall?.copyWith(
                    color: Colors.white,
                  ),
                ),
              ],
            );
          }),
    );
  }
}
