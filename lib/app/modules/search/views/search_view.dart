import 'package:flutter/material.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    final genres = [
      'Pop', 'Rock', 'Jazz', 'Hip Hop', 'EDM', 'Classical', 'Indie', 'Country', 'Metal', 'R&B'
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Search')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Cari lagu, artis, atau album',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: const Color(0xFF1E2027),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text('Kategori Genre', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 3.5,
            ),
            itemCount: genres.length,
            itemBuilder: (_, i) => Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1E2027),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              alignment: Alignment.centerLeft,
              child: Text(genres[i]),
            ),
          ),
        ],
      ),
    );
  }
}