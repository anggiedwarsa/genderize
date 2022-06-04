import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:genderize/core/error/exceptions.dart';
import 'package:genderize/core/error/failures.dart';
import 'package:genderize/core/network/network_info.dart';
import 'package:genderize/features/genderize/data/datasources/genderize_local_data_source.dart';
import 'package:genderize/features/genderize/data/datasources/genderize_remote_data_source.dart';
import 'package:genderize/features/genderize/data/models/genderize_model.dart';
import 'package:genderize/features/genderize/data/repositories/genderize_repository_impl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'genderize_repository_impl_test.mocks.dart';

class MockGenderizeLocalDataSource extends Mock
    implements GenderizeLocalDataSource {}

@GenerateMocks([NetworkInfo])
@GenerateMocks([
  GenderizeRemoteDataSource
], customMocks: [
  MockSpec<GenderizeRemoteDataSource>(
      as: #MockGenderizeRemoteDataSourceForTest, returnNullOnMissingStub: true),
])
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

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      body();
    });
  }

  group('predictGender', () {
    final name = 'Rihanna';
    final genderizeModel = GenderizeModel(name: name, gender: 'female');

    test('periksa apakah perangkat sedang online', () async {
      // arrange
      when(mockGenderizeRemoteDataSource.getPrediction(any))
          .thenAnswer((_) async => genderizeModel);
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      // act
      repositoryImpl.getPrediction(name);

      // assert
      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      test('harus mengembalikan data ketika berhasil koneksi ke server',
          () async {
        // arrange
        when(mockGenderizeRemoteDataSource.getPrediction(any))
            .thenAnswer((_) async => genderizeModel);

        // act
        final result = await repositoryImpl.getPrediction(name);

        // assert
        verify(mockGenderizeRemoteDataSource.getPrediction(name));
        expect(result, equals(Right(genderizeModel)));
      });

      test('harus menyimpan data setelah menerima data dari server', () async {
        // arrange
        when(mockGenderizeRemoteDataSource.getPrediction(any))
            .thenAnswer((_) async => genderizeModel);

        // act
        await repositoryImpl.getPrediction(name);

        // assert
        verify(mockGenderizeRemoteDataSource.getPrediction(name));
        verify(mockGenderizeLocalDataSource.cacheGender(genderizeModel));
      });

      test('harus return serverfailure ketika koneksi ke server berhasil',
          () async {
        //arrange
        when(mockGenderizeRemoteDataSource.getPrediction(any))
            .thenThrow(ServerException());
        //act
        final result = await repositoryImpl.getPrediction(name);
        //assert
        verify(mockGenderizeRemoteDataSource.getPrediction(name));
        verifyZeroInteractions(mockGenderizeLocalDataSource);
        expect(result, equals(Left(ServerFailure())));
      });
    });

    runTestsOffline(() {
      test('harus return data pada sharedpreference', () async {
        //arrange
        when(mockGenderizeLocalDataSource.getPrediction())
            .thenAnswer((_) async => genderizeModel);
        //act
        final result = await repositoryImpl.getPrediction(name);
        //assert
        verifyZeroInteractions(mockGenderizeRemoteDataSource);
        verify(mockGenderizeLocalDataSource.getPrediction());
        expect(result, equals(Right(genderizeModel)));
      });
    });
  });
}
