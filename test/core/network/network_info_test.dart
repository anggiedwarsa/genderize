import 'package:flutter_test/flutter_test.dart';
import 'package:genderize/core/network/network_info.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'network_info_test.mocks.dart';

@GenerateMocks([InternetConnectionChecker])
void main() {
  late NetworkInfoImpl networkInfo;
  late MockInternetConnectionChecker mockInternetConnectionChecker;

  setUp(() {
    mockInternetConnectionChecker = MockInternetConnectionChecker();
    networkInfo = NetworkInfoImpl(mockInternetConnectionChecker);
  });

  group('isConnected', () {
    test('forward call ke InternetConnectionChecker.gasConnection', () async {
      // arrange
      final hasConnectionFuture = Future.value(true);
      when(mockInternetConnectionChecker.hasConnection)
          .thenAnswer((_) => hasConnectionFuture);

      // act
      final result = networkInfo.isConnected;

      //assert
      verify(mockInternetConnectionChecker.hasConnection);
      expect(result, hasConnectionFuture);
    });
  });
}
