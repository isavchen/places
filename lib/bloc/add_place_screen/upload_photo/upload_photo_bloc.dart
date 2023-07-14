import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:places/bloc/add_place_screen/create_place/create_place_bloc.dart';
import 'package:places/data/interactor/place_interactor.dart';

part 'upload_photo_event.dart';
part 'upload_photo_state.dart';

class UploadPhotoBloc extends Bloc<UploadPhotoEvent, UploadPhotoState> {
  final PlaceInteractor _placeInteractor;
  final CreatePlaceBloc _createPlaceBloc;
  UploadPhotoBloc(this._placeInteractor, this._createPlaceBloc)
      : super(UploadPhotoInitialState()) {
    on<AddPhotoEvent>(_addPhoto);
  }

  Future<void> _addPhoto(
      AddPhotoEvent event, Emitter<UploadPhotoState> emit) async {
    emit(UploadPhotoUploadingState());
    try {
      final photoPath = await _placeInteractor.addImage(image: event.photo);
      _createPlaceBloc.add(AddUploadingPhotoEvent(photoPath: photoPath));
      emit(UploadPhotoInitialState());
    } catch (e) {
      emit(UploadPhotoUploadErrorState());
    }
  }
}
