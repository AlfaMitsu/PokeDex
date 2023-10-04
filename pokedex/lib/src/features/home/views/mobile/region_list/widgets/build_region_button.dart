import 'package:flutter/material.dart';
import 'package:pokedex/src/features/home/views/mobile/pokemon_list/pokemon_list_screen.dart';

final Map<String, String> regionBackgroundImages = {
    'Kanto': 'assets/images/kImgKantoRegion.jpg',
    'Johto': 'assets/images/kImgJohtoRegion.jpg',
    'Hoenn': 'assets/images/kImgHoennRegion.jpg',
    'Sinnoh': 'assets/images/kImgSinnohRegion.jpg',
    'Unova': 'assets/images/kImgUnovaRegion.jpg',
    'Kalos': 'assets/images/kImgKalosRegion.jpg',
    'Alola': 'assets/images/kImgAlolaRegion.jpg',
    'Galar': 'assets/images/kImgGalarRegion.jpg',
    'Hisui': 'assets/images/kImgHisuiRegion.jpg',
    'Paldea': 'assets/images/kImgPaldeaRegion.jpg',
  };
  Widget buildRegionButton(BuildContext context, String regionName) {
    final backgroundImageAsset = regionBackgroundImages[regionName];

    Widget destinationScreen = Container();

    switch (regionName) {
      case 'Kanto':
      case 'Johto':
      case 'Hoenn':
      case 'Sinnoh':
      case 'Unova':
      case 'Kalos':
      case 'Alola':
      case 'Galar':
      case 'Hisui':
      case 'Paldea':
        destinationScreen = PokemonListScreen(region: regionName);
        break;
    }

    return Expanded(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => destinationScreen,
            ),
          );
        },
        child: Container(
          height: 100,
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: backgroundImageAsset != null
                ? DecorationImage(
                    image: AssetImage(backgroundImageAsset),
                    fit: BoxFit.cover,
                  )
                : null,
          ),
          child: Center(
            child: Text(
              regionName,
              style: const TextStyle(
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
          ),
        ),
      ),
    );
  }