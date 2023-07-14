part of 'upload_photo_bloc.dart';

abstract class UploadPhotoState extends Equatable {
  const UploadPhotoState();

  @override
  List<Object> get props => [];
}

class UploadPhotoInitialState extends UploadPhotoState {}

class UploadPhotoUploadingState extends UploadPhotoState {}

class UploadPhotoUploadErrorState extends UploadPhotoState {}
