import 'package:catbreeds/core/responsive/responsive.dart';
import 'package:catbreeds/features/cats/domain/entities/cat.dart';
import 'package:catbreeds/shared/styles/text_styles.dart';
import 'package:catbreeds/shared/util.dart';
import 'package:catbreeds/shared/widgets/description_item.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.cat});

  final CatBreed cat;

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          cat.name,
          style: TextStyles(isTablet: responsive.isTablet()).titleHeadStyle,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Container(
              color: Colors.white,
              width: double.infinity,
              height: responsive.isTablet() || responsive.isLandscape()
                  ? responsive.hp(30)
                  : responsive.hp(50),
              child: cat.image == null
                  ? Image.asset('lib/shared/assets/no_cat.jfif')
                  : Image.network(
                      cat.image!.url,
                      fit: BoxFit.fitHeight,
                    )),
          Expanded(child: _CatDetails(cat: cat))
        ],
      ),
    );
  }
}

class _CatDetails extends StatelessWidget {
  const _CatDetails({required this.cat});

  final CatBreed cat;

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    return Container(
      padding: EdgeInsetsGeometry.all(
          responsive.isTablet() || responsive.isLandscape()
              ? responsive.hp(5)
              : responsive.wp(10)),
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: responsive.hp(1),
          children: [
            Text(
              cat.description ?? 'N/A',
              textAlign: TextAlign.justify,
              style:
                  TextStyles(isTablet: responsive.isTablet()).descriptionStyle,
            ),
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
                    onTap: () => Util.launchBrowserURL(cat.wikipediaUrl ?? ''),
                    child: Text(
                      cat.wikipediaUrl ?? '',
                      style: TextStyle(
                          fontSize: responsive.isTablet() ? 18 : 16,
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

  final int? adaptability;
  final int? intelligence;
  final int? energyLevel;
  final int? childFriendly;
  final int? dogFriendly;
  final int? strangerFriendly;
  final int? healthIssues;

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    return Column(
      spacing: responsive.hp(0.5),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Atributos numéricos (0-5)',
          style: TextStyles(isTablet: responsive.isTablet())
              .titleH2Style
              .copyWith(decoration: TextDecoration.underline),
        ),
        DescriptionItem(
            title: 'Adaptabilidad: ',
            description: adaptability?.toString() ?? 'N/A'),
        DescriptionItem(
            title: 'Inteligencia: ',
            description: intelligence?.toString() ?? 'N/A'),
        DescriptionItem(
          title: 'Nivel de energía: ',
          description: energyLevel?.toString() ?? 'N/A',
        ),
        DescriptionItem(
          title: 'Problemas de salud: ',
          description: healthIssues?.toString() ?? 'N/A',
        ),
        DescriptionItem(
          title: 'Child-Friendly: ',
          description: childFriendly?.toString() ?? 'N/A',
        ),
        DescriptionItem(
          title: 'Dog-Friendly: ',
          description: dogFriendly?.toString() ?? 'N/A',
        ),
        DescriptionItem(
          title: 'Stranger-Friendly: ',
          description: strangerFriendly?.toString() ?? 'N/A',
        ),
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

  final String? origin;
  final String? temperament;
  final String? lifeSpan;
  final Weight? weight;

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    return Column(
      spacing: responsive.hp(0.5),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Características endogámicas',
          style: TextStyles(isTablet: responsive.isTablet())
              .titleH2Style
              .copyWith(decoration: TextDecoration.underline),
        ),
        DescriptionItem(title: 'Origen: ', description: origin ?? 'N/A'),
        DescriptionItem(
            title: 'Personalidad: ', description: temperament ?? 'N/A'),
        DescriptionItem(
            title: 'Tiempo de vida: ', description: '$lifeSpan años'),
        DescriptionItem(
            title: 'Peso: ',
            description: weight == null
                ? 'N/A'
                : '${weight!.imperial} lbs  /  ${weight!.metric} kg'),
      ],
    );
  }
}
