import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:h2o_admin_app/api/enviroment.dart';
import 'package:h2o_admin_app/models/products/createProducts_models.dart';
import 'package:h2o_admin_app/models/response_api.dart';
import 'package:h2o_admin_app/models/products/allProducts_models.dart'; // Asegúrate de importar tu modelo de productos
import 'package:http/http.dart' as http;

class AllProductsService {
  final String _urlbase = Enviroment.apiBase;
  final String _api = "products";

  BuildContext? context;

  void init(BuildContext context) {
    this.context = context;
  }

  Map<String, String> get _headers => {'Content-Type': 'application/json'};

  Uri _buildUri(String endpoint) {
    return Uri.parse('$_urlbase/$_api/$endpoint');
  }

  Uri _uricategories() {
    return Uri.parse('$_urlbase/catalog/categories');
  }

  Uri _uriCreatedProduct() {
    return Uri.parse('$_urlbase/upload/products');
  }

  //este es el mismo con el de arriba (crearlo con variable)
  Uri _uriUpdateProduct() {
    return Uri.parse('$_urlbase/upload/updateProducts');
  }

  //  GET
  Future<List<AllProductsModels>> allProductsService() async {
    try {
      Uri url = _buildUri("allWithPrice");
      print('URL: $url');
      final response = await http.get(url, headers: _headers);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('Response Data: $data');

        final responseApi = ResponseApi.fromJson(data);

        if (responseApi.success) {
          if (responseApi.data != null) {
            final List<dynamic> listData = responseApi.data;
            final products =
                listData
                    .map((item) => AllProductsModels.fromJson(item))
                    .toList();
            return products;
          } else {
            print('Data vacía en responseApi');
            return [];
          }
        } else {
          print('Error desde el servidor: ${responseApi.message}');
          return [];
        }
      } else {
        final error = json.decode(response.body);
        String emessage = error["message"] ?? 'Error desconocido';
        print("Error service: $emessage");
        return [];
      }
    } catch (e) {
      print('Exception en allProductsService: $e');
      return [];
    }
  }

  // Método DELETE
  Future<ResponseApi> deleteProductsService(int idProduct) async {
    try {
      // Construir la URL para el endpoint de eliminación con el idCategorie
      Uri url = _buildUri(
        "$idProduct",
      ); // Ejemplo de endpoint: /categories/delete/1
      print(url);

      // Realizar la solicitud DELETE
      final response = await http.delete(url, headers: _headers);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return ResponseApi.fromJson(data);
      } else {
        final error = json.decode(response.body);
        String emessage = error["message"] ?? 'Error desconocido';
        return ResponseApi(message: 'Error: $emessage', success: false);
      }
    } catch (e) {
      print('Error en deleteProductService: $e');
      return ResponseApi(message: 'Excepción: $e', success: false);
    }
  }

  // SERVICE GETALLcategorias
  Future<ResponseApi> allCategoriesService() async {
    try {
      Uri url = _uricategories();
      print(url);
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body); // Decodificar el JSON recibido
        print('lo que recibe el service-allproductsCategorias:  $data');
        return ResponseApi.fromJson(
          data,
        ); // Devolverlo como un objeto ResponseApi
      } else {
        final error = json.decode(response.body);
        String emessage = error["message"] ?? 'error desconocido';
        print("emessage de service-allproductsCategorias: $emessage");
        return ResponseApi(message: 'Error: $emessage', success: false);
      }
    } catch (e) {
      print('e de service-allproductsCategorias: $e');
      return ResponseApi(message: 'exepction:$e', success: false);
    }
  }

  //crear producto parte1 boton enviar para recibir su data y asignarlo en los valores de los chekbox
  Future<(ResponseApi, CreateProductsModels?)> createProductSrvice({
    required File myFile,
    required String nameProduct,
    required String idCategorie,
    required String description,
  }) async {
    try {
      Uri url = _uriCreatedProduct();
      print(url);

      var request = http.MultipartRequest('POST', url);
      request.fields['nameProduct'] = nameProduct;
      request.fields['idCategorie'] = idCategorie;
      request.fields['description'] = description;

      request.files.add(
        await http.MultipartFile.fromPath('myFile', myFile.path),
      );

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 201) {
        final decoded = jsonDecode(response.body);

        final responseApi = ResponseApi.fromJson(decoded);

        final CreateProductsModels? createdProduct =
            decoded['data'] != null
                ? CreateProductsModels.fromJson(decoded['data'])
                : null;

        return (responseApi, createdProduct);
      } else {
        final error = jsonDecode(response.body);
        return (
          ResponseApi(message: 'error: ${error["message"]}', success: false),
          null,
        );
      }
    } catch (e) {
      return (ResponseApi(message: 'exception: $e', success: false), null);
    }
  }

  //enviar precios por separado
  Future<ResponseApi> addPriceProductService(
    int idProduct,
    int idTypeUser,
    double price,
    int idStatusPrice,
  ) async {
    try {
      Uri url = _buildUri("price");
      String bodyParams = json.encode({
        "idProduct": idProduct,
        "idTypeUser": idTypeUser,
        "price": price,
        "idStatusPrice": idStatusPrice,
      });
      print(url);
      print(idProduct);
      print(idTypeUser);
      print(price);
      print(idStatusPrice);
      final response = await http.post(
        url,
        headers: _headers,
        body: bodyParams,
      );
      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        return ResponseApi.fromJson(data);
      } else {
        final error = json.decode(response.body);
        String emessage = error["message"] ?? 'error desconocido';
        return ResponseApi(
          message: 'error service-precios:$emessage',
          success: false,
        );
      }
    } catch (e) {
      print('e de service-precios: $e');
      return ResponseApi(
        message: 'exepction service-precios:$e',
        success: false,
      );
    }
  }

  Future<ResponseApi> updateProductService({
    required File? myFile,
    required String idProduct,
    required String idCategorie,
    //required String nameProduct,
    required String description,
  }) async {
    try {
      Uri url = _uriUpdateProduct();
      print(url);

      var request = http.MultipartRequest('POST', url);
      //request.fields['nameProduct'] = nameProduct;
      request.fields['idProduct'] = idProduct;
      request.fields['idCategorie'] = idCategorie;
      request.fields['description'] = description;

      // Solo agregamos el archivo si no es null
      if (myFile != null) {
        request.files.add(
          await http.MultipartFile.fromPath('myFile', myFile.path),
        );
      }
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        // Si la respuesta es exitosa, simplemente devuelve un ResponseApi sin datos adicionales
        final decoded = jsonDecode(response.body);
        final responseApi = ResponseApi.fromJson(decoded);

        return responseApi;
      } else {
        // Si la respuesta es un error, devuelve un ResponseApi con el mensaje de error
        final error = jsonDecode(response.body);
        String errorMessage = error["message"] ?? 'Error desconocido';
        return ResponseApi(message: 'Error: $errorMessage', success: false);
      }
    } catch (e) {
      // En caso de excepción, maneja el error
      return ResponseApi(message: 'Exception: $e', success: false);
    }
  }
}
