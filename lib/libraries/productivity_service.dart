import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../models/productivity_sample_model.dart';

@injectable
class ProductivityService {
  final Dio _dio;

  static const _baseUrl = 'https://garments-worker-productivity-model.onrender.com';

  ProductivityService() : _dio = Dio() {
    _dio.options.baseUrl = _baseUrl;
    _dio.options.headers = {
      'Content-Type': 'application/json',
    };

    debugPrint("ProductivityService initialized. Base URL: $_baseUrl");
  }

  Future<int> fetchProductivity(ProductivitySample sample) async {
    try {
      // Send POST request with the sample data
      final response = await _dio.post(
        '/predict',
        data: sample.toMap(),
      );

      debugPrint('✅ [fetchProductivity] - Response received. Status Code: ${response.statusCode}');
      debugPrint('📝 [fetchProductivity] - Raw Response Data: ${response.data}');

      if (response.statusCode != 200) {
        throw Exception('Failed to fetch prediction. Status code: ${response.statusCode}');
      }

      final prediction = response.data['prediction'] as int;
      debugPrint('📊 [fetchProductivity] - Prediction: $prediction');
      return prediction;
    } on DioException catch (e) {
      debugPrint('❗ [fetchProductivity] - DioException: ${e.message}');
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      debugPrint('❗ [fetchProductivity] - Unexpected error: $e');
      throw Exception('Unexpected error: $e');
    } finally {
      debugPrint('🔚 [fetchProductivity] - Method execution completed');
    }
  }
}
