import 'package:flutter/material.dart';

Widget infoCard({required String title, required int value}) {
  return Card(
    elevation: 4,
    color: Colors.white,
    child: SizedBox(
      height: 100,
      width: 160,
      child: Column(
        children: [
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Divider(color: Color(0xFF34949C)),
          ),
          const SizedBox(height: 5),
          Text(
            // "Pz. $value",
            "$value",
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
          ),
        ],
      ),
    ),
  );
}
