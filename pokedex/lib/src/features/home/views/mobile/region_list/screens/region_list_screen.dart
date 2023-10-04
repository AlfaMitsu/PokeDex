import 'package:flutter/material.dart';
import 'package:pokedex/src/features/home/views/mobile/region_list/widgets/build_region_buttons.dart';

class RegionListScreen extends StatelessWidget {
  const RegionListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildRegionButtons(context),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.black),
      title: const Text(
        'Choose a Region',
        style: TextStyle(
          color: Color(0xFFFFCE00),
          fontWeight: FontWeight.bold,
          fontSize: 16,
          fontFamily: 'PokemonFont',
          letterSpacing: 2,
          shadows: [
            Shadow(
              color: Color(0xFF3E72BF),
              blurRadius: 4,
              offset: Offset(2, 2),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: () {},
        ),
      ],
    );
  }
}
