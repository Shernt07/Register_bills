import 'package:flutter/material.dart';

class DistributorCardCustom extends StatelessWidget {
  final String distributorName;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  final String? imageUrl; // Nueva propiedad opcional para la imagen

  const DistributorCardCustom({
    super.key,
    required this.distributorName,
    required this.onDelete,
    required this.onEdit,
    this.imageUrl, // ← imagen opcional
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),

        child: Row(
          children: [
            SizedBox(width: 20),
            Column(
              children: [
                const SizedBox(height: 8),

                // Imagen de perfil redonda
                // SizedBox(
                //   height: 80,
                //   width: 80,
                //   child: Image.network("$imageUrl"),
                // ),
                Container(
                  width: 85, //80
                  height: 85,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                        Colors.grey.shade200, // Color de fondo si no hay imagen
                    image: DecorationImage(
                      image:
                          imageUrl != null
                              ? NetworkImage(imageUrl!)
                              : AssetImage('assets/img/image.png')
                                  as ImageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),

            // Botones
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child:
                      // SizedBox(width: 20),
                      // Nombre del distribuidor
                      Text(
                        distributorName,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: onDelete,
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit, color: Color(0xFF08A5C0)),
                        onPressed: onEdit,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
