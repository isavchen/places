import 'package:mobx/mobx.dart';
import 'package:places/data/repository/placeRepository.dart';
import 'package:places/domain/place.dart';

part 'place_list_store.g.dart';

class PlaceListStore = PlaceListStoreBase with _$PlaceListStore;

abstract class PlaceListStoreBase with Store {
  final PlaceRepository _placeRepository;

  @observable
  ObservableFuture<List<Place>>? getPlacesFuture;

  PlaceListStoreBase(this._placeRepository);

  @action
  void getPlaces() {
    final future = _placeRepository.getPlaces();
    getPlacesFuture = ObservableFuture(future);
  }
}
