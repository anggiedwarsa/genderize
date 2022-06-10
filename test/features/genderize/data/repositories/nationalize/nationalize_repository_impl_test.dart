import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:genderize/core/error/exceptions.dart';
import 'package:genderize/core/error/failures.dart';
import 'package:genderize/features/data/models/nationalize/nationalize_model.dart';
import 'package:genderize/features/data/repositories/nationalize/nationalize_repository_impl.dart';
import 'package:mockito/mockito.dart';

import '../../../../../fixtures/fixture_reader.dart';
import '../../../../../mock_helper.mocks.dart';

void main() {
  late MockNetworkInfo mockNetworkInfo;
  late MockNationalizeLocalDataSource mockNationalizeLocalDataSource;
  late MockNationalizeRemoteDataSource mockNationalizeRemoteDataSource;
  late NationalizeRepositoryImpl repositoryImpl;

  setUp(() {
    mockNetworkInfo = MockNetworkInfo();
    mockNationalizeLocalDataSource = MockNationalizeLocalDataSource();
    mockNationalizeRemoteDataSource = MockNationalizeRemoteDataSource();
    repositoryImpl = NationalizeRepositoryImpl(
      localDataSource: mockNationalizeLocalDataSource,
      remoteDataSource: mockNationalizeRemoteDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  group('predictCountry', () {
    const name = 'Anggi';
    final nationalizeModel = NationalizeModel.fromJson(
      json.decode(
        fixture('nationalize.json'),
      ),
    );
    final tRequestOptions = RequestOptions(path: '');

    test(
      'pastikan data dari API bisa disimpan di lokal',
      () async {
        // arrange
        when(mockNationalizeRemoteDataSource.getPredictionCountry(any)).thenAnswer((_) async => nationalizeModel);
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(mockNationalizeLocalDataSource.cacheCountry(any)).thenAnswer((_) async => true);

        // act
        final result = await repositoryImpl.getPredictionCountry(name);

        // assert
        expect(result, Right(nationalizeModel));
        verify(mockNetworkInfo.isConnected);
        verify(mockNationalizeRemoteDataSource.getPredictionCountry(name));
        verify(mockNationalizeLocalDataSource.cacheCountry(nationalizeModel));
      },
    );

    test(
      'pastikan kembalikan ServerFailure ketika respon dari API gagal',
      () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(mockNationalizeRemoteDataSource.getPredictionCountry(any)).thenThrow(
          DioError(
            requestOptions: tRequestOptions,
            error: 'testError',
            response: Response(
              requestOptions: tRequestOptions,
            ),
          ),
        );

        // act
        final result = await repositoryImpl.getPredictionCountry(name);

        // assert
        expect(result, Left(ServerFailure()));
        verify(mockNetworkInfo.isConnected);
        verify(mockNationalizeRemoteDataSource.getPredictionCountry(name));
      },
    );

    test(
      'pastikan kembalikan data lokal ketika tidak ada koneksi internet',
      () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
        when(mockNationalizeLocalDataSource.getPredictionCountry()).thenAnswer((_) async => nationalizeModel);

        // act
        final result = await repositoryImpl.getPredictionCountry(name);

        // assert
        expect(result, Right(nationalizeModel));
        verify(mockNationalizeLocalDataSource.getPredictionCountry());
      },
    );

    test(
      'pastikan kembalikan CacheFailure ketika tidak ada koneksi internet dan data dari lokal tidak ada',
      () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
        when(mockNationalizeLocalDataSource.getPredictionCountry()).thenThrow(
          CacheException(),
        );

        // act
        final result = await repositoryImpl.getPredictionCountry(name);

        // assert
        expect(result, Left(CacheFailure()));
        verify(mockNetworkInfo.isConnected);
        verify(mockNationalizeLocalDataSource.getPredictionCountry());
      },
    );
  });
}
