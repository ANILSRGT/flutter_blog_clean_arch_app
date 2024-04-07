import 'package:flutter_blog_clean_arch_app/core/network/internet_connection/iconnection_checker.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

final class ConnectionChecker implements IConnectionChecker {
  ConnectionChecker({required this.internetConnection});

  final InternetConnection internetConnection;

  @override
  Future<bool> get hasConnection => internetConnection.hasInternetAccess;
}
