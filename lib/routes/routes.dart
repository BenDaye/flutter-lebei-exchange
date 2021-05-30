part of 'pages.dart';

abstract class Routes {
  static const INITIAL = '/';
  static const EXCHANGES = '/exchanges';
  static const SETTINGS = '/settings';
  static const SETTINGS_GENERAL = '/general';
  static const SETTINGS_GENERAL_LANGUAGE = '/language';
  static const SETTINGS_GENERAL_CURRENCY = '/currency';
  static const MARKET = '/market/:symbol';
}
