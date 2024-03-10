import 'package:flutter/material.dart';
import 'package:shopper/presentation/constants/tab_type.dart';
import 'package:shopper/presentation/main/widgets/tab_bar_item.dart';
import 'package:shopper/presentation/profile/views/profile_view.dart';
import 'package:shopper/presentation/shop/views/shop_view.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> with SingleTickerProviderStateMixin {

  static const List<Tab> tabs = <Tab>[
    Tab(child: TabBarItem(type: TabType.shop)),
    Tab(child: TabBarItem(type: TabType.profile))
  ];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    _tabController.addListener(onChangeTabIndex);
  }
  
  @override
  void dispose() {
    _tabController.removeListener(onChangeTabIndex);
    _tabController.dispose();
    super.dispose();
  }

  void onChangeTabIndex() {
    if (_tabController.indexIsChanging) {
      print('previous index: ${_tabController.previousIndex}');
      print('current index: ${_tabController.index}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black38,
        body: TabBarView(
          controller: _tabController,
          children: const [
            ShopView(),
            ProfileView(),
          ]
        ),
        bottomNavigationBar: Row(
          children: [
            Expanded(
              child: TabBar(
                controller: _tabController,
                tabs: tabs,
                indicatorColor: Colors.transparent,
              ),
            ),
          ],
        )
      ),
    );
  }
}
