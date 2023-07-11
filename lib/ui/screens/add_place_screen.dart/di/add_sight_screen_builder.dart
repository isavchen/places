import 'package:flutter/cupertino.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/ui/screens/add_place_screen.dart/add_sight_screen_wm.dart';
import 'package:provider/provider.dart';

AddSightScreenWm createAddSightScreenWm(BuildContext context) {
  return AddSightScreenWm(
    context.read<PlaceInteractor>(),
  );
}
