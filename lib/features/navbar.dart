import 'package:flutter/material.dart';
import 'package:tool_track/account_manager.dart';
import 'package:tool_track/pages.dart';

class NavBar extends StatelessWidget {
  final AccountManager accountManager = AccountManager();
  Pages currentPage;

  void changeCurrentPage(Pages newPage) {
    currentPage = newPage;
  }

  NavBar({required this.currentPage});

  bool isSelected(Pages page) {
    return page == currentPage;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              accountManager.getName(),
            ),
            accountEmail: Text(
              accountManager.getEmail(),
            ),
            currentAccountPicture: Icon(
              Icons.handyman_rounded,
              size: 60.0,
            ),
          ),
          DrawerListItem(
            title: 'Account',
            icon: Icons.account_circle_rounded,
            pageLink: Pages.account,
            selected: isSelected(Pages.account),
          ),
          DrawerListItem(
            title: 'Assets',
            icon: Icons.handyman_rounded,
            pageLink: Pages.assets,
            selected: isSelected(Pages.assets),
          ),
          DrawerListItem(
            title: 'Settings',
            icon: Icons.settings,
            pageLink: Pages.settings,
            selected: isSelected(Pages.settings),
          ),
          DrawerListItem(
            title: 'Info',
            icon: Icons.info,
            pageLink: Pages.info,
            selected: isSelected(Pages.info),
          ),
        ],
      ),
    );
  }
}

class DrawerListItem extends StatelessWidget {
  final String title;
  final IconData icon;

  final Pages pageLink;
  bool selected;

  DrawerListItem({
    required this.title,
    required this.icon,
    required this.pageLink,
    this.selected = false,
  });

  void closeDrawer(context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      selected: this.selected,
      leading: Icon(this.icon),
      title: Text(this.title),
      onTap: () {
        Navigator.pushNamed(context, pageRoutes[pageLink]!);
        closeDrawer(context);
      },
    );
  }
}
