import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:genderize/core/error/exceptions.dart';
import 'package:genderize/core/error/failures.dart';
import 'package:genderize/features/data/models/genderize/genderize_model.dart';
import 'package:genderize/features/data/repositories/genderize/genderize_repository_impl.dart';
import 'package:mockito/mockito.dart';

import '../../../../../fixtures/fixture_reader.dart';
import '../../../../../mock_helper.mocks.dart';

void main() {
  late MockNetworkInfo mockNetworkInfo;
  late MockGenderizeLocalDataSource mockGenderizeLocalDataSource;
  late MockGenderizeRemoteDataSource mockGenderizeRemoteDataSource;
  late GenderizeRepositoryImpl repositoryImpl;

  setUp(() {
    mockNetworkInfo = MockNetworkInfo();
    mockGenderizeLocalDataSource = MockGenderizeLocalDataSource();
    mockGenderizeRemoteDataSource = MockGenderizeRemoteDataSource();
    repositoryImpl = GenderizeRepositoryImpl(
        localDataSource: mockGenderizeLocalDataSource,
        remoteDataSource: mockGenderizeRemoteDataSource,
        networkInfo: mockNetworkInfo);
  });

  group('predictGender', () {
    const name = 'Rihanna';
    final genderizeModel = GenderizeModel.fromJson(
      json.decode(
        fixture('genderize.json'),
      ),
    );
    final tRequestOptions = RequestOptions(path: '');

    test(
      'pastikan data dari API bisa disimpan di lokal',
      () async {
        // arrange
        when(mockGenderizeRemoteDataSource.getPrediction(any)).thenAnswer((_) async => genderizeModel);
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(mockGenderizeLocalDataSource.cacheGender(any)).thenAnswer((_) async => true);

        // act
        final result = await repositoryImpl.getPrediction(name);

        // assert
        expect(result, Right(genderizeModel));
        verify(mockNetworkInfo.isConnected);
        verify(mockGenderizeRemoteDataSource.getPrediction(name));
        verify(mockGenderizeLocalDataSource.cacheGender(genderizeModel));
      },
    );

    test(
      'pastikan kembalikan ServerFailure ketika respon dari API gagal',
      () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(mockGenderizeRemoteDataSource.getPrediction(any)).thenThrow(
          DioError(
            requestOptions: tRequestOptions,
            error: 'testError',
            response: Response(
              requestOptions: tRequestOptions,
            ),
          ),
        );

        // act
        final result = await repositoryImpl.getPrediction(name);

        // assert
        expect(result, Left(ServerFailure()));
        verify(mockNetworkInfo.isConnected);
        verify(mockGenderizeRemoteDataSource.getPrediction(name));
      },
    );

    test(
      'pastikan kembalikan data lokal ketika tidak ada koneksi internet',
      () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
        when(mockGenderizeLocalDataSource.getPrediction()).thenAnswer((_) async => genderizeModel);

        // act
        final result = await repositoryImpl.getPrediction(name);

        // assert
        expect(result, Right(genderizeModel));
        verify(mockGenderizeLocalDataSource.getPrediction());
      },
    );

    test(
      'pastikan kembalikan CacheFailure ketika tidak ada koneksi internet dan data dari lokal tidak ada',
      () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
        when(mockGenderizeLocalDataSource.getPrediction()).thenThrow(
          CacheException(),
        );

        // act
        final result = await repositoryImpl.getPrediction(name);

        // assert
        expect(result, Left(CacheFailure()));
        verify(mockNetworkInfo.isConnected);
        verify(mockGenderizeLocalDataSource.getPrediction());
      },
    );
  });
}
