import 'package:dio/dio.dart';
import 'package:genderize/features/genderize/data/models/genderize_model.dart';

abstract class GenderizeRemoteDataSource {
  Future<GenderizeModel> getPrediction(String name);
}

class GenderizeRemoteDataSourceImpl implements GenderizeRemoteDataSource {
  final Dio dio;

  GenderizeRemoteDataSourceImpl({required this.dio});

  @override
  Future<GenderizeModel> getPrediction(String name) async {
    const url = 'https://api.genderize.io/';
    final response = await dio.get(
      url,
      queryParameters: {
        'name': name,
      },
    );

    if (response.statusCode.toString().startsWith('2')) {
      return GenderizeModel.fromJson(response.data);
    } else {
      throw DioError(requestOptions: response.requestOptions);
    }
  }
}
