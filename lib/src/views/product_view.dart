import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:inventario_test/src/clean_features/entities/product_entity.dart';
import 'package:inventario_test/src/clean_features/widgets/pill_toggle_widget.dart';
import 'package:inventario_test/src/views/pages/movement_page.dart';
import 'package:inventario_test/src/views/pages/edit_product_page.dart';

import '../../core/services/toast_service.dart';
import '../../inject_container.dart';

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
  late final Future<Uint8List?> _imageOnce;

  @override
  void initState() {
    super.initState();
    _imageOnce = _readImageOnce(widget.productEntity.image);
  }

  Future<Uint8List?> _readImageOnce(String path) async {
    try {
      File file = File(path);
      return await file.readAsBytes();
    } catch (e) {
      ToastService toastService = locator();
      toastService.error("No se ha podido cargar la imagen");
      return null;
    }
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
          FutureBuilder(
            future: _imageOnce,
            builder: (context, snapshot) {

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator(),);
              }

              final bytes = snapshot.data;
              return Expanded(
                child: PageView(
                  physics: NeverScrollableScrollPhysics(),
                  onPageChanged: (value) {
                    currentIndex = value;
                    setState(() {});
                  },
                  controller: pageController,
                  children: [
                    EditProductPage(
                      image: bytes,
                      productEntity: widget.productEntity,
                    ),
                    MovementPage(
                      image: bytes,
                      productEntity: widget.productEntity,
                    )
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
