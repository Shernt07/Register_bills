import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:h2o_admin_app/models/delivery/allDelivery_models.dart';
import 'package:h2o_admin_app/widgets/alertDialog/alert_dialog_custom.dart';
import 'package:h2o_admin_app/widgets/appBar/app_bar_widget.dart';
import 'package:h2o_admin_app/widgets/bottomNavigatorBar/bottom_navigator_bar_widget.dart';
import 'package:h2o_admin_app/providers/deliverys_provider.dart';
import 'package:h2o_admin_app/widgets/textFormField/text_form_field_custom.dart';

class ManagementDistributorsEditScreen extends ConsumerStatefulWidget {
  static const String name = 'management_distributorsEdit_screen';
  final AllDeliveryModels delivery;

  const ManagementDistributorsEditScreen({super.key, required this.delivery});

  @override
  ConsumerState<ManagementDistributorsEditScreen> createState() =>
      _ManagementDistributorsAddScreenState();
}

class _ManagementDistributorsAddScreenState
    extends ConsumerState<ManagementDistributorsEditScreen> {
  final Map<String, String> genderMap = {"Masculino": "1", "Femenino": "2"};

  @override
  void initState() {
    super.initState();

    // Inicializamos los controladores con los valores pasados
    final deliveryController =
        ref.read(deliverysProvider.notifier).formControllers;
    deliveryController.name.text = widget.delivery.nameStaff;
    deliveryController.lastName.text = widget.delivery.firtsLastNameStaff;
    deliveryController.secondLastName.text =
        widget.delivery.secondLastNameStaff;
    deliveryController.email.text = widget.delivery.emailStaff;
    deliveryController.telephone.text = widget.delivery.telephoneStaff;
    deliveryController.password.text = widget.delivery.passwordUser;
    deliveryController.idUser.text = widget.delivery.idUser.toString();

    // Mapear el valor recibido a "1" o "2"
    final sex =
        widget.delivery.initalSex.toLowerCase(); // e.g. "masculino", "m"
    final sexMap = {"masculino": "1", "m": "1", "femenino": "2", "f": "2"};
    final mappedSex = sexMap[sex] ?? "1"; // valor por defecto si no coincide

    ref.read(deliverysProvider.notifier).setSelectedSexId(mappedSex);
  }

  @override
  Widget build(BuildContext context) {
    // final delivery = widget.delivery;
    final deliveryController =
        ref.read(deliverysProvider.notifier).formControllers;

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
                  'Editar repartidor',
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
                      controller: deliveryController.name,
                      labelText: 'Nombre',
                      icon: Icons.person,
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(height: 20),
                    TextFormFieldCustom(
                      controller: deliveryController.lastName,
                      labelText: 'Apellido Paterno',
                      icon: Icons.person,
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(height: 20),
                    TextFormFieldCustom(
                      controller: deliveryController.secondLastName,
                      labelText: 'Apellido Materno',
                      icon: Icons.person,
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(height: 20),
                    TextFormFieldCustom(
                      controller: deliveryController.email,
                      labelText: 'Correo',
                      icon: Icons.email,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 15.0),
                    TextFormFieldCustom(
                      controller: deliveryController.telephone,
                      labelText: 'Teléfono',
                      icon: Icons.phone,
                      keyboardType: TextInputType.phone,
                    ),

                    const SizedBox(height: 15.0),
                    TextFormFieldCustom(
                      controller: deliveryController.password,
                      labelText: 'Contraseña',
                      icon: Icons.password,
                      keyboardType: TextInputType.visiblePassword,
                    ),
                    const SizedBox(height: 15.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 9.0),
                      child: DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: 'Género',
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        value:
                            ref.watch(deliverysProvider.notifier).selectedSexId,
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              ref
                                  .read(deliverysProvider.notifier)
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
                    const SizedBox(height: 50),
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          final confirmed = await showDialog<bool>(
                            context: context,
                            builder: (BuildContext context) {
                              return CustomAlertDialog(
                                title: "Agregar Repartidor",
                                subtitle:
                                    "¿Estás seguro de que deseas agregar al repartidor?",
                                onConfirm: () => Navigator.pop(context, true),
                              );
                            },
                          );

                          if (confirmed == true) {
                            final success =
                                await ref
                                    .read(deliverysProvider.notifier)
                                    .updateDelivery(); //update
                            ref
                                .read(deliverysProvider.notifier)
                                .loadDeliverys(); //reload de lsita repartidor

                            if (success) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "Repartidor agregado con éxito",
                                  ),
                                ),
                              );
                              Navigator.pop(context);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Error al agregar repartidor"),
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
