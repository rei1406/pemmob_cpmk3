import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/now_playing_controller.dart';

class NowPlayingView extends StatelessWidget {
  const NowPlayingView({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<NowPlayingController>();

    String _fmt(int sec) {
      final m = (sec ~/ 60).toString();
      final s = (sec % 60).toString().padLeft(2, '0');
      return '$m:$s';
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Now Playing'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 12),
            Obx(() => ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    c.coverUrl.value,
                    width: 280,
                    height: 280,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      width: 280,
                      height: 280,
                      color: const Color(0xFF2A2C36),
                      child: const Icon(Icons.album, color: Colors.grey, size: 48),
                    ),
                  ),
                )),
            const SizedBox(height: 16),
            Obx(() => Text(c.title.value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700))),
            const SizedBox(height: 4),
            Obx(() => Text(c.artist.value, style: const TextStyle(color: Colors.grey))),
            const SizedBox(height: 16),
            Obx(() => Slider(
                  value: c.durationSec.value == 0
                      ? 0
                      : c.positionSec.value / c.durationSec.value,
                  onChanged: (v) {
                    c.positionSec.value = (v * c.durationSec.value).round();
                  },
                  min: 0,
                  max: 1,
                )),
            Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_fmt(c.positionSec.value)),
                    Text(_fmt(c.durationSec.value)),
                  ],
                )),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  iconSize: 32,
                  onPressed: c.previous,
                  icon: const Icon(Icons.skip_previous),
                ),
                const SizedBox(width: 24),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(16),
                  ),
                  onPressed: () {},
                  child: const Icon(Icons.play_arrow, size: 32),
                ),
                const SizedBox(width: 24),
                IconButton(
                  iconSize: 32,
                  onPressed: c.next,
                  icon: const Icon(Icons.skip_next),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}