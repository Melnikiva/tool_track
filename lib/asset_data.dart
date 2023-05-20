class AssetData {
  final String title;
  final String description;
  late String timeCreated;

  AssetData({
    required this.title,
    this.description = '',
  }) {
    this.timeCreated = getTimeString();
  }

  String getTimeString() {
    final currentTime = DateTime.now().toString();
    return currentTime.substring(0, currentTime.length - 4);
  }
}
