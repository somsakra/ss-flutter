import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_first_app/src/constants/setting.dart';
import 'package:my_first_app/src/view-models/menu_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_first_app/src/config/route.dart' as custom_route;

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          _buildProfile(),
          ..._buildMainMenu(), //spread operator
          const Spacer(),
          ListTile(
            leading: const FaIcon(
              FontAwesomeIcons.rightFromBracket,
              color: Colors.grey,
            ),
            title: const Text(
              'Logout',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
            ),
            onTap: showDialogLogout,
          ),
        ],
      ),
    );
  }

  void showDialogLogout() {
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      // false = user must tap button, true = tap outside dialog
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          content: const Text('Logout ?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Dismiss alert dialog
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.redAccent, // Text Color
              ),
              child: const Text('Logout'),
              onPressed: () {
                SharedPreferences.getInstance().then((prefs) {
                  prefs.remove(Setting.TOKEN_PREF);
                  Navigator.of(dialogContext).pop(); // Dismiss alert dialog
                  Navigator.pushNamedAndRemoveUntil(
                      context, custom_route.Route.login, (route) => false);
                });
              },
            ),
          ],
        );
      },
    );
  }

  UserAccountsDrawerHeader _buildProfile() => const UserAccountsDrawerHeader(
        accountName: Text('Somsak'),
        accountEmail: Text('somsakra@live.com'),
        currentAccountPicture: CircleAvatar(
          backgroundImage: NetworkImage(
            'https://png.pngtree.com/png-clipart/20190924/original/pngtree-human-avatar-free-vector-png-image_4825373.jpg',
          ),
        ),
      );

  List<ListTile> _buildMainMenu() => MenuViewModel()
      .items
      .map(
        (item) => ListTile(
          title: Text(
            item.title,
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
          ),
          leading: Badge(
            showBadge: item.icon == FontAwesomeIcons.inbox,
            badgeContent: const Text('3',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                )),
            badgeStyle: const BadgeStyle(badgeColor: Colors.red),
            child: FaIcon(item.icon, color: item.iconColor),
          ),
          onTap: () => item.onTap!(context),
        ),
      )
      .toList();
}
