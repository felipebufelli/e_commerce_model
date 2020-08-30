import 'package:e_commerce_model/common/custom_colors.dart';
import 'package:e_commerce_model/common/custom_drawer/custom_drawer_header.dart';
import 'package:e_commerce_model/common/custom_drawer/drawer_tile.dart';
import 'package:e_commerce_model/models/user_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.horizontal(right: Radius.circular(50)),
      child: Drawer(
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  CustomColors.highDrawerColor,
                  CustomColors.lowDrawerColor,
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
              ),
            ),
            ListView(
              scrollDirection: Axis.vertical,
              children: <Widget>[
                CustomDrawerHeader(),
                const Divider(),
                const DrawerTile(
                  iconData: Icons.home,
                  title: "Início",
                  page: 0,
                ),
                const DrawerTile(
                  iconData: Icons.list,
                  title: "Produtos",
                  page: 1,
                ),
                const DrawerTile(
                  iconData: Icons.playlist_add_check,
                  title: "Meus Pedidos",
                  page: 2,
                ),
                const DrawerTile(
                  iconData: Icons.location_on,
                  title: "Lojas",
                  page: 3,
                ),
                Consumer<UserManager>(builder: (_, userManager, __) {
                  if (userManager.adminEnabled) {
                    return Column(
                      children: const <Widget>[
                        Divider(),
                        DrawerTile(
                          iconData: Icons.settings,
                          title: "Usuários",
                          page: 4,
                        ),
                        DrawerTile(
                          iconData: Icons.settings,
                          title: "Pedidos",
                          page: 5,
                        ),
                      ],
                    );
                  } else {
                    return Container(
                      height: 0.0,
                    );
                  }
                })
              ],
            ),
          ],
        ),
      ),
    );
  }
}
