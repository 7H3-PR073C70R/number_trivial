import 'package:flutter_clean_architecture_tdd/core/network/network_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helper/mockito_helper.mocks.dart';

void main() {
  late NetworkInfoImpl networkInfoImpl;
  late MockInternetConnectionChecker connectionChecker;

  setUp(() {
    connectionChecker = MockInternetConnectionChecker();
    networkInfoImpl = NetworkInfoImpl(connectionChecker);
  });

  group('isConnect', () {
    test('should forward the call to DataConnection.hasConnection', () async {
      // arrange
      final tHasConnectionFuture = Future.value(true);
      when(connectionChecker.hasConnection).thenAnswer((_) async => tHasConnectionFuture);
      // act
      final result = networkInfoImpl.isConnected;
      // assert
      verify(connectionChecker.hasConnection);
    });
   });
}