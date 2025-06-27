import 'dart:async';
import 'dart:io';

import 'package:catbreeds/core/responsive/responsive.dart';
import 'package:catbreeds/features/cats/domain/entities/cat.dart';
import 'package:catbreeds/features/cats/presentation/landing_page/cubit/landing_page_cubit.dart';
import 'package:catbreeds/features/cats/presentation/landing_page/cubit/landing_page_state.dart';
import 'package:catbreeds/features/cats/presentation/widgets/custom_cat_card.dart';
import 'package:catbreeds/shared/styles/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Catbreeds',
          style: TextStyles(isTablet: responsive.isTablet()).titleHeadStyle,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(responsive.hp(15)),
          child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: responsive.wp(5),
                vertical: responsive.hp(5),
              ),
              child: Platform.isIOS
                  ? CupertinoSearchTextField(
                      placeholder: 'Busca por nombre de raza en inglés',
                      onChanged: _onSearchChanged,
                    )
                  : SearchBar(
                      elevation: WidgetStateProperty.all(5),
                      backgroundColor:
                          WidgetStateProperty.all(Colors.grey.shade100),
                      trailing: const [Icon(Icons.search)],
                      hintText: 'Busca por nombre de raza en inglés',
                      onChanged: _onSearchChanged,
                    )),
        ),
      ),
      body: SafeArea(child: const _CardsList()),
    );
  }

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      context.read<LandingPageCubit>().searchCatsBreeds(searchTerm: value);
    });
  }
}

class _CardsList extends StatelessWidget {
  const _CardsList();

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    return BlocListener<LandingPageCubit, LandingPageState>(
      listener: (context, state) {
        if (state.failedSearch) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Fallo del servicio de busqueda'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: BlocBuilder<LandingPageCubit, LandingPageState>(
        builder: (context, state) {
          final List<CatBreed> catsList = state.catBreeds;

          return state.isLoading
              ? const Center(child: CircularProgressIndicator())
              : catsList.isEmpty
                  ? Center(
                      child: Text(
                      'No se encontraron resultados',
                      style: TextStyles(isTablet: responsive.isTablet())
                          .titleHeadStyle
                          .copyWith(color: Colors.grey.shade600),
                      maxLines: 2,
                    ))
                  : GridView.builder(
                      itemCount: catsList.length,
                      padding: EdgeInsets.symmetric(
                          horizontal: responsive.wp(8),
                          vertical: responsive.hp(2)),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: responsive.isLandscape() ? 2 : 1,
                        mainAxisSpacing: responsive.isTablet()
                            ? responsive.hp(5)
                            : responsive.hp(8),
                        crossAxisSpacing: responsive.isTablet()
                            ? responsive.hp(5)
                            : responsive.hp(8),
                        childAspectRatio:
                            responsive.isLandscape() ? 4 / 5 : 2 / 3,
                      ),
                      itemBuilder: (context, index) {
                        return CustomCatCard(cat: catsList[index]);
                      },
                    );
        },
      ),
    );
  }
}
