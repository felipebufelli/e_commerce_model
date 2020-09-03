import 'package:e_commerce_model/common/custom_colors.dart';
import 'package:e_commerce_model/common/custom_drawer/custom_drawer.dart';
import 'package:e_commerce_model/models/home_manager.dart';
import 'package:e_commerce_model/models/user_manager.dart';
import 'package:e_commerce_model/screens/home/components/section_list.dart';
import 'package:e_commerce_model/screens/home/components/section_staggered.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  CustomColors.highHomeColor,
                  CustomColors.lowHomeColor,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                snap: true,
                floating: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
                flexibleSpace: const FlexibleSpaceBar(
                  title: Text('Loja do Felipe'),
                  centerTitle: true,
                ),
                actions: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    color: Colors.white,
                    onPressed: () => Navigator.of(context).pushNamed('/cart')
                  ),
                  Consumer2<UserManager, HomeManager>(
                    builder: (_, userManager, homeManager, __){
                      if(userManager.adminEnabled) {
                        if(homeManager.editing) {
                          return PopupMenuButton(
                            onSelected: (e) {
                              if(e == 'Salvar') {
                                homeManager.saveEditing();
                              } else {
                                homeManager.discardEditing();
                              }
                            },
                            itemBuilder: (_) {
                              return ['Salvar', 'Descartar'].map((e) {
                                return PopupMenuItem(
                                  value: e,
                                  child: Text(e),
                                );
                              }).toList();
                            }
                          );
                        } else {
                          return IconButton(
                            icon: const Icon(Icons.edit),
                            color: Colors.white,
                            onPressed: homeManager.enterEditing,
                         );
                        }
                      } else {
                        return Container();
                      }
                    }
                  ),
                ],
              ),
              Consumer<HomeManager>(builder: (_, homeManager, __) {
                final List<Widget> children = homeManager.sections.map<Widget>(
                  (section) {
                    switch (section.type) {
                      case 'List':
                        return SectionList(section);
                      case 'Staggered':
                        return SectionStaggered(section);
                      default:
                        return Container();
                    }
                  }
                ).toList();

                return SliverList(
                  delegate: SliverChildListDelegate(children)
                );
              })
            ],
          ),
        ],
      ),
    );
  }
}
