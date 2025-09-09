import 'package:flutter/material.dart';
import 'package:inventario_test/src/clean_features/entities/product_entity.dart';
import 'package:inventario_test/src/clean_features/widgets/filled_button_widget.dart';
import 'package:inventario_test/src/clean_features/widgets/forms/add_product_form.dart';
import 'package:inventario_test/src/clean_features/widgets/pill_toggle_widget.dart';
import 'package:inventario_test/src/views/movement_view.dart';
import 'package:inventario_test/src/views/pages/edit_product_page.dart';

class ProductView extends StatefulWidget {

  final ProductEntity productEntity;

  ProductView({
    super.key,
    required this.productEntity
  });

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  int currentIndex = 0;
  final PageController pageController = PageController();
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      EditProductPage(
        productEntity: widget.productEntity,
      ),
      MovementView()
    ];
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(),
      body: Column(
        children: [
          //* Toggle Button
          PillToggle(
            onChanged: (value) {
              pageController.animateToPage(
                value,
                duration: const Duration(milliseconds: 350),
                curve: Curves.linear
              );
            },
            labels: ["Actualizar", "Altas y Bajas"],
            selectedIndex: currentIndex,
          ),

          const SizedBox(height: 20,),

          //* Pages
          Expanded(
            child: PageView(
              onPageChanged: (value) {
                currentIndex = value;
                setState(() {});
              },
              controller: pageController,
              children: _pages,
            ),
          ),
        ],
      ),
    );
  }
}
