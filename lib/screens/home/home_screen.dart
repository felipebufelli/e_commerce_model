import 'package:e_commerce_model/common/custom_drawer/custom_drawer.dart';
import 'package:e_commerce_model/models/home_manager.dart';
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
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 211, 118, 130),
                  Color.fromARGB(255, 253, 181, 168),
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
                      onPressed: () => Navigator.of(context).pushNamed('/cart'))
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
