
const appEnv = String.fromEnvironment('ENV', defaultValue: 'dev');

final appConfig = {};


extension AppEnv on String {
  bool get isDevelopment => this == 'dev';
  bool get isProduction => this == 'prod';
}