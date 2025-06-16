import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:h2o_admin_app/providers/carousel_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:h2o_admin_app/providers/categories_provider.dart';

class CustomAlertDialogNews extends ConsumerStatefulWidget {
  final String title;
  final String? subtitle;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final String? destination;

  const CustomAlertDialogNews({
    super.key,
    required this.title,
    this.subtitle,
    this.onConfirm,
    this.onCancel,
    this.destination,
  });

  @override
  ConsumerState<CustomAlertDialogNews> createState() =>
      _CustomAlertDialogNewsState();
}

class _CustomAlertDialogNewsState extends ConsumerState<CustomAlertDialogNews> {
  File? selectedImage;
  TextEditingController nameController = TextEditingController();
  FocusNode focusNode = FocusNode();

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No se seleccionó ninguna imagen')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Dialog(
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
                ),
              ),
              const SizedBox(height: 20),

              // TextField(
              //   controller: nameController,
              //   focusNode: focusNode,
              //   decoration: const InputDecoration(
              //     labelText: 'Nombre de la categoría',
              //     border: OutlineInputBorder(),
              //   ),
              // ),
              // const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _pickImage,
                icon: const Icon(Icons.image),
                label: const Text("Seleccionar imagen"),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // muestro la imagen
              if (selectedImage != null)
                SizedBox(
                  height: 80,
                  width: 80,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(selectedImage!, fit: BoxFit.cover),
                  ),
                ),

              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //NO
                  ElevatedButton(
                    onPressed: () {
                      if (widget.onCancel != null) widget.onCancel!();
                      Navigator.of(context).pop();
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
                  //SI
                  ElevatedButton(
                    onPressed: () async {
                      // final name = nameController.text.trim();
                      if (selectedImage == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Imagen es requerida')),
                        );
                        return;
                      }
                      final notifier = ref.read(carouselProvider.notifier);
                      final success = await notifier.createNewImg(
                        //name,
                        selectedImage!,
                      );
                      if (success) {
                        if (widget.onConfirm != null) widget.onConfirm!();
                        Navigator.of(context).pop();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Error al crear anuncio'),
                          ),
                        );
                      }
                      // Navigator.of(context).pop();
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
      ),
    );
  }
}
