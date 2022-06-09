import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:genderize/features/data/datasources/genderize/genderize_remote_data_source.dart';
import 'package:genderize/features/data/models/genderize/genderize_model.dart';
import 'package:mockito/mockito.dart';

import '../../../../../fixtures/fixture_reader.dart';
import '../../../../../mock_helper.mocks.dart';

void main() {
  late GenderizeRemoteDataSourceImpl remoteDataSource;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    remoteDataSource = GenderizeRemoteDataSourceImpl(dio: mockDio);
  });

  final tRequestOptions = RequestOptions(path: '');

  group('getPrediction', () {
    const tName = 'Rihanna';
    const tBaseUrl = 'https://api.genderize.io/';
    final tResponse = GenderizeModel.fromJson(
      json.decode(
        fixture('genderize.json'),
      ),
    );

    void setUpMockDioSuccess() {
      final responsePayload = json.decode(fixture('genderize.json'));
      final response = Response(
        requestOptions: tRequestOptions,
        data: responsePayload,
        statusCode: 200,
        headers: Headers.fromMap({
          Headers.contentTypeHeader: [Headers.jsonContentType],
        }),
      );
      when(mockDio.get(any, queryParameters: anyNamed('queryParameters')))
          .thenAnswer((_) async => response);
    }

    test(
      'pastikan endpoint getPrediction benar-benar terpanggil dengan method GET',
      () async {
        // arrange
        setUpMockDioSuccess();

        // act
        await remoteDataSource.getPrediction(tName);

        // assert
        verify(mockDio.get(tBaseUrl,
            queryParameters: anyNamed('queryParameters')));
      },
    );

    test(
      'pastikan mengembalikan objek model GenderizeModel ketika menerima respon sukses dari endpoint',
      () async {
        // arrange
        setUpMockDioSuccess();

        // act
        final result = await remoteDataSource.getPrediction(tName);

        // assert
        expect(result, tResponse);
      },
    );

    test(
      'pastikan akan menerima exception DioError ketika menerima respon kegagalan dari endpoint',
      () async {
        // arrange
        final response = Response(
          requestOptions: tRequestOptions,
          data: 'Bad Request',
          statusCode: 400,
        );
        when(mockDio.get(any, queryParameters: anyNamed('queryParameters')))
            .thenAnswer((_) async => response);

        // act
        final call = remoteDataSource.getPrediction(tName);

        // assert
        expect(() => call, throwsA(const TypeMatcher<DioError>()));
      },
    );
  });
}
