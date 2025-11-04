import 'package:get/get.dart';

class NowPlayingController extends GetxController {
  final title = 'River Lights'.obs;
  final artist = 'Zephyr'.obs;
  final durationSec = 222.obs; // default ~3:42
  final positionSec = 0.obs;
  final coverUrl = 'https://picsum.photos/id/250/600/600'.obs;

  final currentIndex = 0.obs;
  List<Map<String, dynamic>> playlist = [];

  void _loadTrack(int index) {
    if (playlist.isEmpty || index < 0 || index >= playlist.length) return;
    final t = playlist[index];
    title.value = t['title'] as String? ?? title.value;
    artist.value = t['artist'] as String? ?? artist.value;
    durationSec.value = t['durationSec'] as int? ?? durationSec.value;
    coverUrl.value = t['imageUrl'] as String? ?? coverUrl.value;
    positionSec.value = 0;
  }

  void next() {
    if (playlist.isEmpty) return;
    currentIndex.value = (currentIndex.value + 1) % playlist.length;
    _loadTrack(currentIndex.value);
  }

  void previous() {
    if (playlist.isEmpty) return;
    currentIndex.value = (currentIndex.value - 1 + playlist.length) % playlist.length;
    _loadTrack(currentIndex.value);
  }

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args is Map && args['playlist'] is List) {
      playlist = List<Map<String, dynamic>>.from(args['playlist'] as List);
      currentIndex.value = (args['index'] as int?) ?? 0;
      _loadTrack(currentIndex.value);
    } else if (args is Map) {
      // Fallback ketika hanya lagu tunggal yang dikirim
      playlist = [
        {
          'title': args['title'] ?? title.value,
          'artist': args['artist'] ?? artist.value,
          'durationSec': args['durationSec'] ?? durationSec.value,
          'imageUrl': args['imageUrl'] ?? coverUrl.value,
        }
      ];
      currentIndex.value = 0;
      _loadTrack(0);
    }
  }
}