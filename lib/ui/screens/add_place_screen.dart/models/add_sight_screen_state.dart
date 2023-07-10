import 'package:relation/relation.dart';

class AddSightScreenState {
  StreamedState<bool> loadingCreatingPlace = StreamedState(false);
  StreamedState<bool> isPhotoUploading = StreamedState(false);
  StreamedState<bool> isFormValid = StreamedState(false);
  StreamedState<List<String>> uploadedImages = StreamedState<List<String>>([]);
  StreamedState<String> category = StreamedState<String>('');
  StreamedState<String> name = StreamedState<String>('');
  StreamedState<double?> lat = StreamedState<double?>(null);
  StreamedState<double?> lon = StreamedState<double?>(null);
  StreamedState<String> desc = StreamedState<String>('');

  AddSightScreenState();
}
