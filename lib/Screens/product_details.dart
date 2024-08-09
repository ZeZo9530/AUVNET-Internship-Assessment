import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/Screens/update_product.dart';
import 'package:store_app/cubits/cart/cart_cubit.dart';
import 'package:store_app/models/product_model.dart';
import 'package:store_app/widgets/custom_button.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key});
  static const String id = 'product_details';
  @override
  Widget build(BuildContext context) {
    ProductModel product =
        ModalRoute.of(context)!.settings.arguments as ProductModel;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Icon(Icons.edit, color: Colors.white),
        onPressed: () {
          Navigator.pushNamed(context, UpdateProduct.id, arguments: product);
        },
      ),
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.white,
              child: Image.network(
                product.image,
                height: 200,
                width: double.infinity,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12.0, left: 12, right: 12),
              child: Text(
                r'$' '${product.price.toString()}',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                product.description,
                style: TextStyle(fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
              child: CustomButton(
                  text: 'Add to cart',
                  onTap: () {
                    BlocProvider.of<CartCubit>(context).addProduct(product);
                    ScaffoldMessenger.of(context).clearSnackBars();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Added to cart'),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
