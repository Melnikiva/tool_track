import 'package:flutter/material.dart';
import 'package:tool_track/account_manager.dart';
import 'package:tool_track/constants.dart';
import 'package:tool_track/pages.dart';
import 'package:tool_track/screens/login_screen.dart';

class NavBar extends StatefulWidget {
  final AccountManager accountManager = AccountManager();
  Pages currentPage;

  void changeCurrentPage(Pages newPage) {
    currentPage = newPage;
  }

  NavBar({required this.currentPage});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  bool isSelected(Pages page) {
    return page == widget.currentPage;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              widget.accountManager.getFullName(),
            ),
            accountEmail: Text(
              widget.accountManager.getEmail(),
            ),
            currentAccountPicture: Icon(
              kMainIcon,
              size: 60.0,
              color: Colors.white,
            ),
          ),
          DrawerListItem(
            title: 'Account',
            icon: Icons.account_circle_rounded,
            pageRoute: Pages.account,
            selected: isSelected(Pages.account),
            onTap: () {
              setState(() {
                widget.changeCurrentPage(Pages.account);
              });
            },
          ),
          DrawerListItem(
            title: 'Assets',
            icon: Icons.handyman_rounded,
            pageRoute: Pages.assets,
            selected: isSelected(Pages.assets),
            onTap: () {
              setState(() {
                widget.changeCurrentPage(Pages.assets);
              });
            },
          ),
          DrawerListItem(
            title: 'Settings',
            icon: Icons.settings,
            pageRoute: Pages.settings,
            selected: isSelected(Pages.settings),
            onTap: () {
              setState(() {
                widget.changeCurrentPage(Pages.settings);
              });
            },
          ),
          DrawerListItem(
            title: 'Info',
            icon: Icons.info,
            pageRoute: Pages.info,
            selected: isSelected(Pages.info),
            onTap: () {
              setState(() {
                widget.changeCurrentPage(Pages.info);
              });
            },
          ),
          Expanded(
            child: Container(),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: ListTile(
              leading: Icon(Icons.logout),
              title: Text('Log Out'),
              onTap: () {
                widget.accountManager.signOut();
                Navigator.popUntil(
                  context,
                  ModalRoute.withName(LoginScreen.route),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class DrawerListItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function onTap;
  final Pages pageRoute;
  final bool selected;

  DrawerListItem({
    required this.title,
    required this.icon,
    required this.onTap,
    required this.pageRoute,
    this.selected = false,
  });

  void goToPage(BuildContext context) {
    Navigator.pushReplacementNamed(context, pageRoutes[pageRoute]!);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      selected: this.selected,
      leading: Icon(this.icon),
      title: Text(this.title),
      onTap: () {
        this.onTap();
        goToPage(context);
      },
    );
  }
}
