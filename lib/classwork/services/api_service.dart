import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://api.escuelajs.co/api/v1'));

  Future<Response> getProducts() async {
    try {
      return await _dio.get('/products');
    } catch (e) {
      _handleDioError(e);
      throw Exception('Failed to load products');
    }
  }

  Future<Response> createProduct(Map<String, dynamic> product) async {
    try {
      return await _dio.post('/products', data: product);
    } catch (e) {
      _handleDioError(e);
      throw Exception('Failed to create product');
    }
  }

  Future<Response> updateProduct(int id, Map<String, dynamic> product) async {
    try {
      return await _dio.put('/products/$id', data: product);
    } catch (e) {
      _handleDioError(e);
      throw Exception('Failed to update product');
    }
  }

  Future<Response> deleteProduct(int id) async {
    try {
      return await _dio.delete('/products/$id');
    } catch (e) {
      _handleDioError(e);
      throw Exception('Failed to delete product');
    }
  }

  Future<Response> uploadImage(String path) async {
    try {
      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(path, filename: 'upload.jpg'),
      });
      return await _dio.post('/upload', data: formData);
    } catch (e) {
      _handleDioError(e);
      throw Exception('Failed to upload image');
    }
  }

  void _handleDioError(dynamic e) {
    if (e is DioError) {
      // Handle DioError specifically
      if (e.response != null) {
        print('DioError: ${e.response!.data}');
        print('DioError: ${e.response!.headers}');
        print('DioError: ${e.response!.requestOptions}');
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print('DioError: ${e.message}');
      }
    } else {
      // Handle any other types of error
      print('Unexpected error: $e');
    }
  }
}
