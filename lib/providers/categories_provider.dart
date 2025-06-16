import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:h2o_admin_app/models/categories/allCategories_models.dart';
import 'package:h2o_admin_app/service/categoriesService/allCategories_service.dart';
import 'package:h2o_admin_app/service/categoriesService/createCategorie_service.dart';
import 'package:h2o_admin_app/service/categoriesService/deleteCategorie_service.dart';
import 'package:h2o_admin_app/service/categoriesService/uploadCategories_service.dart';

import 'dart:io';

class CategoriesNotifier extends StateNotifier<List<AllCategoriesModel>> {
  CategoriesNotifier() : super([]) {
    loadCategories();
  }

  // Establecer categorías
  void setCategories(List<AllCategoriesModel> categories) {
    state = categories;
  }

  // Cargar categorías
  Future<void> loadCategories() async {
    final response = await AllCategoriesService().allCategoriesService();
    if (response.success) {
      final List<dynamic> rawList = response.data;
      final categories =
          rawList.map((e) => AllCategoriesModel.fromJson(e)).toList();
      state = categories;
    }
  }

  // Crear nueva categoría
  Future<bool> createCategory(String name, File myFile) async {
    final service = CreateCategorieService();
    final response = await service.createCategorie(name: name, myFile: myFile);

    if (response.success) {
      await loadCategories();
      return true;
    } else {
      print('Error al crear categoría: \${response.message}');
      return false;
    }
  }

  //Actualizar
  Future<bool> updateCategory({
    required String name,
    File? myFile,
    required String idCategorie,
  }) async {
    final service = UploadCategorieService();
    // Si no hay imagen, necesitas un endpoint alternativo o enviar sin archivo
    final response =
        myFile != null
            ? await service.uploadCategorieService(
              name: name,
              myFile: myFile,
              idCategorie: idCategorie,
            )
            : await service.uploadCategorieNotImg(
              name: name,
              idCategorie: idCategorie,
            );

    if (response.success) {
      await loadCategories(); // Recarga lista mostrada en screen
      return true;
    } else {
      print('Error al actualizar categoría: ${response.message}');
      return false;
    }
  }

  // Eliminar categoría
  Future<bool> deleteCategory(int idCategorie) async {
    final service = DeleteCategoriesService();
    final response = await service.deleteCategoryService(
      idCategorie,
    ); // Llamar al servicio DELETE

    if (response.success) {
      // Actualizar el estado después de eliminar la categoría
      state =
          state
              .where((category) => category.idCategorie != idCategorie)
              .toList();
      return true;
    } else {
      print('Error al eliminar categoría: ${response.message}');
      return false;
    }
  }
}

final categoriesProvider =
    StateNotifierProvider<CategoriesNotifier, List<AllCategoriesModel>>(
      (ref) => CategoriesNotifier(),
    );
