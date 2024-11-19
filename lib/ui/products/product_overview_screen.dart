import 'package:flutter/material.dart';
import 'package:foodapp/ui/cart/cart_manager.dart';
import 'package:foodapp/ui/cart/cart_screen.dart';
import 'package:foodapp/ui/products/top_right_badge.dart';
import 'package:foodapp/ui/shared/app_drawer.dart';
import 'package:provider/provider.dart';
// import 'package:provider/provider.dart';

// import '../cart/cart_manager.dart';
// import '../cart/cart_screen.dart';
import 'products_grid.dart';
import 'products_manager.dart';
import 'search_product.dart';
// import 'search_product.dart';
// import 'top_right_badge.dart';

enum FilterOptions { favorites, all }

class ProductsOverviewScreen extends StatefulWidget {
  const ProductsOverviewScreen({super.key});

  @override
  State<ProductsOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductsOverviewScreen> {
  late Future<void> _fetchProducts;

  @override
  void initState() {
    super.initState();
    _fetchProducts = context.read<ProductsManager>().fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('FOOD APP'),
          actions: [
            buildShoppingCartIcon(),
            searchProduct(),
          ],
        ),
        drawer: const AppDrawer(),
        body:
        FutureBuilder(
          future: _fetchProducts,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ProductsGrid();
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
        );
  }

  Widget buildShoppingCartIcon() {
    return Consumer<CartManager>(
      builder: (context, cartManager, child){
        return TopRightBadge(
        child: IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(CartScreen.routeName);
            },
            icon: const Icon(Icons.shopping_cart)),
        data: cartManager.productCount);
      }
    ); 
  }
  Widget searchProduct() {
    return IconButton(
        onPressed: () {
          Navigator.of(context).pushNamed(SearchScreen.routeName);
          print("hello");
        },
        icon: const Icon(Icons.search));
  }
}
