import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var top = 0.0;

  bool _onStretch = false;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        SliverAppBar(
            stretch: true,
            onStretchTrigger: onStretch,
            backgroundColor: Colors.green,
            pinned: true,
            expandedHeight: 150.0,
            stretchTriggerOffset: 160,
            flexibleSpace: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              top = constraints.biggest.height;
              return FlexibleSpaceBar(
                title: Text(top.toString()),
                stretchModes: [StretchMode.fadeTitle],
                background: Image.asset(
                  'assets/images/logo.png',
                  // height: 40,
                  alignment: Alignment.center,
                ),
              );
            })),
        SliverList(
            delegate: SliverChildListDelegate(
                List.generate(10, (index) => CustomWidget(index)).toList())),
      ],
    );
  }

  Future onStretch() async {
    print('onStretch');

    return;
  }
}

class CustomWidget extends StatelessWidget {
  CustomWidget(this._index) {
    debugPrint('initialize: $_index');
  }

  final int _index;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      color: (_index % 2 != 0) ? Colors.white : Colors.grey,
      child:
          Center(child: Text('index: $_index', style: TextStyle(fontSize: 40))),
    );
  }
}
