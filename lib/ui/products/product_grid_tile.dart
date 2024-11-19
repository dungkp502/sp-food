import 'package:flutter/material.dart';
import 'package:foodapp/ui/cart/cart_manager.dart';
import 'package:provider/provider.dart';
import '../../model/product.dart';
import 'product_detail_screen.dart';

class ProductGridTile extends StatelessWidget {
  const ProductGridTile(
    this.product, {
    super.key,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: buildGridFooterBar(context),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => ProductDetailScreen(product),
              ),
            );
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget buildGridFooterBar(BuildContext context) {
    return GridTileBar(
      backgroundColor: Color.fromARGB(255, 146, 115, 141),
      leading: SizedBox( width: 100,child: Text(
        product.title,
        textAlign: TextAlign.start,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(color: Colors.black),
      ),),
      trailing: IconButton(
        icon: const Icon(
          Icons.shopping_cart,
        ),
        onPressed: () {
          print("Da them vao gio hang");
          final cart = context.read<CartManager>();
          cart.addItem(product);
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
              content: const Text(
                'Đã thêm vào giỏ hàng',
              ),
              duration: const Duration(seconds: 2),
              action: SnackBarAction(
                label: 'Xóa',
                onPressed: () {
                  cart.removeSingleItem(product.id!);
                },
              ),
            ));
        },
        color: Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}
