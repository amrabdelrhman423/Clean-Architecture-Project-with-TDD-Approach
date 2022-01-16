import 'package:data_connection_checker/data_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImp implements NetworkInfo{
  final DataConnectionChecker connectionChecker;

  NetworkInfoImp(this.connectionChecker);

  @override
  Future<bool> get isConnected async=>await connectionChecker.hasConnection ;

}