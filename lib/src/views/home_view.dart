import 'package:flutter/material.dart';
import 'package:inventario_test/src/views/pages/history_page.dart';
import 'package:inventario_test/src/views/pages/inventory_page.dart';
import 'package:inventario_test/src/views/pages/profile_page.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(icon: Icon(Symbols.box), label: "",),
          BottomNavigationBarItem(icon: Icon(Symbols.receipt_long), label: "",),
          BottomNavigationBarItem(icon: Icon(Symbols.person), label: ""),
        ]
      ),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        children: [
          ProfilePage(),
          InventoryPage(),
          HistoryPage(),
        ],
      ),
    );
  }
}
