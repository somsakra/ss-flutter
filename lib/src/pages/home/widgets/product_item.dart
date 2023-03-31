import 'package:flutter/material.dart';
import 'package:my_first_app/src/utils/format.dart';
import 'package:my_first_app/src/widgets/image_not_found.dart';

class ProductItem extends StatelessWidget {
  final double maxHeight;

  const ProductItem(this.maxHeight, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("press");
      },
      child: Container(
        color: Colors.white,
        child: Column(
          children: [_buildImage(), _buildInfo()],
        ),
      ),
    );
  }

  Stack _buildImage() {
    final height = maxHeight * 0.7;
    const productImage =
        'https://png.pngtree.com/png-clipart/20190924/original/pngtree-human-avatar-free-vector-png-image_4825373.jpg';
    const stock = 1;
    return Stack(children: [
      SizedBox(
        width: double.infinity,
        height: height,
        child: productImage.isNotEmpty
            ? Image.network(productImage)
            : const ImageNotFound(),
      ),
      if (stock <= 0) _buildOutOfStock()
    ]);
  }

  Expanded _buildInfo() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Neque porro quisquam',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '฿${formatCurrency.format(1111)}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue),
                ),
                Text(
                  '${formatNumber.format(1234)} pieces',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.deepOrange),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Positioned _buildOutOfStock() => const Positioned(
        top: 2,
        right: 2,
        child: Card(
          color: Colors.amber,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Text(
              'out of stock',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ),
        ),
      );
}
