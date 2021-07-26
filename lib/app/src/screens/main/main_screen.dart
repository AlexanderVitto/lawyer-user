import 'package:flutter/material.dart';

import '../../../helpers/helpers.dart';

class MainScreen extends StatefulWidget {
  static const routeName = '/main-screen';

  final ScreenArguments arguments;

  const MainScreen(this.arguments);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  final _tab = TabBar(
    indicator: UnderlineTabIndicator(
      borderSide: BorderSide(color: LawyerMainColor, width: 3.0),
      insets: const EdgeInsets.only(bottom: 45),
    ),
    indicatorColor: LawyerMainColor,
    labelColor: LawyerMainColor,
    labelStyle: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w700,
    ),
    unselectedLabelColor: Colors.grey,
    unselectedLabelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
    tabs: [
      Tab(
        icon: Icon(Icons.home_filled),
      ),
      Tab(
        icon: Icon(Icons.account_circle),
      ),
    ],
  );

  AnimationController _animationController;
  Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 5000),
      vsync: this,
    )..forward();
    _animation = Tween<Offset>(
      begin: const Offset(-5, 0.0),
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInCubic,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: widget.arguments.mainScreenTab.index,
      length: 2,
      child: Scaffold(
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [],
        ),
        bottomNavigationBar: Container(
          color: Colors.white,
          child: _tab,
        ),
      ),
    );
  }
}
