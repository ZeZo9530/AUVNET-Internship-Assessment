import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/Screens/product_details.dart';
import 'package:store_app/cubits/cart/cart_cubit.dart';
import 'package:store_app/models/product_model.dart';

class CustomCart extends StatelessWidget {
  const CustomCart({required this.product, super.key});

  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ProductDetails.id, arguments: product);
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 12.0, left: 8, right: 8),
        child: Stack(children: [
          Container(
            width: 500,
            height: 100,
            child: Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              color: Colors.white,
              elevation: 10,
              shadowColor: Theme.of(context).colorScheme.primary,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.network(
                      product.image,
                      height: 100,
                      width: 100,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 200,
                          child: Text(
                            product.title,
                            style: TextStyle(
                              fontSize: 15,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          r'$' '${product.price}',
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 50,
            right: 10,
            child: IconButton(
                onPressed: () {
                  BlocProvider.of<CartCubit>(context).removeProduct(product);
                },
                icon: Icon(Icons.delete)),
          )
        ]),
      ),
    );
  }
}
