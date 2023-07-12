import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/model/request/place_request.dart';

part 'create_place_event.dart';
part 'create_place_state.dart';

class CreatePlaceBloc extends Bloc<CreatePlaceEvent, CreatePlaceState> {
  final PlaceInteractor _placeInteractor;
  CreatePlaceBloc(this._placeInteractor)
      : super(CreatePlaceDataState(
          uploadedImages: [],
          category: '',
          name: '',
          lat: '',
          lon: '',
          desc: '',
          isFormValid: false,
        )) {
    on<AddUploadingPhotoEvent>(_addUploadingPhoto);
    on<RemoveUploadingPhoto>(_removeUploadingPhoto);
    on<AddCategoryEvent>(_addCategory);
    on<AddNameEvent>(_addName);
    on<AddLatEvent>(_addLatitude);
    on<AddLonEvent>(_addLongitude);
    on<AddDescriptionEvent>(_addDescription);
    on<StartCreatePlaceEvent>(_createPlace);
  }

  void _addUploadingPhoto(
      AddUploadingPhotoEvent event, Emitter<CreatePlaceState> emit) {
    final state = this.state;
    if (state is CreatePlaceDataState) {
      final newState = state.copyWith(
          uploadedImages: List.of(state.uploadedImages)..add(event.photoPath));
      _validateData(newState, emit);
    }
  }

  void _removeUploadingPhoto(
      RemoveUploadingPhoto event, Emitter<CreatePlaceState> emit) {
    final state = this.state;
    if (state is CreatePlaceDataState) {
      final newState = state.copyWith(
          uploadedImages: List.of(state.uploadedImages)
            ..remove(event.photoPath));
      _validateData(newState, emit);
    }
  }

  void _addCategory(AddCategoryEvent event, Emitter<CreatePlaceState> emit) {
    final state = this.state;
    if (state is CreatePlaceDataState) {
      final newState = state.copyWith(category: event.category);
      _validateData(newState, emit);
    }
  }

  void _addName(AddNameEvent event, Emitter<CreatePlaceState> emit) {
    final state = this.state;
    if (state is CreatePlaceDataState) {
      final newState = state.copyWith(name: event.name);
      _validateData(newState, emit);
    }
  }

  void _addLatitude(AddLatEvent event, Emitter<CreatePlaceState> emit) {
    final state = this.state;
    if (state is CreatePlaceDataState) {
      final newState = state.copyWith(lat: event.lat);
      _validateData(newState, emit);
    }
  }

  void _addLongitude(AddLonEvent event, Emitter<CreatePlaceState> emit) {
    final state = this.state;
    if (state is CreatePlaceDataState) {
      final newState = state.copyWith(lon: event.lon);
      _validateData(newState, emit);
    }
  }

  void _addDescription(
      AddDescriptionEvent event, Emitter<CreatePlaceState> emit) {
    final state = this.state;
    if (state is CreatePlaceDataState) {
      final newState = state.copyWith(desc: event.desc);
      _validateData(newState, emit);
    }
  }

  void _validateData(
      CreatePlaceDataState state, Emitter<CreatePlaceState> emit) {
    bool isFormValid = false;
    if (state.name.isNotEmpty &&
        state.lat.isNotEmpty &&
        state.lat != '.' &&
        state.lon.isNotEmpty &&
        state.lon != '.' &&
        state.desc.isNotEmpty &&
        state.category.isNotEmpty &&
        state.uploadedImages.isNotEmpty) isFormValid = true;
    emit(state.copyWith(isFormValid: isFormValid));
  }

  Future<void> _createPlace(
      StartCreatePlaceEvent event, Emitter<CreatePlaceState> emit) async {
    final state = this.state;
    if (state is CreatePlaceDataState) {
      emit(CreatePlaceLoadingState());
      final placeRequest = PlaceRequest(
        name: state.name,
        lat: double.parse(state.lat),
        lng: double.parse(state.lon),
        urls: state.uploadedImages,
        description: state.desc,
        placeType: state.category,
      );

      try {
        await _placeInteractor.addNewPlace(place: placeRequest);
        emit(CreatePlaceSuccessState());
      } catch (e) {
        emit(CreatePlaceErrorState());
      }
    }
  }
}
