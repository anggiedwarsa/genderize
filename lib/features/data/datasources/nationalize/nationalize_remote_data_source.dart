import 'package:dio/dio.dart';
import 'package:genderize/features/data/models/nationalize/nationalize_model.dart';

abstract class NationalizeRemoteDataSource {
  Future<NationalizeModel> getPredictionCountry(String name);
}

class NationalizeRemoteDataSourceImpl extends NationalizeRemoteDataSource {
  final Dio dio;

  NationalizeRemoteDataSourceImpl({
    required this.dio,
  });
  @override
  Future<NationalizeModel> getPredictionCountry(String name) async {
    const url = 'https://api.nationalize.io/';
    final response = await dio.get(
      url,
      queryParameters: {
        'name': name,
      },
    );

    if (response.statusCode.toString().startsWith('2')) {
      return NationalizeModel.fromJson(response.data);
    } else {
      throw DioError(requestOptions: response.requestOptions);
    }
  }
}
