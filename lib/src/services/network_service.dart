import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:my_first_app/src/models/posts.dart';
import 'package:my_first_app/src/models/product.dart';
import 'package:my_first_app/src/constants/api.dart';
import 'package:http_parser/http_parser.dart';

class NetworkService {
  NetworkService._internal();

  static final NetworkService _instance = NetworkService._internal();

  factory NetworkService() => _instance;

  static final _dio = Dio();

  Future<List<Product>> getAllProduct() async {
    const url = '${API.BASE_URL}${API.PRODUCT}';
    final Response response = await _dio.get(url);
    if (response.statusCode == 200) {
      return productFromJson(jsonEncode(response.data));
    }
    throw Exception('Network Fail');
  }

  Future<String> addProduct(Product product, {File? imageFile}) async {
    const url = '${API.BASE_URL}${API.PRODUCT}';
    FormData data = FormData.fromMap({
      'name': product.name,
      'price': product.price,
      'stock': product.stock,
      if (imageFile != null)
        'photo': await MultipartFile.fromFile(imageFile.path,
            contentType: MediaType('image', 'jpg'))
    });
    final Response response = await _dio.post(url, data: data);
    if (response.statusCode == 201) {
      return 'Add Successfully';
    }
    throw Exception('Network Fail');
  }

  Future<String> editProduct(Product product, {File? imageFile}) async {
    final url = '${API.BASE_URL}${API.PRODUCT}/${product.id}';
    FormData data = FormData.fromMap({
      'name': product.name,
      'price': product.price,
      'stock': product.stock,
      if (imageFile != null)
        'photo': await MultipartFile.fromFile(imageFile.path,
            contentType: MediaType('image', 'jpg'))
    });
    final Response response = await _dio.put(url, data: data);
    if (response.statusCode == 200) {
      return 'Edit Successfully';
    }
    throw Exception('Network Fail');
  }

  Future<String> deleteProduct(int productId) async {
    final url = '${API.BASE_URL}${API.PRODUCT}/$productId';
    final Response response = await _dio.delete(url);
    if (response.statusCode == 204) {
      return 'Delete Successfully';
    }
    throw Exception('Network Fail');
  }

  Future<List<Post>> fetchPost(int startIndex, {int limit = 5}) async {
    final url =
        'https://jsonplaceholder.typicode.com/posts?_start=$startIndex&_limit=$limit';
    final Response response = await _dio.get(url);
    if (response.statusCode == 200) {
      return postFromJson(jsonEncode(response.data));
    }
    throw Exception('Network Fail');
  }
}
