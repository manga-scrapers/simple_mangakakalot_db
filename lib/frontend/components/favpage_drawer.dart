import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:package_info/package_info.dart';
import 'package:sample_mangakakalot_db/frontend/screens/settings_page.dart';
import 'package:sample_mangakakalot_db/names_constant.dart' as R;

class FavPageDrawerMenu extends StatelessWidget {
  const FavPageDrawerMenu({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(R.icon_location),
            ),
          ),
          child: Container(),
        ),
        FutureBuilder<PackageInfo>(
            future: PackageInfo.fromPlatform(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var packageInfo = snapshot.data;
                return AboutListTile(
                  icon: FaIcon(FontAwesomeIcons.questionCircle),
                  child: AutoSizeText(
                    "About",
                    minFontSize: 16.0,
                  ),
                  applicationIcon: Image.asset(
                    R.icon_location,
                    width: IconTheme.of(context).size,
                    height: IconTheme.of(context).size,
                  ),
                  applicationVersion: packageInfo.version,
                  applicationName: packageInfo.appName,
                  applicationLegalese: " \xA9 by p2kr ",
                );
              } else {
                return Container();
              }
            }),
        ListTile(
          leading: FaIcon(FontAwesomeIcons.cog),
          title: AutoSizeText(
            'Settings',
            minFontSize: 16.0,
          ),
          onTap: () async {
            // Update the state of the app.
            // ...

            await Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => SettingsPage(),
              ),
            );
          },
        ),
      ],
    );
  }
}
