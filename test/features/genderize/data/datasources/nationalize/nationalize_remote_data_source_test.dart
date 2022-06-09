import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:genderize/features/data/datasources/nationalize/nationalize_remote_data_source.dart';
import 'package:genderize/features/data/models/nationalize/nationalize_model.dart';
import 'package:mockito/mockito.dart';

import '../../../../../fixtures/fixture_reader.dart';
import '../../../../../mock_helper.mocks.dart';

void main() {
  late NationalizeRemoteDataSourceImpl nationalizeRemoteDataSourceImpl;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    nationalizeRemoteDataSourceImpl =
        NationalizeRemoteDataSourceImpl(dio: mockDio);
  });

  final tRequestOptions = RequestOptions(path: '');

  group('getPredictionCountry', () {
    const tName = 'Anggi';
    const tBaseUrl = 'https://api.nationalize.io/';
    final tResponse = NationalizeModel.fromJson(
      json.decode(
        fixture('nationalize.json'),
      ),
    );

    void setUpMockDioSuccess() {
      final responsePayload = json.decode(fixture('nationalize.json'));
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
      'pastikan endpoint getPredictionCountry benar-benar terpanggil dengan method GET',
      () async {
        // arrange
        setUpMockDioSuccess();

        // act
        await nationalizeRemoteDataSourceImpl.getPredictionCountry(tName);

        // assert
        verify(mockDio.get(tBaseUrl,
            queryParameters: anyNamed('queryParameters')));
      },
    );

    test(
      'pastikan mengembalikan objek model NationalizeModel ketika menerima respon sukses dari endpoint',
      () async {
        // arrange
        setUpMockDioSuccess();

        // act
        final result =
            await nationalizeRemoteDataSourceImpl.getPredictionCountry(tName);

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
        final call =
            nationalizeRemoteDataSourceImpl.getPredictionCountry(tName);

        // assert
        expect(() => call, throwsA(const TypeMatcher<DioError>()));
      },
    );
  });
}
