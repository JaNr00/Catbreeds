import 'dart:io';

import 'package:catbreeds/features/cats/domain/entities/cat.dart';
import 'package:catbreeds/features/cats/presentation/landing_page/widgets/custom_cat_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                preferredSize: Size.fromHeight(50),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
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
      origin: 'Colombian',
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
    return ListView.separated(
      itemCount: 5,
      padding: const EdgeInsets.all(20),
      separatorBuilder: (context, index) => const SizedBox(height: 20),
      itemBuilder: (context, index) => CustomCatCard(cat: catsList.first),
    );
  }
}
