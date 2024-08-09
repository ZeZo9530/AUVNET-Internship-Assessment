import 'package:flutter/material.dart';
import 'package:store_app/models/product_model.dart';

class CustomOrderHistory extends StatelessWidget {
  const CustomOrderHistory({required this.products, super.key});
  final List<ProductModel> products;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 6, left: 8, right: 8, bottom: 12),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
                width: 3,
                color:
                    Theme.of(context).colorScheme.secondary.withOpacity(0.8))),
        width: 500,
        height: 120 * products.length.toDouble(),
        child: ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.network(
                        products[index].image,
                        height: 100,
                        width: 100,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 200,
                            child: Text(
                              products[index].title,
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            r'$' '${products[index].price}',
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
      ),
    );
  }
}
