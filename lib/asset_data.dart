class AssetData {
  String title;
  String description;
  String imageUrl;
  String creator;
  String group;
  String tag = 'Available';
  late String timestamp;

  AssetData({
    required this.title,
    this.description = '',
    this.imageUrl = '',
    required this.creator,
    required this.group,
  }) {
    this.timestamp = getTimeString();
  }

  String getTimeString() {
    final currentTime = DateTime.now().toString();
    return currentTime.substring(0, currentTime.length - 4);
  }
}

enum TagState {
  available,
  unavailable,
}
