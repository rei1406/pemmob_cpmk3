import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0; // 0: Home, 2: Library (1 navigates to Search route)

  @override
  Widget build(BuildContext context) {
    final int contentIndex = _selectedIndex == 2 ? 1 : 0; // Map tab Library ke index 1
    return Scaffold(
      appBar: AppBar(
        title: const Text('MusicWave'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => Get.toNamed(Routes.search),
          )
        ],
      ),
      body: IndexedStack(
        index: contentIndex,
        children: [
          _buildHomeContent(context),
          _buildLibraryContent(context),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (i) {
          if (i == 1) {
            Get.toNamed(Routes.search);
          } else {
            setState(() => _selectedIndex = i);
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.library_music), label: 'Library'),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
    );
  }

  Widget _buildHomeContent(BuildContext context) {
    final albums = List.generate(6, (i) => 'https://picsum.photos/id/${i + 20}/300/300');
    final artists = [
      'Aruna', 'Zephyr', 'Loka', 'Nadir', 'Orion', 'Mora'
    ];

    return ListView(
      children: [
        _buildSectionTitle('Baru Rilis'),
        SizedBox(
          height: 180,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, i) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    albums[i],
                    width: 140,
                    height: 140,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      width: 140,
                      height: 140,
                      color: const Color(0xFF2A2C36),
                      child: const Icon(Icons.broken_image, color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: 140,
                  child: Text('Album #${i + 1}', maxLines: 1, overflow: TextOverflow.ellipsis),
                )
              ],
            ),
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemCount: albums.length,
          ),
        ),

        _buildSectionTitle('Rekomendasi Artis'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.78,
            ),
            itemBuilder: (_, i) => Column(
              children: [
                ClipOval(
                  child: Image.network(
                    'https://picsum.photos/id/${i + 60}/200/200',
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      width: 80,
                      height: 80,
                      color: const Color(0xFF2A2C36),
                      child: const Icon(Icons.person_off, color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(artists[i], maxLines: 1, overflow: TextOverflow.ellipsis),
              ],
            ),
            itemCount: artists.length,
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildLibraryContent(BuildContext context) {
    final playlists = [
      {'title': 'Road Trip Mix', 'count': 18},
      {'title': 'Chill Vibes', 'count': 24},
      {'title': 'Workout Pump', 'count': 30},
    ];

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemBuilder: (_, i) {
        final p = playlists[i];
        return ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              'https://picsum.photos/id/${i + 100}/120/120',
              width: 56,
              height: 56,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 56,
                height: 56,
                color: const Color(0xFF2A2C36),
                child: const Icon(Icons.queue_music, color: Colors.grey),
              ),
            ),
          ),
          title: Text(p['title'] as String),
          subtitle: Text('${p['count']} lagu'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => Get.toNamed(Routes.playlist),
        );
      },
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemCount: playlists.length,
    );
  }
}