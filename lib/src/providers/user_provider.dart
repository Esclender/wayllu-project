import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // Importa la librería para trabajar con JSON

Future<dynamic> fetchData() async {
  try {
    Dio dio = Dio();

    Response response =
        await dio.get('http://localhost:5036/api/artesanos');

    if (response.statusCode == 200) {
      dynamic getName = response.data['NOMBRE_COMPLETO'] ?? '';
      String name = getName as String;
      return name;
    } else {
      // Si la solicitud falla, lanza una excepción
      throw Exception('Failed to load data');
    }
  } catch (e) {
    throw Exception('Error: $e');
  }
}
