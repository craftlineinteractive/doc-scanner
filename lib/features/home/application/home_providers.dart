import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/mock_home_repository.dart';
import '../domain/home_repository.dart';

/// Available presentation modes for document collection on the Home screen.
enum HomeViewMode {
  list,
  grid,
}

/// Notifier managing the current HomeRepository instance.
class HomeRepositoryNotifier extends Notifier<HomeRepository> {
  @override
  HomeRepository build() => const MockHomeRepository();

  void setRepository(HomeRepository repository) {
    state = repository;
  }
}

/// Provider exposing the current [HomeRepository].
final NotifierProvider<HomeRepositoryNotifier, HomeRepository>
    homeRepositoryProvider =
    NotifierProvider<HomeRepositoryNotifier, HomeRepository>(
  HomeRepositoryNotifier.new,
);

/// Notifier managing list vs grid layout toggle.
class HomeViewModeNotifier extends Notifier<HomeViewMode> {
  @override
  HomeViewMode build() => HomeViewMode.list;

  void toggle() {
    state = state == HomeViewMode.list ? HomeViewMode.grid : HomeViewMode.list;
  }

  void setMode(HomeViewMode mode) {
    state = mode;
  }
}

/// Provider exposing the current [HomeViewMode].
final NotifierProvider<HomeViewModeNotifier, HomeViewMode>
    homeViewModeProvider =
    NotifierProvider<HomeViewModeNotifier, HomeViewMode>(
  HomeViewModeNotifier.new,
);

