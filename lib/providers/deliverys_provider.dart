import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:h2o_admin_app/models/categories/allCategories_models.dart';
import 'package:h2o_admin_app/models/delivery/allDelivery_models.dart';
import 'package:flutter/material.dart';

import 'dart:io';

import 'package:h2o_admin_app/service/delivery/allDelivery_services.dart';

class DeliverysNotifier extends StateNotifier<List<AllDeliveryModels>> {
  DeliverysNotifier() : super([]) {
    loadDeliverys();
  }

  final DeliveryFormControllers formControllers = DeliveryFormControllers();
  String _selectedSexId = '1'; // valor por defecto

  String get selectedSexId => _selectedSexId;
  void setSelectedSexId(String id) {
    _selectedSexId = id;
  }

  // Establecer categorías
  void setDeliverys(List<AllDeliveryModels> deliverys) {
    state = deliverys;
  }

  // Cargar categorías
  Future<void> loadDeliverys() async {
    final response = await AllDeliveryService().allDeliveryService();
    if (response.success) {
      final List<dynamic> rawList = response.data;
      final deliverys =
          rawList.map((e) => AllDeliveryModels.fromJson(e)).toList();
      state = deliverys;
    }
  }

  Future<bool> createDelivery() async {
    final service = AllDeliveryService();
    final c = formControllers;
    // Pasar los parametros desde la ui y los recibe aqui
    final response = await service.addDeliveryService(
      c.nameUser.text.trim(),
      c.password.text.trim(),
      c.name.text.trim(),
      c.lastName.text.trim(),
      c.secondLastName.text.trim(),
      c.telephone.text.trim(),
      c.email.text.trim(),
      int.parse(_selectedSexId),
    );

    if (response.success) {
      await loadDeliverys(); // recargar la lista
      formControllers.clear(); // LIMPIAR FORMULARIO
      _selectedSexId = '1'; // Reiniciar el género
      return true;
    } else {
      print('Error al crear repartidor-provider: ${response.message}');
      return false;
    }
  }

  // //Actualizar
  Future<bool> updateDelivery() async {
    final service = AllDeliveryService();
    final c = formControllers;
    final idUserInt = int.parse(c.idUser.text.trim());
    // Llamar al servicio de actualización con los nuevos valores del formulario
    final response = await service.updateDeliveryService(
      idUserInt,
      c.password.text.trim(),
      c.name.text.trim(),
      c.lastName.text.trim(),
      c.secondLastName.text.trim(),
      c.telephone.text.trim(),
      c.email.text.trim(),
      int.parse(_selectedSexId), // El género
    );

    if (response.success) {
      await loadDeliverys(); // Recargar la lista de repartidores
      formControllers.clear(); // Limpiar los controladores
      _selectedSexId = '1'; // Resetear el género
      return true;
    } else {
      print('Error al actualizar repartidor-provider: ${response.message}');
      return false;
    }
  }

  // Eliminar categoría
  Future<bool> deleteDelivery(int idDelivery) async {
    final service = AllDeliveryService();
    final response = await service.deleteDeliveryService(
      idDelivery,
    ); // Llamar al servicio DELETE

    if (response.success) {
      // Actualizar el estado después de eliminar la categoría
      state = state.where((delivery) => delivery.idUser != idDelivery).toList();
      return true;
    } else {
      print('Error al eliminar repartidor-provider: ${response.message}');
      return false;
    }
  }
}

// como exportación del provider
final deliverysProvider =
    StateNotifierProvider<DeliverysNotifier, List<AllDeliveryModels>>(
      (ref) => DeliverysNotifier(),
    );

// clase para manejar los controladores globales yreutilziales
class DeliveryFormControllers {
  final idUser = TextEditingController();
  final nameUser = TextEditingController();
  final password = TextEditingController();
  final name = TextEditingController();
  final lastName = TextEditingController();
  final secondLastName = TextEditingController();
  final telephone = TextEditingController();
  final email = TextEditingController();

  void dispose() {
    idUser.dispose();
    nameUser.dispose();
    password.dispose();
    name.dispose();
    lastName.dispose();
    secondLastName.dispose();
    telephone.dispose();
    email.dispose();
  }

  //este lo puedes usar para limpiar los datos // NO USARLO PARA EDITAR
  void clear() {
    idUser.clear();
    nameUser.clear();
    password.clear();
    name.clear();
    lastName.clear();
    secondLastName.clear();
    telephone.clear();
    email.clear();
  }
}
