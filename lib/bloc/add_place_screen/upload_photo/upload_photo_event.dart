part of 'upload_photo_bloc.dart';

abstract class UploadPhotoEvent extends Equatable {
  const UploadPhotoEvent();

  @override
  List<Object> get props => [];
}

class AddPhotoEvent extends UploadPhotoEvent {
  final File photo;

  AddPhotoEvent(this.photo);

  @override
  List<Object> get props => [photo];
}

// class RemovePhotoEvent extends UploadPhotoEvent {
//   final String photoPath;

//   RemovePhotoEvent({required this.photoPath});

//   @override
//   List<Object> get props => [photoPath];
// }
