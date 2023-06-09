import 'package:tool_track/screens/groups/groups_screen.dart';
import 'package:tool_track/screens/history/history_screen.dart';
import 'package:tool_track/screens/login/login_screen.dart';
import 'package:tool_track/screens/assets/assets_screen.dart';
import 'package:tool_track/screens/account_screen.dart';
import 'package:tool_track/screens/login/registration_screen.dart';
import 'package:tool_track/screens/settings_screen.dart';
import 'package:tool_track/screens/info/info_screen.dart';

enum Pages {
  registration,
  login,
  account,
  assets,
  settings,
  info,
  history,
  groups,
}

Map<Pages, String> pageRoutes = {
  Pages.registration: RegistrationScreen.route,
  Pages.login: LoginScreen.route,
  Pages.assets: AssetsScreen.route,
  Pages.account: AccountScreen.route,
  Pages.settings: SettingsScreen.route,
  Pages.info: InfoScreen.route,
  Pages.history: HistoryScreen.route,
  Pages.groups: GroupsScreen.route,
};
