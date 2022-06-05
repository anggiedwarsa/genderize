import 'package:flutter_test/flutter_test.dart';
import 'package:genderize/core/network/network_info.dart';
import 'package:mockito/mockito.dart';

import '../../mock_helper.mocks.dart';

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
