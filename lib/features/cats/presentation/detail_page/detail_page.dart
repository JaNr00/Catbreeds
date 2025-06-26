import 'package:catbreeds/core/responsive/responsive.dart';
import 'package:catbreeds/features/cats/domain/entities/cat.dart';
import 'package:catbreeds/shared/widgets/description_item.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.cat});

  final Cat cat;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(cat.name),
        centerTitle: true,
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Image.network(cat.image.url),
          Expanded(child: _CatDetails(cat: cat))
        ],
      ),
    );
  }
}

class _CatDetails extends StatelessWidget {
  const _CatDetails({required this.cat});

  final Cat cat;

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    return Container(
      padding: EdgeInsetsGeometry.all(
          responsive.isTablet() ? responsive.hp(5) : responsive.wp(10)),
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: responsive.hp(1),
          children: [
            Text(cat.description),
            const Divider(),
            _EndogamicDetails(
              origin: cat.origin,
              temperament: cat.temperament,
              lifeSpan: cat.lifeSpan,
              weight: cat.weight,
            ),
            const Divider(),
            _NumericalAttributes(
              adaptability: cat.adaptability,
              intelligence: cat.intelligence,
              childFriendly: cat.childFriendly,
              dogFriendly: cat.dogFriendly,
              strangerFriendly: cat.strangerFriendly,
              energyLevel: cat.energyLevel,
              healthIssues: cat.healthIssues,
            ),
            const Divider(),
            Align(
                alignment: Alignment.center,
                child: InkWell(
                    // onTap: () => launchUrl(Uri.parse(cat.wikipediaUrl ?? '')),
                    child: Text(
                  cat.wikipediaUrl ?? '',
                  style: TextStyle(
                      color: Colors.blueAccent,
                      decoration: TextDecoration.underline),
                ))),
          ],
        ),
      ),
    );
  }
}

class _NumericalAttributes extends StatelessWidget {
  const _NumericalAttributes(
      {required this.adaptability,
      required this.intelligence,
      required this.energyLevel,
      required this.childFriendly,
      required this.dogFriendly,
      required this.strangerFriendly,
      required this.healthIssues});

  final int adaptability;
  final int intelligence;
  final int energyLevel;
  final int childFriendly;
  final int dogFriendly;
  final int strangerFriendly;
  final int healthIssues;

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    return Column(
      spacing: responsive.hp(0.5),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Atributos numéricos (0-5)',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        DescriptionItem(
            title: 'Adaptabilidad: ', description: adaptability.toString()),
        DescriptionItem(
            title: 'Inteligencia: ', description: intelligence.toString()),
        DescriptionItem(
            title: 'Nivel de energia: ', description: energyLevel.toString()),
        DescriptionItem(
            title: 'Problemas de salud: ',
            description: intelligence.toString()),
        DescriptionItem(
            title: 'Child-Friendly: ', description: childFriendly.toString()),
        DescriptionItem(
            title: 'Dog-Friendly: ', description: dogFriendly.toString()),
        DescriptionItem(
            title: 'Stranger-Friendly: ',
            description: strangerFriendly.toString()),
      ],
    );
  }
}

class _EndogamicDetails extends StatelessWidget {
  const _EndogamicDetails({
    required this.origin,
    required this.temperament,
    required this.lifeSpan,
    required this.weight,
  });

  final String origin;
  final String temperament;
  final String lifeSpan;
  final Weight weight;

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    return Column(
      spacing: responsive.hp(0.5),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Características endogámicas',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        DescriptionItem(title: 'Origen: ', description: origin),
        DescriptionItem(title: 'Personalidad: ', description: temperament),
        DescriptionItem(title: 'Tiempo de vida: ', description: lifeSpan),
        DescriptionItem(
            title: 'Peso: ',
            description: '${weight.imperial} lbs  /  ${weight.metric} kg'),
      ],
    );
  }
}
