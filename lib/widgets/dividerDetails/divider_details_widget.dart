import 'package:flutter/material.dart';

class DividerDetailsCustom extends StatelessWidget {
  //  Variables...
  final IconData? iconPrincipal;
  final String? titleCard;
  final String? folio;

  const DividerDetailsCustom({
    super.key,
    this.iconPrincipal,
    this.titleCard,
    this.folio,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: 30, height: 60),
              Icon(
                iconPrincipal,
                size: 32,
                // Icons.list_alt,
                color: const Color(0xff08A5C0),
              ),
              const SizedBox(width: 15),
              Row(
                children: [
                  Text(
                    "$titleCard",
                    //'#408569',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 10),
                  Text(
                    "$folio",
                    // style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              children: [
                Expanded(
                  child: Divider(thickness: 1, color: Color(0xFF34949C)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
