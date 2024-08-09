import 'package:flutter/material.dart';
import 'package:store_app/Screens/product_details.dart';
import 'package:store_app/models/product_model.dart';

//this is the ui for the products in the home screen
class CustomCard extends StatelessWidget {
  const CustomCard({required this.product, super.key});

  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //enable user to see details of the product
      onTap: () {
        Navigator.pushNamed(context, ProductDetails.id, arguments: product);
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title,
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                      overflow: TextOverflow.fade,
                      softWrap: false,
                      maxLines: 1,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          r'$' '${product.price}',
                          style: TextStyle(fontSize: 15),
                        ),
                        const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          //displaying the flying product image
          Positioned(
            bottom: 65,
            left: 40,
            child: Image.network(
              product.image,
              height: 100,
              width: 100,
            ),
          )
        ],
      ),
    );
  }
}
