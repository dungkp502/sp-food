import 'package:flutter/material.dart';
import 'package:foodapp/ui/auth/auth_manager.dart';
import 'package:foodapp/ui/auth/auth_screen.dart';
import 'package:provider/provider.dart';
import '../filter_order_admin/filter_order_admin.dart';
import '../admin/user_product_screen.dart';
import '../orders1_admin/order_screen.dart';
import '../orders2_admin/order_screen.dart';
import '../orders3_admin/order_screen.dart';
import '../orders_admin/order_screen.dart';
import '../personal/personal_screen.dart';
import '../pie_chart/pie_chart.dart';

class AdminAppDrawer extends StatelessWidget {
  const AdminAppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: const Text('ADMIN'),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: const Text('Trang cá nhân'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(PersonalScreen.routeName);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Trang chủ'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(UserProductsScreen.routeName);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.check),
            title: const Text('Xác nhận đơn hàng'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(OrdersScreenAdmin.routeName);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.plus_one),
            title: const Text('Đơn đã đặt'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(OrdersScreenAdmin1.routeName);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.local_shipping_outlined),
            title: const Text('Đơn đang giao'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(OrdersScreenAdmin2.routeName);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.cancel_presentation),
            title: const Text('Đơn đã hủy'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(OrdersScreenAdmin3.routeName);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.pie_chart),
            title: const Text('Thống kê đơn hàng'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(PieChartScreen.routeName);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.headphones),
            title: const Text('Thống kê doanh thu'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(FilterOrderAdmin.routeName);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Đăng xuất'),
            onTap: () {
              context.read<AuthManager>().logout();
              // Navigator.of(context)
              //   ..pop()
              //   ..pushReplacementNamed(AuthScreen.routeName);
            },
          )
        ],
      ),
    );
  }
}
