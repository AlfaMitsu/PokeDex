import 'package:pokedex/src/features/home/views/mobile/region_list/models/region_entry.dart';

class RegionList {
  final int count;
  final List<RegionEntry> results;

  RegionList({
    required this.count,
    required this.results,
  });

  factory RegionList.fromJson(Map<String, dynamic> json) {
    final resultsList = json['results'] as List<dynamic>;
    final results = resultsList
        .map((result) => RegionEntry.fromJson(result))
        .toList();

    return RegionList(
      count: json['count'],
      results: results,
    );
  }
}