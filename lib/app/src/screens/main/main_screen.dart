import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../constraint.dart';

import '../../../helpers/helpers.dart' as helpers;

import 'home/provider/home_provider.dart';

import 'chat/chat_screen.dart';
import 'home/home_screen.dart';
import 'profile/profile_screen.dart';
import 'schedule/schedule_screen.dart';
import 'transaction/transaction_screen.dart';

class MainScreen extends StatefulWidget {
  static const routeName = '/main-screen';

  final helpers.ScreenArguments arguments;

  const MainScreen(this.arguments);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  final _tab = TabBar(
    indicator: UnderlineTabIndicator(
      borderSide: BorderSide(color: PsykayGreenColor, width: 3.0),
      insets: const EdgeInsets.only(bottom: 45),
    ),
    indicatorColor: PsykayGreenColor,
    labelColor: PsykayGreenColor,
    labelStyle: TextStyle(
      fontFamily: 'Roboto',
      fontSize: 14,
      fontWeight: FontWeight.w700,
    ),
    unselectedLabelColor: PsykayGreyColor,
    unselectedLabelStyle: TextStyle(
        fontFamily: 'Roboto', fontSize: 12, fontWeight: FontWeight.w700),
    tabs: [
      Tab(
        icon: ImageIcon(AssetImage('assets/icons/bottom_tab_home.png')),
      ),
      Tab(
        icon: ImageIcon(AssetImage('assets/icons/bottom_tab_calender.png')),
      ),
      Tab(
        icon: ImageIcon(AssetImage('assets/icons/bottom_tab_history.png')),
      ),
      Tab(
        icon: ImageIcon(AssetImage('assets/icons/bottom_tab_chat.png')),
      ),
      Tab(
        icon: ImageIcon(AssetImage('assets/icons/bottom_tab_profile.png')),
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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      initialize();
    });
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
      length: 5,
      child: Scaffold(
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            HomeScreen(
              animation: _animation,
            ),
            ScheduleScreen(),
            TransactionScreen(
              tab: widget.arguments.transactionScreenTab,
            ),
            ChatScreen(),
            ProfileScreen()
          ],
        ),
        bottomNavigationBar: Container(
          color: Colors.white,
          child: _tab,
        ),
      ),
    );
  }

  // Functions

  Future initialize() async {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);

    final futures = <Future>[homeProvider.initialLoad()];

    await Future.wait(futures);
  }
}
