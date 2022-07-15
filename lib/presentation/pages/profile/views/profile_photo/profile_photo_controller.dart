import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:training_app/data/repository_impl/guide_repository_impl.dart';
import 'package:training_app/data/repository_impl/repository_provider.dart';
import 'package:training_app/domain/entities/entity.dart';
import 'package:training_app/presentation/pages/controller.dart';

enum MediaType { byDate, byAlbum }

const photoType = MediaType.values;

extension MediaTypeExtension on MediaType {
  String get label {
    switch (this) {
      case MediaType.byDate:
        return '日付順';
      case MediaType.byAlbum:
        return 'アルバム';
    }
  }
}

final photoTypeController = StateProvider<MediaType?>((ref) {
  return null;
});

// class AlbumMediaNotifier extends StateNotifier<PageStatus<List<MapEntry<int?,List<Media?>>>>> {
//   AlbumMediaNotifier({
//     required this.repositoryImpl,
//   }) : super(PageStatus<List<MapEntry<int?, List<Media?>>>>(PageState.init, data: []));

//   final GuideRepositoryImpl repositoryImpl;

//   final _page = 1;

//   Future init({
//     required String username,
//   }) async {
//     state = state.copyWith(PageState.loading);
//     var result =
//         await repositoryImpl.getUserAlbums(username: username, page: _page);
//     List<MapEntry<int?, List<Media?>>> list =
//         groupBy<Media?, int?>(result.list, (e) => e?.id).entries.toList();
//     // print(list[0].value.length);
//     // list.entries.
//     state = PageStatus(PageState.loaded, data: list);
//   }
// }

class AlbumMediaNotifier extends StateNotifier<PageStatus<List<Media?>>> {
  AlbumMediaNotifier({
    required this.repositoryImpl,
  }) : super(PageStatus<List<Media?>>(PageState.init, data: []));

  final GuideRepositoryImpl repositoryImpl;

  final _page = 1;

  Future init({
    required String username,
  }) async {
    state = state.copyWith(PageState.loading);
    var result =
        await repositoryImpl.getUserAlbums(username: username, page: _page);
    // List<MapEntry<int?, List<Media?>>> list =
    //     groupBy<Media?, int?>(result.list, (e) => e?.id).entries.toList();
    // print(list[0].value.length);
    // list.entries.
    state = PageStatus(PageState.loaded, data: result.list);
  }

  List<MapEntry<int?, List<Media?>>> sortByAlbums() =>
      groupBy<Media?, int?>(state.data ?? [], (e) => e?.id).entries.toList();

  // List<MapEntry<String?, List<Media?>>> sortByTime() =>
  //     groupBy<Media?, String?>(state.data ?? [], (e) => e?.timeline)
  //         .entries
  //         .toList();
}
final albumMediaController = StateNotifierProvider.autoDispose<
    AlbumMediaNotifier, PageStatus<List<Media?>>>(
  (ref) => AlbumMediaNotifier(
    repositoryImpl: ref.watch(guideRepoProvider),
  ),
);



class DateMediaNotifier extends StateNotifier<PageStatus<List<Media?>>> {
  DateMediaNotifier({
    required this.repositoryImpl,
  }) : super(PageStatus<List<Media?>>(PageState.init, data: []));

  final GuideRepositoryImpl repositoryImpl;

  final _page = 1;

  Future init({
    required String username,
  }) async {
    state = state.copyWith(PageState.loading);
    var result =
        await repositoryImpl.getUserMedium(username: username, page: _page);
    // List<MapEntry<int?, List<Media?>>> list =
    //     groupBy<Media?, int?>(result.list, (e) => e?.id).entries.toList();
    // print(list[0].value.length);
    // list.entries.
    state = PageStatus(PageState.loaded, data: result.list);
  }

  // List<MapEntry<int?, List<Media?>>> sortByAlbums() =>
  //     groupBy<Media?, int?>(state.data ?? [], (e) => e?.id).entries.toList();

  List<MapEntry<String?, List<Media?>>> sortByTime() =>
      groupBy<Media?, String?>(state.data ?? [], (e) => e?.timeline)
          .entries
          .toList();
}

final dateMediaController = StateNotifierProvider.autoDispose<
    DateMediaNotifier, PageStatus<List<Media?>>>(
  (ref) => DateMediaNotifier(
    repositoryImpl: ref.watch(guideRepoProvider),
  ),
);
