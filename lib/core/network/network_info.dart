import 'package:data_connection_checker/data_connection_checker.dart';

// WHY A SEPARATE CLASS FOR A SINGLE CALL?

// We had to wrap this lonely call with a separate class
// because if we decided to change this 3rd party lib data_connection_checker
// to sth else AND we called "has connection" multiple times in
// our complex repository class we would be really troubled
// by the necessity to rewrite a lot of production code
// and to run all tests again.

// So we need one point for connection checking


abstract class NetworkInfo{
  Future<bool> get isConnected;

}


class NetworkInfoImpl implements NetworkInfo{
  NetworkInfoImpl(this.connectionChecker);

  final DataConnectionChecker connectionChecker;

  @override
  Future<bool> get isConnected  =>
    connectionChecker.hasConnection;

}