part of 'create_place_bloc.dart';

abstract class CreatePlaceEvent extends Equatable {
  const CreatePlaceEvent();

  @override
  List<Object> get props => [];
}

class AddUploadingPhotoEvent extends CreatePlaceEvent {
  final String photoPath;
  const AddUploadingPhotoEvent({required this.photoPath});

  @override
  List<Object> get props => [photoPath];
}

class RemoveUploadingPhoto extends CreatePlaceEvent {
  final String photoPath;

  RemoveUploadingPhoto({required this.photoPath});

  @override
  List<Object> get props => [photoPath];
}

class AddCategoryEvent extends CreatePlaceEvent {
  final String category;
  const AddCategoryEvent({required this.category});

  @override
  List<Object> get props => [category];
}

class AddNameEvent extends CreatePlaceEvent {
  final String name;
  const AddNameEvent({required this.name});

  @override
  List<Object> get props => [name];
}

class AddLatEvent extends CreatePlaceEvent {
  final String lat;
  const AddLatEvent({required this.lat});
}

class AddLonEvent extends CreatePlaceEvent {
  final String lon;
  const AddLonEvent({required this.lon});
}

class AddDescriptionEvent extends CreatePlaceEvent {
  final String desc;
  const AddDescriptionEvent({required this.desc});

  @override
  List<Object> get props => [desc];
}

class StartCreatePlaceEvent extends CreatePlaceEvent {}
