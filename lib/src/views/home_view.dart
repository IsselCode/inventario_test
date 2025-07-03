import 'package:flutter/material.dart';
import 'package:inventario_test/src/views/appbars/history_appbar.dart';
import 'package:inventario_test/src/views/appbars/inventory_appbar.dart';
import 'package:inventario_test/src/views/appbars/profile_appbar.dart';
import 'package:inventario_test/src/views/pages/history_page.dart';
import 'package:inventario_test/src/views/pages/inventory_page.dart';
import 'package:inventario_test/src/views/pages/profile_page.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class HomeView extends StatefulWidget {

  const HomeView({
    super.key
  });

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  final PageController pageController = PageController(initialPage: 0);

  changePage(int index) async {
    await pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 350),
      curve: Curves.linear
    );
    setState(() {});
  }

  List<PreferredSizeWidget> appbars = [
    InventoryAppbar(),
    HistoryAppbar(),
    ProfileAppbar()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbars[pageController.page!.toInt()],
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: pageController.page!.toInt(),
        onTap: changePage,
        items: [
          BottomNavigationBarItem(icon: Icon(Symbols.box), label: "",),
          BottomNavigationBarItem(icon: Icon(Symbols.receipt_long), label: "",),
          BottomNavigationBarItem(icon: Icon(Symbols.person), label: ""),
        ]
      ),
      body: PageView(
        controller: pageController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          InventoryPage(),
          HistoryPage(),
          ProfilePage(),
        ],
      ),
    );
  }
}
