import 'package:internet_connection_checker/internet_connection_checker.dart';


abstract class NetworkInfo{
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final InternetConnectionChecker connectionChecker;
  bool? _lastConnectionStatus;
  DateTime? _lastCheckTime;
  // Cache connectivity result for 3 seconds to avoid frequent checks
  static const _cacheTime = Duration(seconds: 3);

  NetworkInfoImpl({required this.connectionChecker}) {
    // Listen to connectivity changes
    connectionChecker.onStatusChange.listen((status) {
      _lastConnectionStatus = status == InternetConnectionStatus.connected;
      _lastCheckTime = DateTime.now();

      print("Status changed: $_lastConnectionStatus");
    });
  }
  @override
  Future<bool> get isConnected async {
    // Use cached result if available and not expired
    if (_lastConnectionStatus != null && _lastCheckTime != null) {
      final timeElapsed = DateTime.now().difference(_lastCheckTime!);
      if (timeElapsed < _cacheTime) {
        return _lastConnectionStatus!;
      }
    }

    // Delay before checking connection (e.g., 500ms)
    await Future.delayed(const Duration(milliseconds: 500));

    // Otherwise check connection and cache result
    final isConnected = await connectionChecker.hasConnection;
    _lastConnectionStatus = isConnected;
    _lastCheckTime = DateTime.now();

    print("Fresh check result (after delay): $isConnected");

    return isConnected;
  }

}
