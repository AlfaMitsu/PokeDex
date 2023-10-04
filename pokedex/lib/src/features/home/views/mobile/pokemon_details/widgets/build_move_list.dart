import 'package:flutter/material.dart';
import 'package:pokedex/src/features/home/views/mobile/pokemon_details/pokemon_details_screen.dart';

Widget buildMovesList(List<dynamic> moves) {
  final movesTextList = moves
      .map((move) => move['move']['name']
          .toString()
          .replaceAll('-', ' ')
          .split(' ')
          .map((word) => word.capitalize())
          .join(' '))
      .toList();

  return Wrap(
    spacing: 8,
    children: movesTextList
        .map((moveText) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFEBEBE5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                moveText,
                style: const TextStyle(fontSize: 16),
              ),
            ))
        .toList(),
  );
}