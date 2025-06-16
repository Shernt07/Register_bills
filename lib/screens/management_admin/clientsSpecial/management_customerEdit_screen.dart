import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:h2o_admin_app/models/customer/allCustomer_models.dart';
import 'package:h2o_admin_app/widgets/alertDialog/alert_dialog_custom.dart';
import 'package:h2o_admin_app/widgets/appBar/app_bar_widget.dart';
import 'package:h2o_admin_app/widgets/bottomNavigatorBar/bottom_navigator_bar_widget.dart';
import 'package:h2o_admin_app/providers/customer_provider.dart';

import 'package:h2o_admin_app/widgets/textFormField/text_form_field_custom.dart';

class ManagementCustomerEditScreen extends ConsumerStatefulWidget {
  static const String name = 'management_customerEdit_screen';
  final AllCustomerModels customer;

  const ManagementCustomerEditScreen({super.key, required this.customer});

  @override
  ConsumerState<ManagementCustomerEditScreen> createState() =>
      _ManagementCustomerEditScreenState();
}

class _ManagementCustomerEditScreenState
    extends ConsumerState<ManagementCustomerEditScreen> {
  final Map<String, String> genderMap = {"Masculino": "1", "Femenino": "2"};

  String? mapInitialSexToId(String initialSex) {
    if (initialSex == "M") return "1";
    if (initialSex == "F") return "2";
    return null;
  }

  DateTime? selectedDate;
  String? selectedGenderId;
  int? selectedTypeCustomerId;

  @override
  void initState() {
    super.initState();
    // Cargar los tipos de clientes cuando la pantalla se inicializa
    ref.read(customerProvider.notifier).loadTypeCustomer();

    // Cargar los tipos de clientes cuando la pantalla se inicializa
    ref.read(customerProvider.notifier).loadTypeCustomer();
    final customerController =
        ref.read(customerProvider.notifier).formControllers;
    customerController.name.text = widget.customer.nameClient;
    customerController.lastName.text = widget.customer.firtsLastNameClient;
    customerController.secondLastName.text =
        widget.customer.secondLastNameClient;
    customerController.fechaNacimineto.text =
        "${widget.customer.dateCreation.year}-${widget.customer.dateCreation.month.toString().padLeft(2, '0')}-${widget.customer.dateCreation.day.toString().padLeft(2, '0')}";
    customerController.email.text = widget.customer.emailClient;
    customerController.telephone.text = widget.customer.telephoneClient;
    customerController.nameUser.text = widget.customer.nameUser;
    customerController.password.text = widget.customer.passwordUser;
    customerController.genero.text = widget.customer.descriptionSex;
    customerController.idType.text = widget.customer.nameType;
    customerController.idUser.text = widget.customer.idUser.toString();

    selectedGenderId = mapInitialSexToId(widget.customer.initalSex);
  }

  @override
  Widget build(BuildContext context) {
    final customerController =
        ref.read(customerProvider.notifier).formControllers;
    final typeCustomers = ref.watch(customerProvider.notifier).typeCustomers;

    if (typeCustomers.isNotEmpty && selectedTypeCustomerId == null) {
      final matchedType = typeCustomers.firstWhere(
        (t) => t.nameType == widget.customer.nameType,
        orElse: () => typeCustomers.first, // valor por defecto si no encuentra
      );
      selectedTypeCustomerId = matchedType.idTypeUser;
    }

    return Scaffold(
      appBar: const AppBarCustom(),
      backgroundColor: const Color(0xFFF0F5F5),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Expanded(
                  child: Divider(thickness: 2, color: Color(0xFF08A5C0)),
                ),
                SizedBox(width: 8),
                Text(
                  'Editar cliente',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Divider(thickness: 2, color: Color(0xFF08A5C0)),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextFormFieldCustom(
                      controller: customerController.name,
                      labelText: 'Nombre completo',
                      icon: Icons.person,
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(height: 20),
                    TextFormFieldCustom(
                      controller: customerController.lastName,
                      labelText: 'Apellido Paterno',
                      icon: Icons.person,
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(height: 20),
                    TextFormFieldCustom(
                      controller: customerController.secondLastName,
                      labelText: 'Apellido Materno',
                      icon: Icons.person,
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(height: 20),
                    InkWell(
                      onTap: () async {
                        DateTime initialDate = DateTime(2000, 1, 1);

                        // Si ya hay una fecha escrita, intenta parsearla
                        if (customerController
                            .fechaNacimineto
                            .text
                            .isNotEmpty) {
                          try {
                            initialDate = DateTime.parse(
                              customerController.fechaNacimineto.text,
                            );
                          } catch (e) {
                            // Si falla el parseo, usar la fecha por defecto
                            initialDate = DateTime(2000, 1, 1);
                          }
                        }
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: initialDate,
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );
                        if (picked != null) {
                          setState(() {
                            customerController.fechaNacimineto.text =
                                "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
                          });
                        }
                      },
                      child: IgnorePointer(
                        child: TextFormFieldCustom(
                          controller: customerController.fechaNacimineto,
                          labelText: 'Fecha de nacimiento',
                          icon: Icons.calendar_today,
                          keyboardType: TextInputType.datetime,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                    TextFormFieldCustom(
                      controller: customerController.email,
                      labelText: 'Correo',
                      icon: Icons.email,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 15.0),
                    TextFormFieldCustom(
                      controller: customerController.telephone,
                      labelText: 'Teléfono',
                      icon: Icons.phone,
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 15.0),
                    TextFormFieldCustom(
                      controller: customerController.nameUser,
                      labelText: 'Usuario',
                      icon: Icons.person,
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(height: 15.0),
                    TextFormFieldCustom(
                      controller: customerController.password,
                      labelText: 'Contraseña',
                      icon: Icons.password,
                      keyboardType: TextInputType.visiblePassword,
                    ),
                    const SizedBox(height: 15.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 9.0),
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Género',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),

                          filled: true,
                          fillColor: Colors.white,
                        ),
                        value: selectedGenderId,

                        //ref.watch(customerProvider.notifier).selectedSexId,
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              selectedGenderId = newValue;
                              ref
                                  .read(customerProvider.notifier)
                                  .setSelectedSexId(newValue);
                            });
                          }
                        },
                        items:
                            genderMap.entries.map((entry) {
                              return DropdownMenuItem<String>(
                                value: entry.value,
                                child: Text(entry.key),
                              );
                            }).toList(),
                      ),
                    ),
                    // Dropdown para seleccionar tipo de cliente
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 9.0),
                      child: DropdownButtonFormField<int>(
                        decoration: InputDecoration(
                          labelText: 'Tipo de Cliente',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        value:
                            selectedTypeCustomerId, // O el valor por defecto si lo tienes
                        onChanged: (int? selectedType) {
                          if (selectedType != null) {
                            selectedTypeCustomerId = selectedType;
                            // Guardar el idTypeUser en el formulario
                            customerController.idType.text =
                                selectedType.toString();
                          }
                        },
                        items:
                            typeCustomers.map((type) {
                              return DropdownMenuItem<int>(
                                value: type.idTypeUser,
                                child: Text(type.nameType),
                              );
                            }).toList(),
                      ),
                    ),
                    const SizedBox(height: 50),
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          final confirmed = await showDialog<bool>(
                            context: context,
                            builder: (BuildContext context) {
                              return CustomAlertDialog(
                                title: "Actualizar cliente",
                                subtitle:
                                    "¿Estás seguro de que deseas actualizar al cliente?",
                                onConfirm: () => Navigator.pop(context, true),
                              );
                            },
                          );

                          if (confirmed == true) {
                            final success =
                                await ref
                                    .read(customerProvider.notifier)
                                    .updateCustomer();
                            ref
                                .read(customerProvider.notifier)
                                .loadCustomer(); //actualizar la lista despues de editar

                            if (success) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "Cliente actualizado con éxito",
                                  ),
                                ),
                              );
                              Navigator.pop(context);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Error al actualizar cliente"),
                                ),
                              );
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF08A5C0),
                          padding: const EdgeInsets.symmetric(
                            vertical: 12.0,
                            horizontal: 32.0,
                          ),
                        ),
                        child: const Text(
                          'Actualizar',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w100,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigatorBarCustom(),
    );
  }
}
