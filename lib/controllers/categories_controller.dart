



// SE MIGRO A UN PROVIDER.................









// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:h2o_admin_app/models/response_api.dart';
// import 'package:h2o_admin_app/models/categories/allCategories_models.dart';
// import 'package:h2o_admin_app/service/categoriesService/allCategories_service.dart';
// import 'package:h2o_admin_app/providers/categories_provider.dart'; // Asegúrate de importar tu provider

// class AllCategoriesController {
//   BuildContext? context;
//   WidgetRef? ref;

//   final AllCategoriesService _service = AllCategoriesService();

//   void init(BuildContext context, WidgetRef ref) {
//     this.context = context;
//     this.ref = ref;
//     _service.init(context);
//   }

//   Future<void> loadCategories() async {
//     try {
//       final response = await _service.allCategoriesService();

//       if (response.success) {
//         final categoriesModel = AllCategoriesModel.fromJson(response.data);
//         ref?.read(categoriesProvider.notifier).setCategories(categoriesModel.categories);
//       } else {
//         EasyLoading.showToast(response.message);
//       }
//     } catch (e) {
//       EasyLoading.showToast("Error: $e");
//       debugPrint("Error al cargar categorías: $e");
//     }
//   }
// }


//USAREMOS EL PROVIDER SIN EL CONTROLLER...