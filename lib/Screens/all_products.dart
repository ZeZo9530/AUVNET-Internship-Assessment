import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:store_app/Screens/cart_screen.dart';
import 'package:store_app/cubits/cart/cart_cubit.dart';
import 'package:store_app/models/product_model.dart';
import 'package:store_app/services/API/get_products.dart';
import 'package:store_app/widgets/custom_card.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  static const String id = 'ProductsPage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text('AuvNet Store'),
        actions: [
          IconButton(
            onPressed: () {
              BlocProvider.of<CartCubit>(context).getCart();
              Navigator.pushNamed(context, CartPage.id);
            },
            icon: const Icon(FontAwesomeIcons.cartShopping),
          )
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 80),
          child: FutureBuilder<List<ProductModel>>(
              future: AllProducts().getAllProducts(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<ProductModel> products = snapshot.data!;
                  return GridView.builder(
                    itemCount: products.length,
                    clipBehavior: Clip.none,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 70,
                            childAspectRatio: 1.4),
                    itemBuilder: (context, index) => CustomCard(
                      product: products[index],
                    ),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              })),
    );
  }
}
