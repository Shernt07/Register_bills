import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:h2o_admin_app/models/products/allCategoriesProducts_models.dart';
import 'package:h2o_admin_app/widgets/alertDialog/alertDialog_productPrice_custom.dart';
import 'package:h2o_admin_app/widgets/alertDialog/alert_dialog_custom.dart';
import 'package:h2o_admin_app/widgets/textFormField/text_form_field_decimal_custom.dart';
import 'package:image_picker/image_picker.dart';
import 'package:h2o_admin_app/widgets/appBar/app_bar_widget.dart';
import 'package:h2o_admin_app/widgets/textFormField/text_form_field_custom.dart';
import 'package:h2o_admin_app/providers/products_provider.dart';

class ManagementProductsAddScreen extends ConsumerStatefulWidget {
  static String name = 'management_productsAdd_screen';

  const ManagementProductsAddScreen({super.key});

  @override
  ConsumerState<ManagementProductsAddScreen> createState() =>
      _ManagementProductsAddScreenState();
}

class _ManagementProductsAddScreenState
    extends ConsumerState<ManagementProductsAddScreen> {
  File? _selectedImage;
  bool _submitted = false;
  bool _isLoading = false;

  List<OptionItem> options = [];

  List<AllcategoriesProductsModels> _categories = [];
  AllcategoriesProductsModels? _selectedCategoryModel;

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    if (!mounted) return;

    final categories =
        await ref.read(productsProvider.notifier).loadCategories(); //provider
    if (mounted) {
      setState(() {
        _categories = categories;
      });
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (pickedFile != null && mounted) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _submit() async {
    final formControllers = ref.read(productsFormProvider);

    if (formControllers.nameProduct.text.isNotEmpty &&
        formControllers.description.text.isNotEmpty &&
        _selectedImage != null &&
        _selectedCategoryModel != null) {
      setState(() {
        _isLoading = true;
      });

      try {
        final created = await ref
            .read(productsProvider.notifier)
            .createProduct(
              _selectedImage!,
              formControllers.nameProduct.text,
              _selectedCategoryModel!.idCategorie.toString(),
              formControllers.description.text,
              //formControllers,
            );

        setState(() {
          _isLoading = false;
        });

        if (created != null) {
          setState(() {
            _submitted = true;
            options =
                created.prices.map((price) {
                  return OptionItem(
                    idProduct: price.idProduct, // Asignamos idProduct
                    idTypeUser: price.idTypeUser, // Asignamos idTypeUser
                    name: price.nameType, // Asignamos nameType
                  );
                }).toList();
          });

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Producto creado exitosamente')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Error al crear el producto')),
          );
        }
      } catch (e) {
        setState(() {
          _isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al crear el producto: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Completa todos los campos')),
      );
    }
  }

  Future<void> assignPrices() async {
    for (var option in options) {
      if (option.selected) {
        final response = await ref
            .read(productsProvider.notifier)
            .addPriceProduct(
              option.idProduct,
              option.idTypeUser,
              double.tryParse(option.quantityController.text) ?? 0.00,
              option.selected ? 1 : 0,
            );
        if (!response.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error al asignar precio: ${response.message}'),
            ),
          );
        }
      }
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Precios asignados exitosamente')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(productsProvider);
    final formControllers = ref.watch(
      productsFormProvider,
    ); // Usamos el provider de controladores

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: const AppBarCustom(),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.only(
                left: 25,
                right: 25,
                top: 25,
                bottom: MediaQuery.of(context).viewInsets.bottom + 25,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Form(
                    child: Column(
                      children: [
                        const Row(
                          children: [
                            Expanded(
                              child: Divider(
                                thickness: 1,
                                color: Color(0xFF08A5C0),
                                endIndent: 10,
                              ),
                            ),
                            Text(
                              'Agregar producto',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 13,
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                thickness: 1,
                                color: Color(0xFF08A5C0),
                                indent: 10,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),

                        TextFormFieldCustom(
                          controller: formControllers.nameProduct,
                          labelText: "Nombre",
                          icon: Icons.interests_outlined,
                          textInputAction: TextInputAction.next,
                          enabled: true,
                        ),
                        const SizedBox(height: 20),

                        TextFormFieldCustom(
                          controller: formControllers.description,
                          labelText: "Descripción",
                          icon: Icons.description_outlined,
                          textInputAction: TextInputAction.next,
                          enabled: true,
                        ),
                        const SizedBox(height: 20),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: DropdownButtonFormField<
                            AllcategoriesProductsModels
                          >(
                            decoration: InputDecoration(
                              labelText: 'Categoría',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            value: _selectedCategoryModel,
                            items:
                                _categories.map((category) {
                                  return DropdownMenuItem<
                                    AllcategoriesProductsModels
                                  >(
                                    value: category,
                                    child: Text(category.nameCategorie),
                                  );
                                }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                _selectedCategoryModel = newValue;
                              });
                            },
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
                        const SizedBox(height: 20),

                        if (_selectedImage != null)
                          SizedBox(
                            height: 100,
                            width: 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                _selectedImage!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        const SizedBox(height: 20),

                        if (_isLoading)
                          SizedBox(
                            width: 150,
                            child: const LinearProgressIndicator(),
                          ),
                        const SizedBox(height: 20),

                        if (!_isLoading && !_submitted)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12.0,
                                    horizontal: 32.0,
                                  ),
                                ),
                                child: const Text(
                                  'Cancelar',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w100,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              ElevatedButton(
                                onPressed: _submit,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF08A5C0),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12.0,
                                    horizontal: 32.0,
                                  ),
                                ),
                                child: const Text(
                                  'Crear',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w100,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        const SizedBox(height: 30),

                        if (_submitted)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10.0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Selecciona los precios:",
                                  style: TextStyle(fontSize: 16),
                                ),
                                const SizedBox(height: 10),
                                ...options.map((option) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 5.0,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Checkbox(
                                              value: option.selected,
                                              onChanged: (bool? value) {
                                                setState(() {
                                                  option.selected =
                                                      value ?? false;
                                                  if (!option.selected) {
                                                    option.quantityController
                                                        .clear();
                                                  }
                                                });
                                              },
                                            ),
                                            Expanded(
                                              child: Text(
                                                option.name,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        if (option.selected)
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              left: 48.0,
                                            ), // Indentado para que no choque con el checkbox
                                            child: TextFormFieldDecimalCustom(
                                              keyboardType:
                                                  TextInputType.number,
                                              controller:
                                                  option.quantityController,
                                              icon:
                                                  Icons
                                                      .monetization_on_outlined,
                                              labelText: 'Precio',
                                              onChanged: (value) {
                                                setState(() {
                                                  option.selected = true;
                                                });
                                              },
                                            ),
                                          ),
                                      ],
                                    ),
                                  );
                                }).toList(),

                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext contex) {
                                            return CustomAlertDialogPrice(
                                              title:
                                                  'Cancelar asignación del producto',
                                              subtitle:
                                                  '¿Estas seguro que deseas cancelar la asignación de precios?',

                                              onCancel: () {},
                                              onConfirm: () async {
                                                if (!mounted) return;
                                                Navigator.of(context).pop(true);
                                              },
                                              destination:
                                                  "/managementProducts",
                                            );
                                          },
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            15,
                                          ),
                                        ),
                                      ),
                                      child: const Text(
                                        'Cancelar',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () async {
                                        final result = await showDialog<bool>(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return CustomAlertDialogPrice(
                                              title: 'Confirmar',
                                              subtitle:
                                                  '¿Estas seguro que deseas confirmar la asignación de precios?',
                                              onConfirm: () async {
                                                await assignPrices();
                                                if (!mounted) return;
                                                Navigator.of(context).pop(true);
                                                Future.microtask(
                                                  () =>
                                                      ref
                                                          .read(
                                                            productsProvider
                                                                .notifier,
                                                          )
                                                          .loadProducts(),
                                                );
                                              },
                                              onCancel: () {},
                                              destination:
                                                  "/managementProducts",
                                            );
                                          },
                                        );
                                      },

                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(
                                          0xFF08A5C0,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            15,
                                          ),
                                        ),
                                      ),
                                      child: const Text(
                                        'Confirmar',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class OptionItem {
  final String name;
  final int idProduct;
  final int idTypeUser;
  bool selected = false;
  TextEditingController quantityController = TextEditingController();

  OptionItem({
    required this.name,
    required this.idProduct,
    required this.idTypeUser,
  });
}
