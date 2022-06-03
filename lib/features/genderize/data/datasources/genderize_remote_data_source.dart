import 'package:dio/dio.dart';
import 'package:genderize/features/genderize/data/models/genderize_model.dart';

abstract class GenderizeRemoteDataSource {
  Future<GenderizeModel>? getPrediction(String name);
}

class GenderizeRemoteDataSourceImpl implements GenderizeRemoteDataSource {
  final Dio dio;

  GenderizeRemoteDataSourceImpl({required this.dio});

  Future<GenderizeModel> _getPredcitionFromUrl(String name) async {
    final url = 'https://api.genderize.io/?name=$name';
    final response = await dio.get(url);

    if (response.statusCode == 200) {
      return GenderizeModel.fromJson(response.data);
    } else {
      throw DioError(requestOptions: response.requestOptions);
    }
  }

  @override
  Future<GenderizeModel>? getPrediction(String name) =>
      _getPredcitionFromUrl(name);
}
