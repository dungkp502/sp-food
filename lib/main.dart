import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:foodapp/ui/admin/edit_product_screen.dart';
import 'package:foodapp/ui/admin/user_product_screen.dart';
import 'package:foodapp/ui/auth/auth_manager.dart';
import 'package:foodapp/ui/auth/auth_screen.dart';
import 'package:foodapp/ui/cart/cart_manager.dart';
import 'package:foodapp/ui/cart/cart_screen.dart';
import 'package:foodapp/ui/chatbot_rasa_ai/chatbot_rasa_ai.dart';
import 'package:foodapp/ui/order/order_manager.dart';
import 'package:foodapp/ui/order/orders_screen.dart';
import 'package:foodapp/ui/payment_cart/payment_cart_screen.dart';
import 'package:foodapp/ui/products/product_detail_screen.dart';
import 'package:foodapp/ui/products/product_overview_screen.dart';
import 'package:foodapp/ui/products/products_manager.dart';
import 'package:foodapp/ui/splash_screen.dart';
import 'package:provider/provider.dart';
import 'ui/admin/search_admin.dart';
import 'ui/filter_order_admin/filter_admin_manager.dart';
import 'ui/filter_order_admin/filter_order_admin.dart';
import 'ui/orders1_admin/order_manager.dart';
import 'ui/orders1_admin/order_screen.dart';
import 'ui/orders2_admin/order_manager.dart';
import 'ui/orders2_admin/order_screen.dart';
import 'ui/orders3_admin/order_manager.dart';
import 'ui/orders3_admin/order_screen.dart';
import 'ui/orders_admin/order_manager.dart';
import 'ui/orders_admin/order_screen.dart';
import 'ui/personal/personal_screen.dart';
import 'ui/pie_chart/pie_chart.dart';
import 'ui/pie_chart/pie_chart_manager.dart';
import 'ui/products/search_product.dart';

Future<void> main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (ctx) => AuthManager(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => CartManager(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => OrdersManager(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => OrdersManagerAdmin(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => OrdersManagerAdmin1(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => OrdersManagerAdmin2(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => OrdersManagerAdmin3(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => ProductsManager(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => PieChartManager(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => FilterOrderAdminManager(),
          ),
        ],
        child: Consumer<AuthManager>(builder: (context, authManager, child) {
          return MaterialApp(
            title: 'MyShop',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: 'Lato',
              colorScheme: ColorScheme.fromSwatch(
                primarySwatch: Colors.blue,
              ).copyWith(
                secondary: Colors.deepOrange,
              ),
            ),
            home: authManager.isAuth
                ? (context.read<AuthManager>().authToken?.role == "admin"
                    ? const UserProductsScreen()
                    : const ProductsOverviewScreen())
                : FutureBuilder(
                    future: authManager.tryAutoLogin(),
                    builder: (context, snapshot) {
                      return snapshot.connectionState == ConnectionState.waiting && authManager.authToken != null
                          ? const SplashScreen()
                          : const AuthScreen();
                    },
                  ),
            routes: {
              FilterOrderAdmin.routeName: (context) => const FilterOrderAdmin(),
              PieChartScreen.routeName: (context) => PieChartScreen(),
              SearchAdminScreen.routeName: (context) =>
                  const SearchAdminScreen(),
              SearchScreen.routeName: (context) => const SearchScreen(),
              CartScreen.routeName: (context) => const CartScreen(),
              PersonalScreen.routeName: (context) => const PersonalScreen(),
              PaymentCartScreen1.routeName: (context) =>
                  const PaymentCartScreen1(),
              OrdersScreen.routeName: (context) => const OrdersScreen(),
              OrdersScreenAdmin.routeName: (context) =>
                  const OrdersScreenAdmin(),
              OrdersScreenAdmin1.routeName: (context) =>
                  const OrdersScreenAdmin1(),
              OrdersScreenAdmin2.routeName: (context) =>
                  const OrdersScreenAdmin2(),
              OrdersScreenAdmin3.routeName: (context) =>
                  const OrdersScreenAdmin3(),
              UserProductsScreen.routeName: (context) =>
                  const UserProductsScreen(),
              ChatbotScreen1.routeName: (context) => const ChatbotScreen1(),
              AuthScreen.routeName: (context) => const AuthScreen(),
            },
            onGenerateRoute: (settings) {
              if (settings.name == ProductDetailScreen.routeName) {
                final productID = settings.arguments as String;
                return MaterialPageRoute(builder: (ctx) {
                  return ProductDetailScreen(
                    ctx.read<ProductsManager>().findById(productID)!,
                    // ProductsManager().findById(productID),
                  );
                });
              }
              if (settings.name == EditProductScreen.routeName) {
                final productId = settings.arguments as String?;
                return MaterialPageRoute(
                  builder: (ctx) {
                    return EditProductScreen(
                      productId != null
                          ? ctx.read<ProductsManager>().findById(productId)
                          : null,
                    );
                  },
                );
              }
              return null;
            },
          );
        }));
  }
}
