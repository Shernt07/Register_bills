import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomAlertDialogPrice extends StatefulWidget {
  final String title;
  final String subtitle;
  final Future<void> Function()? onConfirm; // Async callback
  final VoidCallback? onCancel;
  final String? destination; // Parámetro nuevo para la ruta

  const CustomAlertDialogPrice({
    super.key,
    required this.title,
    required this.subtitle,
    this.onConfirm,
    this.onCancel,
    this.destination, // Asegúrate de agregarlo aquí
  });

  @override
  State<CustomAlertDialogPrice> createState() => _CustomAlertDialogPriceState();
}

class _CustomAlertDialogPriceState extends State<CustomAlertDialogPrice> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              widget.subtitle,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (widget.onCancel != null) widget.onCancel!();
                        Navigator.of(context).pop(false);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'No',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (widget.onConfirm != null) {
                          setState(() {
                            _isLoading = true;
                          });
                          await widget.onConfirm!();
                          if (mounted) {
                            Navigator.of(context).pop(true);

                            if (widget.destination != null) {
                              // Si empieza con "/", asumimos que es un path; si no, es un nombre
                              if (widget.destination!.startsWith("/")) {
                                context.push(
                                  widget.destination!,
                                ); // push con path
                              } else {
                                context.pushNamed(
                                  widget.destination!,
                                ); // push con nombre
                              }
                            }
                          }
                        }
                      },

                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF08A5C0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Sí',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
          ],
        ),
      ),
    );
  }
}
