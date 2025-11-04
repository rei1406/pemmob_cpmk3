import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';

class PlaylistView extends StatelessWidget {
  const PlaylistView({super.key});

  @override
  Widget build(BuildContext context) {
    // Daftar lagu realistis dengan durasi dalam detik
    final baseIds = List.generate(12, (i) => 310 + i); // picsum ids variatif
    final songs = [
      {'title': 'Blinding Lights', 'artist': 'The Weeknd', 'durationSec': 200, 'imageUrl': 'https://picsum.photos/id/${baseIds[0]}/600/600'},
      {'title': 'Levitating', 'artist': 'Dua Lipa', 'durationSec': 203, 'imageUrl': 'https://picsum.photos/id/${baseIds[1]}/600/600'},
      {'title': 'drivers license', 'artist': 'Olivia Rodrigo', 'durationSec': 242, 'imageUrl': 'https://picsum.photos/id/${baseIds[2]}/600/600'},
      {'title': 'Watermelon Sugar', 'artist': 'Harry Styles', 'durationSec': 174, 'imageUrl': 'https://picsum.photos/id/${baseIds[3]}/600/600'},
      {'title': 'bad guy', 'artist': 'Billie Eilish', 'durationSec': 194, 'imageUrl': 'https://picsum.photos/id/${baseIds[4]}/600/600'},
      {'title': 'Shape of You', 'artist': 'Ed Sheeran', 'durationSec': 233, 'imageUrl': 'https://picsum.photos/id/${baseIds[5]}/600/600'},
      {'title': 'Dance Monkey', 'artist': 'Tones and I', 'durationSec': 209, 'imageUrl': 'https://picsum.photos/id/${baseIds[6]}/600/600'},
      {'title': 'Circles', 'artist': 'Post Malone', 'durationSec': 215, 'imageUrl': 'https://picsum.photos/id/${baseIds[7]}/600/600'},
      {'title': 'Stay', 'artist': 'The Kid LAROI & Justin Bieber', 'durationSec': 141, 'imageUrl': 'https://picsum.photos/id/${baseIds[8]}/600/600'},
      {'title': 'Señorita', 'artist': 'Shawn Mendes & Camila Cabello', 'durationSec': 190, 'imageUrl': 'https://picsum.photos/id/${baseIds[9]}/600/600'},
      {'title': 'Old Town Road', 'artist': 'Lil Nas X', 'durationSec': 157, 'imageUrl': 'https://picsum.photos/id/${baseIds[10]}/600/600'},
      {'title': 'Thinking Out Loud', 'artist': 'Ed Sheeran', 'durationSec': 281, 'imageUrl': 'https://picsum.photos/id/${baseIds[11]}/600/600'},
    ];

    String _fmt(int sec) {
      final m = (sec ~/ 60).toString();
      final s = (sec % 60).toString().padLeft(2, '0');
      return '$m:$s';
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Playlist')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  'https://picsum.photos/id/200/300/300',
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 120,
                    height: 120,
                    color: const Color(0xFF2A2C36),
                    child: const Icon(Icons.queue_music, color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Road Trip Mix', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                    SizedBox(height: 8),
                    Text('Oleh John Doe'),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () => Get.toNamed(
              Routes.nowPlaying,
              arguments: {
                'playlist': songs,
                'index': 0,
              },
            ),
            icon: const Icon(Icons.play_arrow),
            label: const Text('Mulai Putar'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo,
              minimumSize: const Size.fromHeight(44),
            ),
          ),
          const SizedBox(height: 16),
          const Text('Lagu-lagu', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: songs.length,
            itemBuilder: (_, i) {
              final s = songs[i];
              return ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    (s['imageUrl'] as String),
                    width: 56,
                    height: 56,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      width: 56,
                      height: 56,
                      color: const Color(0xFF2A2C36),
                      child: const Icon(Icons.music_note, color: Colors.grey),
                    ),
                  ),
                ),
                title: Text(s['title'] as String),
                subtitle: Text(s['artist'] as String),
                trailing: Text(_fmt(s['durationSec'] as int)),
                onTap: () => Get.toNamed(
                  Routes.nowPlaying,
                  arguments: {
                    'playlist': songs,
                    'index': i,
                  },
                ),
              );
            },
            separatorBuilder: (_, __) => const Divider(height: 1),
          ),
        ],
      ),
    );
  }
}