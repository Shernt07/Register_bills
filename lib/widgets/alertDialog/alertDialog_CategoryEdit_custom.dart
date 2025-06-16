import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:h2o_admin_app/providers/categories_provider.dart';

class CustomAlertDialogEdit extends ConsumerStatefulWidget {
  final String title;
  final String? subtitle;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final String? destination;
  final String namedefault;
  final String urlImage;
  final String idCategorie;

  const CustomAlertDialogEdit({
    super.key,
    required this.title,
    this.subtitle,
    this.onConfirm,
    this.onCancel,
    this.destination,
    required this.namedefault,
    required this.urlImage,
    required this.idCategorie,
  });

  @override
  ConsumerState<CustomAlertDialogEdit> createState() =>
      _CustomAlertDialogEditState();
}

class _CustomAlertDialogEditState extends ConsumerState<CustomAlertDialogEdit> {
  File? selectedImage;
  TextEditingController nameController = TextEditingController();
  TextEditingController newNameController = TextEditingController();

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
  void initState() {
    super.initState();
    nameController.text = widget.namedefault;
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

              TextField(
                controller: nameController,
                focusNode: focusNode,
                decoration: InputDecoration(
                  labelText: 'Nombre de la categoría',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),

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

              SizedBox(
                height: 80,
                width: 80,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child:
                      selectedImage != null
                          ? Image.file(selectedImage!, fit: BoxFit.cover)
                          : Image.network(widget.urlImage, fit: BoxFit.cover),
                ),
              ),

              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
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
                  ElevatedButton(
                    onPressed: () async {
                      final name = nameController.text.trim();
                      // Verifica si hubo algún cambio
                      final nameChanged = name != widget.namedefault;
                      final imageChanged = selectedImage != null;

                      if (!nameChanged && !imageChanged) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('No realizo ningun cambio'),
                          ),
                        );
                        Navigator.of(context).pop();
                        return;
                      }
                      final notifier = ref.read(categoriesProvider.notifier);
                      final success = await notifier.updateCategory(
                        name: name,
                        myFile: selectedImage,
                        idCategorie: widget.idCategorie,
                      );
                      if (success) {
                        if (widget.onConfirm != null) widget.onConfirm!();
                        Navigator.of(context).pop();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Error al crear categoría'),
                          ),
                        );
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
      ),
    );
  }
}
