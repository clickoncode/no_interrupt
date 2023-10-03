class Video {
  final String id;
  final String title;
  final String thumbnailUrl;
  final String channelTitle;
 final String description;
 final  String playlistId;
 final int position;
  Video({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
    required this.channelTitle,
    required this.position,
    required this.description,
    required this.playlistId,
  });

  factory Video.fromMap(Map<String, dynamic> snippet) {
    return Video(
      id: snippet['resourceId']['videoId'],
      title: snippet['title'],
      thumbnailUrl: snippet['thumbnails']['high']['url'],
      channelTitle: snippet['channelTitle'],
      position: snippet["position"],
      description: snippet["description"],
      playlistId: snippet["playlistId"],
    );
  }
}