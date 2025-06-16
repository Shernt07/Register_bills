import 'package:flutter/material.dart';

class CardSuggestionCustom extends StatelessWidget {
  final String? clientName;
  final String? deliveryStatus;
  final String? fechaPedido;
  final String? folio;
  final VoidCallback onDetailsPressed;
  final bool isRead;

  const CardSuggestionCustom({
    super.key,
    this.clientName,
    this.deliveryStatus,
    this.fechaPedido,
    this.folio,
    required this.onDetailsPressed,
    required this.isRead,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        leading: const Icon(Icons.insert_comment_outlined, color: Colors.black),
        title: Text(
          clientName ?? '',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 5),
              Row(
                children: [
                  Text(
                    'Fecha: ',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text("$fechaPedido"),
                ],
              ),

              SizedBox(height: 5),
            ],
          ),
        ),
        trailing: IconButton(
          onPressed: onDetailsPressed,
          // icon: Icon(Icons.check_circle, color: Color(0xFF08A5C0), size: 28),
          icon: Icon(
            isRead ? Icons.check_circle : Icons.mark_email_unread,
            color: isRead ? Colors.green : Colors.orange,
          ),
        ),
      ),
    );
  }
}
