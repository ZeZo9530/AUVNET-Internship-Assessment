import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/cubits/cart/cart_cubit.dart';
import 'package:store_app/widgets/cart_widget/cart.dart';
import 'package:store_app/widgets/custom_button.dart';

//cart screen
class CartPage extends StatefulWidget {
  const CartPage({super.key});
  static const id = 'CartPage';

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Cart'),
      ),
      body: CartProducts(),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 25.0),
        child: CustomButton(
            text: "Checkout",
            onTap: () {
              BlocProvider.of<CartCubit>(context).checkOut();
            }),
      ),
    );
  }
}
