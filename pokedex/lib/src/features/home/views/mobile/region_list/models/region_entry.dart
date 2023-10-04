class RegionEntry {
  final String name;
  final String url;

  RegionEntry({
    required this.name,
    required this.url,
  });

  factory RegionEntry.fromJson(Map<String, dynamic> json) {
    return RegionEntry(
      name: json['name'],
      url: json['url'],
    );
  }
}