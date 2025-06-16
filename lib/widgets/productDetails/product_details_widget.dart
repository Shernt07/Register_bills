import 'package:flutter/material.dart';

class ProductDetailsCustom extends StatelessWidget {
  final String? image;
  final String? title;
  final String? amount;
  final String? price1;
  final String? price2;

  const ProductDetailsCustom({
    super.key,
    this.image,
    this.title,
    this.amount,
    this.price1,
    this.price2,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            child: Image.network(
              //'assets/img/botellas_categorias.png'
              width: 70,
              height: 70,
              '$image',
            ),
          ),
          const SizedBox(width: 20),
          Column(
            children: [
              Text(
                //Paquete de botellas
                '$title',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              Row(
                children: [
                  Text("Cantidad: $amount"),
                  const SizedBox(width: 20),
                  Text('\$$price1'),
                ],
              ),
              Row(
                children: [
                  Text('Sub total:'),
                  const SizedBox(width: 20),
                  Text('\$$price2'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
