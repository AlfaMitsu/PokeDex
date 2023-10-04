import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex/src/features/home/views/mobile/pokemon_details/pokemon_details_screen.dart';
import 'package:pokedex/src/features/home/views/mobile/pokemon_list/models/pokemon_list_bg_color.dart';

class PokemonListScreen extends StatefulWidget {
  final String region;

  const PokemonListScreen({Key? key, required this.region}) : super(key: key);

  @override
  _PokemonListScreenState createState() => _PokemonListScreenState();
}

class _PokemonListScreenState extends State<PokemonListScreen> {
  late Future<List<Map<String, dynamic>>> pokemonListFuture;

  @override
  void initState() {
    super.initState();
    pokemonListFuture = fetchPokemonData();
  }

  Future<List<Map<String, dynamic>>> fetchPokemonData() async {
    final int offset = getOffset();
    final int limit = getLimit();
    final response = await http.get(Uri.parse(
        'https://pokeapi.co/api/v2/pokemon?limit=$limit&offset=$offset'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final results = data['results'] as List<dynamic>;

      final pokemonList = await Future.wait(results.map((pokemon) async {
        final typeResponse = await fetchPokemonTypeData(pokemon['url']);
        final types = typeResponse['types'] as List<dynamic>;

        final primaryType =
            types.isNotEmpty ? types[0]['type']['name'].toUpperCase() : '';
        final secondaryType =
            types.length > 1 ? types[1]['type']['name'].toUpperCase() : null;

        return {
          'name': pokemon['name'].toString().toUpperCase(),
          'primaryType': primaryType,
          'secondaryType': secondaryType,
        };
      }));

      return pokemonList.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Failed to load Pokémon data');
    }
  }

  Future<Map<String, dynamic>> fetchPokemonTypeData(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Failed to load Pokémon type data');
    }
  }

  int getOffset() {
    if (widget.region == 'Kanto') {
      return 0;
    } else if (widget.region == 'Johto') {
      return 151;
    } else if (widget.region == 'Hoenn') {
      return 251;
    } else if (widget.region == 'Sinnoh') {
      return 386;
    } else if (widget.region == 'Unova') {
      return 493;
    } else if (widget.region == 'Kalos') {
      return 649;
    } else if (widget.region == 'Alola') {
      return 721;
    } else if (widget.region == 'Galar') {
      return 809;
    } else if (widget.region == 'Hisui') {
      return 809;
    } else if (widget.region == 'Paldea') {
      return 905;
    } else {
      return 0;
    }
  }

  int getLimit() {
    if (widget.region == 'Kanto') {
      return 151;
    } else if (widget.region == 'Johto') {
      return 100;
    } else if (widget.region == 'Hoenn') {
      return 135;
    } else if (widget.region == 'Sinnoh') {
      return 107;
    } else if (widget.region == 'Unova') {
      return 156;
    } else if (widget.region == 'Kalos') {
      return 72;
    } else if (widget.region == 'Alola') {
      return 88;
    } else if (widget.region == 'Galar') {
      return 96;
    } else if (widget.region == 'Hisui') {
      return 96;
    } else if (widget.region == 'Paldea') {
      return 105;
    } else {
      return 151;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: buildAppBar(),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: pokemonListFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No Pokémon found.'),
            );
          } else {
            final pokemonList = snapshot.data!;
            return buildBody(pokemonList);
          }
        },
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.black),
      title: Text(
        widget.region,
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
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget buildBody(List<Map<String, dynamic>> pokemonList) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: pokemonList.length,
        itemBuilder: (context, index) {
          final pokemon = pokemonList[index];
          final pokemonId = (index + 1 + getOffset()).toString();

          final primaryType = pokemon['primaryType'];
          final backgroundColor = typeColors[primaryType] ?? Colors.grey;

          final secondaryType = pokemon['secondaryType'];
          final secondaryBackgroundColor =
              secondaryType != null ? typeColors[secondaryType] ?? Colors.transparent : Colors.transparent;

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PokemonDetailsScreen(pokemonId: int.parse(pokemonId)),
                ),
              );
            },
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: backgroundColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$pokemonId.png?fbclid=IwAR2dFbDsarNIoLB5OwI9atYezCs7MLXYa6LRlrkMvTKmNee5dgrHZfDKBsw',
                  ),
                  const SizedBox(height: 10),
                  Text(
                    pokemon['name'].toUpperCase(),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: backgroundColor.withOpacity(0.8),
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Text(
                        primaryType,
                        style: const TextStyle(fontSize: 8),
                      ),
                    ),
                  ),
                  if (secondaryType != null)
                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: secondaryBackgroundColor.withOpacity(0.8),
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: Text(
                          secondaryType,
                          style: const TextStyle(fontSize: 8),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
