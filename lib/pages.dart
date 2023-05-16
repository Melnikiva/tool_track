import 'package:tool_track/screens/login_screen.dart';
import 'package:tool_track/screens/assets_screen.dart';
import 'package:tool_track/screens/account_screen.dart';
import 'package:tool_track/screens/settings_screen.dart';
import 'package:tool_track/screens/info_screen.dart';

enum Pages {
  login,
  account,
  assets,
  settings,
  info,
}

Map<Pages, String> pageRoutes = {
  Pages.login: LoginScreen.route,
  Pages.assets: AssetsScreen.route,
  Pages.account: AccountScreen.route,
  Pages.settings: SettingsScreen.route,
  Pages.info: InfoScreen.route,
};
