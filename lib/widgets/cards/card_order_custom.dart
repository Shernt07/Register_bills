import 'package:flutter/material.dart';
import 'package:h2o_admin_app/config/utils/date_formatter.dart';

class CardOrderCustom extends StatelessWidget {
  final String clientName;
  final String deliveryStatus;
  final String? fechaPedido;
  final String? folio;
  final VoidCallback onDetailsPressed;

  const CardOrderCustom({
    super.key,
    required this.clientName,
    required this.deliveryStatus,
    this.fechaPedido,
    this.folio,
    required this.onDetailsPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        leading: const Icon(Icons.local_shipping, color: Colors.black),
        title: Text(
          clientName,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Text(
                  //   'No. Orden: ',
                  //   style: const TextStyle(fontWeight: FontWeight.bold),
                  // ),
                  Text(
                    "#$folio",
                    // style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),

              Text(
                'Estado: $deliveryStatus',
                maxLines: 2,
                // style: const TextStyle(fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 5),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Fecha:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    DateFormatter.formatEleganteCards(fechaPedido ?? ''),
                    softWrap: true,
                  ),
                ],
              ),

              SizedBox(height: 5),
            ],
          ),
        ),

        trailing: ElevatedButton(
          onPressed: onDetailsPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF08A5C0),
          ),
          child: const Text(
            'Ver detalles',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
