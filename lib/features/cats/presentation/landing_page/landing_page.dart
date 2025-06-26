import 'dart:io';

import 'package:catbreeds/core/responsive/responsive.dart';
import 'package:catbreeds/features/cats/domain/entities/cat.dart';
import 'package:catbreeds/features/cats/presentation/landing_page/widgets/custom_cat_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    return Platform.isIOS
        ? const CupertinoPageScaffold(
            child: Text('Landing Page'),
          )
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: const Text('Catbreeds'),
              centerTitle: true,
              backgroundColor: Colors.white,
              shadowColor: Colors.transparent,
              surfaceTintColor: Colors.transparent,
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(responsive.hp(15)),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: responsive.wp(20),
                    vertical: responsive.hp(5),
                  ),
                  child: SearchBar(
                      elevation: WidgetStateProperty.resolveWith(
                        (_) {
                          return 5;
                        },
                      ),
                      shape: WidgetStateProperty.resolveWith(
                        (_) {
                          return RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          );
                        },
                      ),
                      backgroundColor: WidgetStateProperty.resolveWith(
                        (_) {
                          return Colors.grey.shade50;
                        },
                      ),
                      trailing: [Icon(Icons.search)]),
                ),
              ),
            ),
            body: SafeArea(child: _CardsList()),
          );
  }
}

class _CardsList extends StatelessWidget {
  _CardsList();

  List<Cat> catsList = [
    Cat(
      id: 'id',
      name: 'Cat name',
      temperament: 'temperament',
      origin: 'Colombia',
      description:
          'Lorem Duis enim adipisicing enim mollit anim consequat incididunt non.',
      lifeSpan: 'lifeSpan',
      adaptability: 5,
      intelligence: 5,
      weight: Weight(imperial: '10', metric: '6'),
      image: CatImage(
          id: 'id',
          width: 100,
          height: 100,
          url:
              'https://media.istockphoto.com/id/1443562748/photo/cute-ginger-cat.jpg?s=612x612&w=0&k=20&c=vvM97wWz-hMj7DLzfpYRmY2VswTqcFEKkC437hxm3Cg='),
    )
  ];

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    return GridView.builder(
      itemCount: 5,
      padding: EdgeInsets.symmetric(
          horizontal: responsive.wp(8), vertical: responsive.hp(2)),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: responsive.isTablet() ? 2 : 1,
        mainAxisSpacing:
            responsive.isTablet() ? responsive.hp(5) : responsive.hp(8),
        crossAxisSpacing:
            responsive.isTablet() ? responsive.hp(5) : responsive.hp(8),
        childAspectRatio: responsive.isTablet() ? 4 / 5 : 2 / 3,
      ),
      itemBuilder: (context, index) {
        return CustomCatCard(cat: catsList[0]);
      },
    );
  }
}
