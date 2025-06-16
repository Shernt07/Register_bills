import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:h2o_admin_app/models/customer/allCustomer_models.dart';
import 'package:h2o_admin_app/models/customer/typeCustomer_models.dart';
import 'package:flutter/material.dart';
import 'package:h2o_admin_app/service/customer/customer_services.dart';

class CustomerNotifier extends StateNotifier<List<AllCustomerModels>> {
  CustomerNotifier() : super([]) {
    loadCustomer();
  }

  final CustomerFormControllers formControllers = CustomerFormControllers();
  String _selectedSexId = '1'; // valor por defecto
  //final TextEditingController birthDate = TextEditingController();
  List<TypeCustomerModels> _typeCustomers =
      []; // Para almacenar los tipos de clientes

  // Getter para acceder a los type customers
  List<TypeCustomerModels> get typeCustomers => _typeCustomers;

  String get selectedSexId => _selectedSexId;
  void setSelectedSexId(String id) {
    _selectedSexId = id;
  }

  // Establecer customers
  void setCustomer(List<AllCustomerModels> customer) {
    state = customer;
  }

  // Cargar customers
  Future<void> loadCustomer() async {
    final response = await AllCustomerService().allCustomerService();
    if (response.success) {
      final List<dynamic> rawList = response.data;
      final customer =
          rawList.map((e) => AllCustomerModels.fromJson(e)).toList();
      state = customer;
    }
  }

  // Cargar Type_customers
  Future<void> loadTypeCustomer() async {
    final response = await AllCustomerService().allTypeCustomerService();
    if (response.success) {
      final List<dynamic> rawList = response.data;
      final typeCustomers =
          rawList.map((e) => TypeCustomerModels.fromJson(e)).toList();

      // Actualizamos la lista de _typeCustomers
      _typeCustomers = typeCustomers;
    }
  }

  // Método para obtener los TypeCustomerModels
  List<TypeCustomerModels> getTypeCustomers() {
    return _typeCustomers; // Retorna los datos almacenados
  }

  Future<bool> createCustomer() async {
    final service = AllCustomerService();
    final c = formControllers;
    // Pasar los parametros desde la ui y los recibe aqui
    final response = await service.addCustomerService(
      c.nameUser.text.trim(),
      c.password.text.trim(),
      int.parse(c.idType.text.trim()),
      c.name.text.trim(),
      c.lastName.text.trim(),
      c.secondLastName.text.trim(),
      c.telephone.text.trim(),
      c.fechaNacimineto.text.trim(),
      int.parse(_selectedSexId),
      c.email.text.trim(),
    );

    if (response.success) {
      await loadCustomer(); // recargar la lista
      formControllers.clear(); // LIMPIAR FORMULARIO
      _selectedSexId = '1'; //  Reiniciar el género (SI GUSTAS)
      return true;
    } else {
      print('Error al crear cliente-provider: ${response.message}');
      return false;
    }
  }

  // //Actualizar
  Future<bool> updateCustomer() async {
    final service = AllCustomerService();
    final c = formControllers;
    final idUserInt = int.parse(c.idUser.text.trim());
    // Llamar al servicio de actualización con los nuevos valores del formulario
    final response = await service.updateCustomerService(
      idUserInt,
      c.password.text.trim(),
      c.name.text.trim(),
      c.lastName.text.trim(),
      c.secondLastName.text.trim(),
      c.telephone.text.trim(),
      c.fechaNacimineto.text.trim(),
      int.parse(_selectedSexId), // El género
      c.email.text.trim(),
    );

    if (response.success) {
      await loadCustomer(); // Recargar la lista de customers
      // formControllers.clear(); // Limpiar los controladores
      _selectedSexId = '1'; // Resetear el género
      return true;
    } else {
      print('Error al actualizar customer-provider: ${response.message}');
      return false;
    }
  }

  // Eliminar categoría
  Future<bool> deleteCustomer(int idUser) async {
    final service = AllCustomerService();
    final response = await service.deleteCustomerService(
      idUser,
    ); // Llamar al servicio DELETE

    if (response.success) {
      // Actualizar el estado después de eliminar la categoría
      state = state.where((customer) => customer.idUser != idUser).toList();
      return true;
    } else {
      print('Error al eliminar repartidor-provider: ${response.message}');
      return false;
    }
  }
}

// como exportación del provider
final customerProvider =
    StateNotifierProvider<CustomerNotifier, List<AllCustomerModels>>(
      (ref) => CustomerNotifier(),
    );

// clase para manejar los controladores globales yreutilziales
class CustomerFormControllers {
  final idUser = TextEditingController();
  final nameUser = TextEditingController();
  final password = TextEditingController();
  final idType = TextEditingController();
  final name = TextEditingController();
  final lastName = TextEditingController();
  final secondLastName = TextEditingController();
  final telephone = TextEditingController();
  final fechaNacimineto = TextEditingController();
  final email = TextEditingController();
  final genero = TextEditingController();

  void dispose() {
    idUser.dispose();
    nameUser.dispose();
    password.dispose();
    name.dispose();
    lastName.dispose();
    secondLastName.dispose();
    telephone.dispose();
    email.dispose();
    genero.dispose();
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
    genero.clear();
  }
}
