import 'package:flutter/material.dart';
import 'package:pokedex/src/features/home/views/mobile/pokemon_list/models/pokemon_list_bg_color.dart';

Widget buildDetailRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 8),
        Flexible(
          child: Wrap(
            spacing: 4,
            runSpacing: 4,
            children: value.split(',').map((type) {
              final bgColor = typeColors[type.trim().toUpperCase()] ?? Colors.transparent;
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  type.trim(),
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    ),
  );
}