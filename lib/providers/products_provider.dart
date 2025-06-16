import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:h2o_admin_app/models/products/allCategoriesProducts_models.dart';
import 'package:h2o_admin_app/models/products/allProducts_models.dart';
import 'package:flutter/material.dart';
import 'package:h2o_admin_app/models/products/createProducts_models.dart';
import 'package:h2o_admin_app/models/response_api.dart';
import 'package:h2o_admin_app/providers/deliverys_provider.dart';
import 'package:h2o_admin_app/service/products/allProducts_service.dart';

class ProductsNotifier extends StateNotifier<List<AllProductsModels>> {
  ProductsNotifier() : super([]) {
    loadProducts();
  }
  //final DeliveryFormControllers formControllers = DeliveryFormControllers();
  // Establecer productos
  void setProducts(List<AllProductsModels> products) {
    state = products;
  }

  // Cargar productos
  Future<void> loadProducts() async {
    final products = await AllProductsService().allProductsService();
    state = products;
  }

  // Cargar categorías
  Future<List<AllcategoriesProductsModels>> loadCategories() async {
    final response = await AllProductsService().allCategoriesService();
    if (response.success) {
      final List<AllcategoriesProductsModels> categories =
          (response.data as List)
              .map((item) => AllcategoriesProductsModels.fromJson(item))
              .toList();
      return categories;
    } else {
      print('Error al cargar categorías: ${response.message}');
      return [];
    }
  }

  // Eliminar producto
  Future<bool> deleteProduct(int idProduct) async {
    final service = AllProductsService();
    final response = await service.deleteProductsService(
      idProduct,
    ); // Llamar al servicio DELETE

    if (response.success) {
      // Actualizar el estado después de eliminar el producto
      state = state.where((product) => product.idProduct != idProduct).toList();
      return true;
    } else {
      print('Error al eliminar producto-provider: ${response.message}');
      return false;
    }
  }

  // Crear nuevo producto
  Future<CreateProductsModels?> createProduct(
    File myFile,
    String nameProduct,
    String idCategorie,
    String description,
  ) async {
    final service = AllProductsService();
    final (responseApi, createdProduct) = await service.createProductSrvice(
      myFile: myFile,
      nameProduct: nameProduct,
      idCategorie: idCategorie,
      description: description,
    );

    if (responseApi.success && createdProduct != null) {
      return createdProduct;
    } else {
      print('Error al crear producto: ${responseApi.message}');
      return null;
    }
  }

  //Confirmar y asignar precios
  Future<ResponseApi> addPriceProduct(
    int idProduct,
    int idTypeUser,
    double price,
    int idStatusPrice,
  ) async {
    final service = AllProductsService();
    final response = await service.addPriceProductService(
      idProduct,
      idTypeUser,
      price,
      idStatusPrice,
    );
    return response;
  }

  // Editar producto
  Future<ResponseApi> updateProduct(
    File? myFile,
    String idProduct,
    //String nameProduct,
    String idCategorie,
    String description,
  ) async {
    final service = AllProductsService();
    final responseApi = await service.updateProductService(
      myFile: myFile,
      idProduct: idProduct,
      // nameProduct: nameProduct,
      idCategorie: idCategorie,
      description: description,
    );

    if (responseApi.success) {
      return responseApi; // Retorna la respuesta exitosa si la actualización fue correcta
    } else {
      print('Error al actualizar producto: ${responseApi.message}');
      return responseApi; // Retorna la respuesta con el error si falló
    }
  }
}

// Exportación del provider
final productsProvider =
    StateNotifierProvider<ProductsNotifier, List<AllProductsModels>>(
      (ref) => ProductsNotifier(),
    );

//  Exportar los controladores
final productsFormProvider = Provider<ProductsFormControllers>((ref) {
  return ProductsFormControllers();
});

// Clase para manejar los controladores de formulario (por si los usas)
class ProductsFormControllers {
  File? selectedImage;
  final nameProduct = TextEditingController();
  final description = TextEditingController();
  final categori = TextEditingController();

  void dispose() {
    nameProduct.dispose();
    description.dispose();
    categori.dispose();
  }

  void clear() {
    nameProduct.clear();
    categori.clear();
    description.clear();
  }
}
