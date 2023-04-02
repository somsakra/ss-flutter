import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:my_first_app/src/models/posts.dart';
import 'package:my_first_app/src/models/product.dart';
import 'package:my_first_app/src/constants/api.dart';

class NetworkService {
  NetworkService._internal();

  static final NetworkService _instance = NetworkService._internal();

  factory NetworkService() => _instance;

  static final _dio = Dio();

  Future<List<Product>> getAllProduct() async {
    const url ='${API.BASE_URL}${API.PRODUCT}';
    final Response response = await _dio.get(url);
    if (response.statusCode == 200) {
      return productFromJson(jsonEncode(response.data));
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
