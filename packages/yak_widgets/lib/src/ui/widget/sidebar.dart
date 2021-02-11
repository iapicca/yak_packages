import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../yak_widgets.dart';

/// a ready to use widget that changes `sidebarPod` state

class YakSidebar extends HookWidget {
  /// `YakSidebar` does not require any
  const YakSidebar({
    this.child,
    this.scrollSensitivity = .01,
    this.width = 54,
    Key key = const ValueKey('YakSidebar'),
  }) : super(key: key);

  /// allow to change `scrollSensitivity` to a custom value; default `1%`
  final double scrollSensitivity;

  /// allow to change `width` to a custom value; default `54`
  final double width;

  /// you may provide a `child` althogh is not required
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final scroll = useProvider(sidebarPod);
    final height = MediaQuery.of(context).size.height;
    final threshold = height * scrollSensitivity;
    return YakHandedness(
      child: SizedBox(
        key: ValueKey('$key: SizedBox'),
        height: height,
        width: width,
        child: GestureDetector(
          key: ValueKey('$key: GestureDetector'),
          onVerticalDragUpdate: (details) {
            if (details.delta.dy.abs() > threshold &&
                details.delta.dx < threshold) {
              details.delta.dy < 0
                  ? scroll.state = SidebarScroll.up
                  : scroll.state = SidebarScroll.down;
            }
          },
          child: child,
        ),
      ),
    );
  }
}