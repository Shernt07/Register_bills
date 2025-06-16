import 'package:flutter/material.dart';

class CardSuggestionCopyCustom extends StatelessWidget {
  final String? clientName;
  final String? deliveryStatus;
  final String? fechaPedido;
  final String? folio;
  final VoidCallback onDetailsPressed;
  final bool isRead;

  const CardSuggestionCopyCustom({
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(width: 20),
                  const Icon(
                    Icons.insert_comment_outlined,
                    color: Colors.black,
                  ),
                  SizedBox(width: 5),
                  Text(
                    'Fecha: ',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text("$fechaPedido"),
                ],
              ),
              SizedBox(width: 150),
              IconButton(
                onPressed: onDetailsPressed,
                icon: Icon(
                  isRead ? Icons.check_circle : Icons.mark_email_unread,
                  color: isRead ? Colors.green : Colors.orange,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: Divider(color: Color(0xFF08A5C0)),
          ),
          SizedBox(height: 10),

          Padding(
            padding: const EdgeInsets.only(left: 25, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5),
                Text(
                  clientName ?? '',
                  style: TextStyle(fontSize: 14), // fontWeight: FontWeight.bold
                ),
                SizedBox(height: 5),
              ],
            ),
          ),

          SizedBox(height: 20),
        ],
      ),
    );
  }
}
