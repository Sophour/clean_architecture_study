import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:tddcleanarchitecturecourse/core/network/network_info.dart';

class MockDataConnectionChecker extends Mock
implements DataConnectionChecker{}

void main(){
  NetworkInfoImpl networkInfo;
  MockDataConnectionChecker mockDataConnectionChecker;
// integrately connection test
  // forth integrately connection test
  setUp((){
    mockDataConnectionChecker = MockDataConnectionChecker();
    networkInfo = NetworkInfoImpl(mockDataConnectionChecker);
  });

  group('is connected', (){
    test(
        'should forward the call to DataConnectorChecker.hasConnection', ()
    async
    {
      final tHasConnectionFuture = Future.value(true);

      // arrange
      when(mockDataConnectionChecker.hasConnection)
          .thenAnswer((_) => tHasConnectionFuture);
      // act
      final result = networkInfo.isConnected;
      // assert
      verify(mockDataConnectionChecker.hasConnection);
      expect(result, tHasConnectionFuture);
    });
      });

}
