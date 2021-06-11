import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../helpers/helpers.dart' as helpers;

import '../../shared/shared.dart';

import '../provider/psychologist_provider.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool _isEnd = false;
  bool _isTop = true;
  double _value = 0;

  double h = 60;

  @override
  Widget build(BuildContext context) {
    final localization = helpers.AppLocalizations.of(context);

    return Consumer<PsychologistProvider>(
      builder: (_, provider, __) => Stack(
        fit: StackFit.expand,
        children: [
          NotificationListener<ScrollNotification>(
            onNotification: (scrollNotification) {
              if (scrollNotification is ScrollStartNotification) {
                if (scrollNotification.metrics.pixels < 200) {
                  setState(() {
                    _isTop = true;
                  });
                } else {
                  setState(() {
                    _isTop = false;
                  });
                }
              } else if (scrollNotification is ScrollUpdateNotification) {
                if (scrollNotification.scrollDelta > 0 &&
                    _value > 0 &&
                    !_isEnd) {
                  setState(() {
                    _value -= scrollNotification.scrollDelta;
                  });
                }
              } else if (scrollNotification is ScrollEndNotification) {
                if (_value > h / 2) {
                  setState(() {
                    _isEnd = true;
                  });
                } else {
                  setState(() {
                    _isEnd = false;
                    _value = 0;
                  });
                }
              } else if (scrollNotification is OverscrollNotification) {
                if (scrollNotification.overscroll < 0 &&
                    _value <= h &&
                    _isTop) {
                  setState(() {
                    _value -= scrollNotification.overscroll;
                  });
                }
              }

              return false;
            },
            child: Column(
              children: [
                ExpandedSection(
                  child: Container(
                    height: 60,
                    color: Colors.blue,
                  ),
                  value: (_value / h),
                ),
                if (provider.listPartner.isNotEmpty)
                  Expanded(
                    child: ListView.builder(
                      controller: provider.scrollController,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemBuilder: (_, index) => Container(
                        height: 50,
                        child: Text(index.toString()),
                      ),
                      itemCount: provider.listPartner.length + 20,
                    ),
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ExpandedSection extends StatefulWidget {
  final Widget child;
  final double value;
  ExpandedSection({this.value, this.child});

  @override
  _ExpandedSectionState createState() => _ExpandedSectionState();
}

class _ExpandedSectionState extends State<ExpandedSection>
    with SingleTickerProviderStateMixin {
  AnimationController expandController;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    prepareAnimations();
  }

  ///Setting up the animation
  void prepareAnimations() {
    expandController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    Animation curve = CurvedAnimation(
      parent: expandController,
      curve: Curves.fastOutSlowIn,
    );
    animation = Tween(begin: 0.0, end: 1.0).animate(curve)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void didUpdateWidget(ExpandedSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    expandController.animateTo(widget.value);
  }

  @override
  void dispose() {
    expandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
        axisAlignment: 1.0, sizeFactor: animation, child: widget.child);
  }
}
