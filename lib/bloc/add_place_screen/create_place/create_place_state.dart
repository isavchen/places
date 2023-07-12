part of 'create_place_bloc.dart';

abstract class CreatePlaceState extends Equatable {
  const CreatePlaceState();

  @override
  List<Object> get props => [];
}

class CreatePlaceDataState extends CreatePlaceState {
  final List<String> uploadedImages;
  final String category;
  final String name;
  final String lat;
  final String lon;
  final String desc;
  final bool isFormValid;

  CreatePlaceDataState({
    required this.uploadedImages,
    required this.category,
    required this.name,
    required this.lat,
    required this.lon,
    required this.desc,
    required this.isFormValid,
  });

  CreatePlaceDataState copyWith({
    List<String>? uploadedImages,
    String? category,
    String? name,
    String? lat,
    String? lon,
    String? desc,
    bool? isFormValid,
  }) {
    return CreatePlaceDataState(
      uploadedImages: uploadedImages ?? this.uploadedImages,
      category: category ?? this.category,
      name: name ?? this.name,
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
      desc: desc ?? this.desc,
      isFormValid: isFormValid ?? this.isFormValid,
    );
  }

  @override
  List<Object> get props =>
      [uploadedImages, category, name, lat, lon, desc, isFormValid];
}

class CreatePlaceLoadingState extends CreatePlaceState {}

class CreatePlaceSuccessState extends CreatePlaceState {}

class CreatePlaceErrorState extends CreatePlaceState {}
