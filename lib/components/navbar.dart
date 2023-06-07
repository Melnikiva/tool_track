import 'package:flutter/material.dart';
import 'package:tool_track/managers/account_manager.dart';
import 'package:tool_track/constants.dart';
import 'package:tool_track/pages.dart';
import 'package:tool_track/screens/login/login_screen.dart';

class NavBar extends StatefulWidget {
  final AccountManager accountManager = AccountManager();
  final Pages initialPage;

  NavBar({required this.initialPage});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  late Pages currentPage;

  void changeCurrentPage(Pages newPage) {
    setState(() {
      currentPage = newPage;
    });
  }

  bool isSelected(Pages page) {
    return page == currentPage;
  }

  @override
  void initState() {
    super.initState();

    currentPage = widget.initialPage;
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
          // DrawerListItem(
          //   title: 'Account',
          //   icon: Icons.account_circle_rounded,
          //   pageRoute: Pages.account,
          //   selected: isSelected(Pages.account),
          //   onTap: () {
          //     changeCurrentPage(Pages.account);
          //   },
          // ),
          DrawerListItem(
            title: 'Assets',
            icon: Icons.handyman_rounded,
            pageRoute: Pages.assets,
            selected: isSelected(Pages.assets),
            onTap: () {
              setState(() {
                changeCurrentPage(Pages.assets);
              });
            },
          ),
          DrawerListItem(
            title: 'History',
            icon: Icons.history,
            pageRoute: Pages.history,
            selected: isSelected(Pages.history),
            onTap: () {
              setState(() {
                changeCurrentPage(Pages.history);
              });
            },
          ),
          DrawerListItem(
            title: 'Groups',
            icon: Icons.group,
            pageRoute: Pages.groups,
            selected: isSelected(Pages.groups),
            onTap: () {
              setState(() {
                changeCurrentPage(Pages.groups);
              });
            },
          ),
          // DrawerListItem(
          //   title: 'Settings',
          //   icon: Icons.settings,
          //   pageRoute: Pages.settings,
          //   selected: isSelected(Pages.settings),
          //   onTap: () {
          //     setState(() {
          //       changeCurrentPage(Pages.settings);
          //     });
          //   },
          // ),
          DrawerListItem(
            title: 'Info',
            icon: Icons.info,
            pageRoute: Pages.info,
            selected: isSelected(Pages.info),
            onTap: () {
              setState(() {
                changeCurrentPage(Pages.info);
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
              selected: false,
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
    Navigator.pop(context);
    Navigator.pushNamed(context, pageRoutes[pageRoute]!);
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
