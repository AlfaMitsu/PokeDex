import 'package:flutter/material.dart';
import 'package:pokedex/src/features/home/views/mobile/region_list/widgets/build_region_button.dart';

final List<String> regionNames = [
  'Kanto',
  'Johto',
  'Hoenn',
  'Sinnoh',
  'Unova',
  'Kalos',
  'Alola',
  'Galar',
  'Hisui',
  'Paldea',
];
Widget buildRegionButtons(BuildContext context) {
  return SingleChildScrollView(
    child: Column(
      children: [
        for (int i = 0; i < regionNames.length; i += 2)
          Row(
            children: [
              buildRegionButton(context, regionNames[i]),
              if (i + 1 < regionNames.length)
                buildRegionButton(context, regionNames[i + 1]),
            ],
          ),
      ],
    ),
  );
}
