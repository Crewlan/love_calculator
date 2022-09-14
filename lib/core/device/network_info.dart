import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:love_calculator/core/device/i_network_info.dart';

class NetworkInfo extends INetworkInfo {
  final Connectivity connectivity;

  NetworkInfo(this.connectivity);

  @override
  Future<bool> get isConnected async {
    final status = await connectivity.checkConnectivity();
    return status != ConnectivityResult.none && status != ConnectivityResult.bluetooth;
  }
}
