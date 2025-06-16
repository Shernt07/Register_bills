import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:h2o_admin_app/widgets/alertDialog/alert_dialog_custom.dart';
import 'package:h2o_admin_app/widgets/appBar/app_bar_widget.dart';
import 'package:h2o_admin_app/widgets/bottomNavigatorBar/bottom_navigator_bar_widget.dart';
import 'package:h2o_admin_app/providers/deliverys_provider.dart';
import 'package:h2o_admin_app/providers/customer_provider.dart';

import 'package:h2o_admin_app/widgets/textFormField/text_form_field_custom.dart';

class ManagementCustomerAddScreen extends ConsumerStatefulWidget {
  static const String name = 'management_customerAdd_screen';

  const ManagementCustomerAddScreen({super.key});

  @override
  ConsumerState<ManagementCustomerAddScreen> createState() =>
      _ManagementCustomerAddScreenState();
}

class _ManagementCustomerAddScreenState
    extends ConsumerState<ManagementCustomerAddScreen> {
  final Map<String, String> genderMap = {"Masculino": "1", "Femenino": "2"};
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    // Cargar los tipos de clientes cuando la pantalla se inicializa
    ref.read(customerProvider.notifier).loadTypeCustomer();
  }

  @override
  Widget build(BuildContext context) {
    final customerController =
        ref.read(customerProvider.notifier).formControllers;
    final typeCustomers = ref.watch(customerProvider.notifier).typeCustomers;

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
                  'Agregar cliente',
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
                        value: null,

                        //ref.watch(customerProvider.notifier).selectedSexId,
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() {
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
                        value: null, // O el valor por defecto si lo tienes
                        onChanged: (int? selectedType) {
                          if (selectedType != null) {
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
                                title: "Agregar cliente",
                                subtitle:
                                    "¿Estás seguro de que deseas agregar al cliente?",
                                onConfirm: () => Navigator.pop(context, true),
                              );
                            },
                          );

                          if (confirmed == true) {
                            final success =
                                await ref
                                    .read(customerProvider.notifier)
                                    .createCustomer();
                            ref
                                .read(customerProvider.notifier)
                                .loadCustomer(); //cargar clientes luego de presionar

                            if (success) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Cliente agregado con éxito"),
                                ),
                              );
                              Navigator.pop(context);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Error al agregar cliente"),
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
                          'Agregar',
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
