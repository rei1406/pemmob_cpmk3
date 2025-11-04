import 'package:get/get.dart';

import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/search/bindings/search_binding.dart';
import '../modules/search/views/search_view.dart';
import '../modules/playlist/bindings/playlist_binding.dart';
import '../modules/playlist/views/playlist_view.dart';
import '../modules/now_playing/bindings/now_playing_binding.dart';
import '../modules/now_playing/views/now_playing_view.dart';
import 'app_routes.dart';

class AppPages {
  static const initial = Routes.splash;

  static final routes = <GetPage>[
    GetPage(
      name: Routes.splash,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.search,
      page: () => const SearchView(),
      binding: SearchBinding(),
    ),
    GetPage(
      name: Routes.playlist,
      page: () => const PlaylistView(),
      binding: PlaylistBinding(),
    ),
    GetPage(
      name: Routes.nowPlaying,
      page: () => const NowPlayingView(),
      binding: NowPlayingBinding(),
    ),
  ];
}