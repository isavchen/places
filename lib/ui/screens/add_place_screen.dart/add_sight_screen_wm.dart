import 'dart:io';

import 'package:mwwm/mwwm.dart';
import 'package:places/data/exceptions/network_exception.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/model/request/place_request.dart';
import 'package:places/ui/screens/add_place_screen.dart/models/add_sight_screen_state.dart';
import 'package:relation/relation.dart';

class AddSightScreenWm extends WidgetModel {
  final PlaceInteractor _placeInteractor;
  final AddSightScreenState state;
  AddSightScreenWm(this._placeInteractor)
      : state = AddSightScreenState(),
        super(const WidgetModelDependencies());

  final creatingPlaceState = EntityStreamedState();

  Future<void> addImage({required File image}) async {
    state.isPhotoUploading.accept(true);
    try {
      final imagePath = await _placeInteractor.addImage(image: image);
      state.isPhotoUploading.accept(false);
      state.uploadedImages.accept(state.uploadedImages.value..add(imagePath));
      _validateForm();
    } on NetworkException catch (e) {
      state.isPhotoUploading.accept(false);
      print("catch an error = $e");
    }
  }

  void removeImage({required String image}) {
    state.uploadedImages.accept(state.uploadedImages.value..remove(image));
    _validateForm();
  }

  void addCategory({required String category}) {
    state.category.accept(category);
    _validateForm();
  }

  void addName({required String name}) {
    state.name.accept(name);
    _validateForm();
  }

  void addLocation({required double point, required bool isLat}) {
    switch (isLat) {
      case true:
        state.lat.accept(point);
        break;
      default:
        state.lon.accept(point);
    }
    _validateForm();
  }

  void addDescription({required String desc}) {
    state.desc.accept(desc);
    _validateForm();
  }

  void _validateForm() {
    if (state.name.value.isNotEmpty &&
        state.lat.value != null &&
        state.lon.value != null &&
        state.desc.value.isNotEmpty &&
        state.category.value.isNotEmpty &&
        state.uploadedImages.value.isNotEmpty)
      state.isFormValid.accept(true);
    else
      state.isFormValid.accept(false);
  }

  Future<void> createPlace() async {
    state.loadingCreatingPlace.accept(true);
    final placeRequest = PlaceRequest(
      name: state.name.value,
      lat: state.lat.value!,
      lng: state.lon.value!,
      urls: state.uploadedImages.value,
      description: state.desc.value,
      placeType: state.category.value,
    );

    try {
      await _placeInteractor.addNewPlace(place: placeRequest);
      state.loadingCreatingPlace.accept(false);
    } on NetworkException catch (e) {
      state.loadingCreatingPlace.accept(false);
      print("catch an error = $e");
    }
  }
}
