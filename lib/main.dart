import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:store_app/Screens/auth_screen.dart';

import 'package:store_app/Screens/cart_screen.dart';
import 'package:store_app/Screens/all_products.dart';
import 'package:store_app/Screens/home.dart';
import 'package:store_app/Screens/order_history.dart';
import 'package:store_app/Screens/product_details.dart';
import 'package:store_app/Screens/update_product.dart';
import 'package:store_app/cubits/auth/auth_cubit.dart';
import 'package:store_app/cubits/cart/cart_cubit.dart';
import 'package:store_app/cubits/order_history/order_history_cubit.dart';
import 'package:store_app/models/product_model.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('LoginData');
  await Hive.openBox<List<ProductModel>>('CartData');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => OrderHistoryCubit(),
        ),
        BlocProvider(
          create: (context) => CartCubit(),
        ),
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Store App',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
            useMaterial3: true,
          ),
          routes: {
            AuthScreen.id: (context) => const AuthScreen(),
            HomeScreen.id: (context) => const HomeScreen(),
            ProductsPage.id: (context) => const ProductsPage(),
            UpdateProduct.id: (context) => const UpdateProduct(),
            ProductDetails.id: (context) => const ProductDetails(),
            CartPage.id: (context) => const CartPage(),
            OrderScreen.id: (context) => const OrderScreen(),
          },
          initialRoute: AuthScreen.id),
    );
  }
}
