import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex/src/features/home/views/mobile/pokemon_details/widgets/build_detail_row.dart';
import 'package:pokedex/src/features/home/views/mobile/pokemon_details/widgets/build_move_list.dart';

class PokemonDetailsScreen extends StatefulWidget {
  final int pokemonId;

  const PokemonDetailsScreen({Key? key, required this.pokemonId})
      : super(key: key);

  @override
  _PokemonDetailsScreenState createState() => _PokemonDetailsScreenState();
}

class _PokemonDetailsScreenState extends State<PokemonDetailsScreen> {
  late Future<Map<String, dynamic>> pokemonDetailsFuture;

  @override
  void initState() {
    super.initState();
    pokemonDetailsFuture = fetchPokemonDetails(widget.pokemonId);
  }

  Future<Map<String, dynamic>> fetchPokemonDetails(int id) async {
    final response =
        await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/$id/'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Failed to load Pokémon details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.black),
      title: buildAppBarTitle(),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget buildAppBarTitle() {
    return FutureBuilder<Map<String, dynamic>>(
      future: pokemonDetailsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData) {
          return const Text('Kanto');
        } else {
          final pokemonDetails = snapshot.data!;
          final pokemonName = pokemonDetails['name'].toString().capitalize();
          return Text(
            pokemonName,
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
          );
        }
      },
    );
  }

  Widget buildBody() {
    return FutureBuilder<Map<String, dynamic>>(
      future: pokemonDetailsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (!snapshot.hasData) {
          return const Center(
            child: Text('No Pokémon details found.'),
          );
        } else {
          final pokemonDetails = snapshot.data!;
          final pokemonId = pokemonDetails['id'].toString();
          final imageUrl =
              'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$pokemonId.png?fbclid=IwAR2dFbDsarNIoLB5OwI9atYezCs7MLXYa6LRlrkMvTKmNee5dgrHZfDKBsw';

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xFFECECEC),
                    ),
                    child: Column(
                      children: [
                        Image.network(
                          imageUrl,
                        ),
                        buildDetailRow(
                          'Name:    ',
                          pokemonDetails['name'].toString().capitalize(),
                        ),
                        buildDetailRow('ID:           ', ' $pokemonId'),
                        buildDetailRow(
                          'Types:    ',
                          pokemonDetails['types']
                              .map((type) =>
                                  type['type']['name'].toString().capitalize())
                              .join(", "),
                        ),
                        buildDetailRow(
                          'Abilities:',
                          pokemonDetails['abilities']
                              .map((ability) => ability['ability']['name']
                                  .toString()
                                  .capitalize())
                              .join(", "),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xFFECDFEC),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Moves:',
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 10),
                        buildMovesList(pokemonDetails['moves']),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
