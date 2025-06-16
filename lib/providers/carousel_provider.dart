import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:h2o_admin_app/models/allCarousel_models.dart';
import 'package:h2o_admin_app/service/carousel/carousel_service.dart';
import 'dart:io';

class CarouselNotifier extends StateNotifier<List<AllCarouselModels>> {
  CarouselNotifier() : super([]) {
    loadCarousel();
  }

  // Establecer categorías
  void setCarousel(List<AllCarouselModels> carousel) {
    state = carousel;
  }

  // Cargar carousel
  Future<void> loadCarousel() async {
    final response = await CarouselService().allCarouselService();
    if (response.success) {
      final List<dynamic> rawList = response.data;
      final carousel =
          rawList.map((e) => AllCarouselModels.fromJson(e)).toList();
      state = carousel;
    }
  }

  // Crear nuevo anunucio
  Future<bool> createNewImg(File myFile) async {
    final service = CarouselService();
    final response = await service.createNewImg(myFile: myFile);

    if (response.success) {
      await loadCarousel();
      return true;
    } else {
      print('Error al crear anuncio: \${response.message}');
      return false;
    }
  }

  // Eliminar Imagen-anuncio
  Future<bool> deleteImg(int id) async {
    final service = CarouselService();
    final response = await service.deleteNewImgService(
      id,
    ); // Llamar al servicio DELETE

    if (response.success) {
      // Actualizar el estado después de eliminar el anuncio
      state = state.where((carousel) => carousel.id != id).toList();
      return true;
    } else {
      print('Error al eliminar anuncio: ${response.message}');
      return false;
    }
  }
}

final carouselProvider =
    StateNotifierProvider<CarouselNotifier, List<AllCarouselModels>>(
      (ref) => CarouselNotifier(),
    );
