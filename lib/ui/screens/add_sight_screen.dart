import 'dart:io';

import 'package:camera/camera.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:places/bloc/add_place_screen/create_place/create_place_bloc.dart';
import 'package:places/bloc/add_place_screen/upload_photo/upload_photo_bloc.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/styles.dart';
import 'package:places/ui/screens/camera_screen.dart';
import 'package:places/ui/screens/choose_category_screen.dart';
import 'package:places/ui/widget/gradient_progress_indicator.dart';
import 'package:places/ui/widget/image_dialog.dart';
import 'package:places/ui/widget/new_photo_card.dart';
import 'package:places/ui/widget/overscroll_glow_absorber.dart';

class AddSightScreen extends StatefulWidget {
  const AddSightScreen({Key? key}) : super(key: key);

  @override
  _AddSightScreenState createState() => _AddSightScreenState();
}

class _AddSightScreenState extends State<AddSightScreen> {
  late CreatePlaceBloc _createPlaceBloc;
  late UploadPhotoBloc _uploadPhotoBloc;
  TextEditingController titleTextEditingController = TextEditingController();
  TextEditingController latTextEditingController = TextEditingController();
  TextEditingController lonTextEditingController = TextEditingController();
  TextEditingController descTextEditingController = TextEditingController();
  FocusNode titleFocusNode = FocusNode();
  FocusNode latFocusNode = FocusNode();
  FocusNode lonFocusNode = FocusNode();
  FocusNode descFocusNode = FocusNode();

  @override
  void initState() {
    _createPlaceBloc = CreatePlaceBloc(
      context.read<PlaceInteractor>(),
    );
    _uploadPhotoBloc = UploadPhotoBloc(
      context.read<PlaceInteractor>(),
      _createPlaceBloc,
    );
    super.initState();
  }

  String? requiredValidator(String? value) {
    if (value != null && value.trim().length > 0) {
      return null;
    } else {
      return 'add_sight.validate.required_field'.tr();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('add_sight.app_bar.title'.tr()),
        automaticallyImplyLeading: false,
        leading: TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('add_sight.app_bar.leading'.tr()),
          style: TextButton.styleFrom(
            foregroundColor: dmSecondaryColor2,
            textStyle: Theme.of(context).primaryTextTheme.titleMedium,
          ),
        ),
        leadingWidth: 100,
        elevation: 0,
      ),
      body: SafeArea(
        child: BlocConsumer<CreatePlaceBloc, CreatePlaceState>(
          bloc: _createPlaceBloc,
          listener: (context, state) {
            if (state is CreatePlaceSuccessState) {
              Navigator.of(context).pop(true);
            } else if (state is CreatePlaceErrorState) {
              Navigator.of(context).pop(false);
            }
          },
          builder: (context, state) {
            if (state is CreatePlaceLoadingState) {
              return Center(
                child: Container(
                  width: 40,
                  height: 40,
                  child: GradientProgressIndicator(
                    progress: 0.8,
                    strokeWidth: 6.0,
                    backgroundColor: Theme.of(context).colorScheme.background,
                    gradient: SweepGradient(
                      colors: [
                        Theme.of(context).colorScheme.secondaryContainer,
                        Theme.of(context).colorScheme.background,
                      ],
                    ),
                  ),
                ),
              );
            }
            if (state is CreatePlaceDataState) {
              return OverscrollGlowAbsorber(
                child: ListView(
                  physics: Platform.isIOS
                      ? BouncingScrollPhysics()
                      : ClampingScrollPhysics(),
                  children: [
                    // Блок добавления фотографии
                    Container(
                      height: 120,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 8.0),
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            NewPhotoCard(
                              isAddButton: true,
                              imageUrl: "",
                              key: ValueKey("addbutton"),
                              onPressed: () {
                                _openImagePicker();
                              },
                            ),
                            for (int i = 0;
                                i < state.uploadedImages.length;
                                i++)
                              NewPhotoCard(
                                imageUrl: state.uploadedImages[i],
                                key: ValueKey(
                                  state.uploadedImages[i],
                                ),
                                onDelete: () {
                                  _createPlaceBloc.add(
                                    RemoveUploadingPhoto(
                                      photoPath: state.uploadedImages[i],
                                    ),
                                  );
                                },
                              ),
                            BlocConsumer<UploadPhotoBloc, UploadPhotoState>(
                              bloc: _uploadPhotoBloc,
                              listener: (context, state) {
                                if (state is UploadPhotoUploadErrorState) {
                                  ScaffoldMessenger.of(context)
                                      .clearSnackBars();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'add_place.error_upload_photo'.tr(),
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .bodyMedium
                                            ?.copyWith(
                                                color: Theme.of(context)
                                                    .primaryColor),
                                      ),
                                      action: SnackBarAction(
                                        label: 'snackbar.close'.tr(),
                                        textColor: lmGreenColor,
                                        onPressed: () {
                                          // Some code to undo the change.
                                        },
                                      ),
                                    ),
                                  );
                                }
                              },
                              builder: (context, state) {
                                if (state is UploadPhotoUploadingState) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: 72.0,
                                      height: 72.0,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        color: lmInactiveColor,
                                      ),
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                return SizedBox.shrink();
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Поле выбора категории
                    Container(
                      height: 64.0,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'add_sight.category'.tr().toUpperCase(),
                            style: smallText.copyWith(fontSize: 12.0),
                          ),
                          InkWell(
                            onTap: () async {
                              final data = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChooseCategory()),
                              );
                              titleFocusNode.requestFocus();
                              if (data != null) {
                                _createPlaceBloc.add(
                                  AddCategoryEvent(category: data),
                                );
                              }
                            },
                            child: Container(
                              width: double.infinity,
                              height: 24,
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    state.category.isEmpty
                                        ? 'add_sight.not_selected'.tr()
                                        : "plase.type.${state.category}".tr(),
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .titleMedium
                                        ?.copyWith(
                                          fontWeight: FontWeight.w400,
                                          color: dmSecondaryColor2,
                                        ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 0, child: Divider()),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.0),

                    // Текстовое поле ввода названия
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'add_sight.sight_name'.tr().toUpperCase(),
                            style: smallText.copyWith(fontSize: 12.0),
                          ),
                          MyTextField(
                            hintText: 'add_sight.enter_name'.tr().toLowerCase(),
                            controller: titleTextEditingController,
                            focus: titleFocusNode,
                            validator: requiredValidator,
                            textInputAction: TextInputAction.next,
                            onSubmitted: (_) {
                              latFocusNode.requestFocus();
                            },
                            onChanged: (String val) {
                              _createPlaceBloc.add(
                                AddNameEvent(
                                  name: val.trim(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.0),

                    // Текстовые поля ввода долготы и широты

                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'add_sight.latitude'.tr().toUpperCase(),
                                    style: smallText.copyWith(fontSize: 12.0),
                                  ),
                                  MyTextField(
                                    hintText: 'add_sight.enter_latitude'.tr(),
                                    controller: latTextEditingController,
                                    focus: latFocusNode,
                                    textInputAction: TextInputAction.next,
                                    validator: requiredValidator,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9\.]'),
                                      ),
                                    ],
                                    onSubmitted: (_) {
                                      lonFocusNode.requestFocus();
                                    },
                                    onChanged: (String val) {
                                      _createPlaceBloc.add(
                                        AddLatEvent(
                                          lat: val.trim(),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 16.0,
                          ),
                          Expanded(
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'add_sight.longitude'.tr().toUpperCase(),
                                    style: smallText.copyWith(fontSize: 12.0),
                                  ),
                                  MyTextField(
                                    hintText: 'add_sight.enter_longitude'.tr(),
                                    controller: lonTextEditingController,
                                    focus: lonFocusNode,
                                    textInputAction: TextInputAction.next,
                                    validator: requiredValidator,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9\.]'),
                                      ),
                                    ],
                                    onSubmitted: (_) {
                                      descFocusNode.requestFocus();
                                    },
                                    onChanged: (String val) {
                                      _createPlaceBloc.add(
                                        AddLonEvent(
                                          lon: val.trim(),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    //кнопка выбора местоположения на карте
                    SizedBox(height: 5.0),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: () {
                          //TODO: функионал кнопки "Указать на карте"
                          print("Указать на карте");
                        },
                        child: Text('add_sight.point_on_map'.tr()),
                      ),
                    ),
                    SizedBox(height: 37.0),

                    //текстовое поле ввода описания
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'add_sight.description'.tr().toUpperCase(),
                            style: smallText.copyWith(fontSize: 12.0),
                          ),
                          TextFormField(
                            maxLines: 3,
                            controller: descTextEditingController,
                            focusNode: descFocusNode,
                            validator: requiredValidator,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            textInputAction: TextInputAction.done,
                            onFieldSubmitted: (_) {
                              descFocusNode.unfocus();
                            },
                            onChanged: (String val) {
                              _createPlaceBloc.add(
                                AddDescriptionEvent(
                                  desc: val.trim(),
                                ),
                              );
                            },
                            style: Theme.of(context)
                                .primaryTextTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                            decoration: InputDecoration(
                              hintText: 'add_sight.enter_description'.tr(),
                              hintStyle:
                                  dmMatBodyText2.copyWith(fontSize: 16.0),
                              suffixIcon: descFocusNode.hasFocus &&
                                      descTextEditingController.text.isNotEmpty
                                  ? InkWell(
                                      onTap: () {
                                        descTextEditingController.clear();
                                      },
                                      child: Icon(
                                        Icons.cancel_rounded,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                      ),
                                    )
                                  : null,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide(
                                  width: 2.0,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .surface
                                      .withOpacity(0.4),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .surface
                                      .withOpacity(0.4),
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.error,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide(
                                  width: 2.0,
                                  color: Theme.of(context).colorScheme.error,
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 10),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
            throw ArgumentError('Wrong state in AddSightScreen');
          },
        ),
      ),

      // кнопка создать

      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: BlocBuilder<CreatePlaceBloc, CreatePlaceState>(
            bloc: _createPlaceBloc,
            builder: (context, state) {
              bool isFormValid = false;
              if (state is CreatePlaceDataState) {
                isFormValid = state.isFormValid;
              }
              return ElevatedButton(
                onPressed: isFormValid
                    ? () => _createPlaceBloc.add(StartCreatePlaceEvent())
                    : null,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: Text('add_sight.create_button'.tr().toUpperCase()),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _openImagePicker() async {
    final res = await showDialog(
      context: context,
      builder: (_) {
        return ImageDialog();
      },
    );
    if (res != null) {
      switch (res) {
        case 'camera':
          _openCamerePage();
          break;
        case 'photo':
          _openGallery();
          break;
        case 'file':
          //TODO: change to file
          _openGallery();
          break;
      }
    }
  }

  void _openGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) _uploadPhotoBloc.add(AddPhotoEvent(File(image.path)));
  }

  void _openCamerePage() async {
    await availableCameras().then((value) async {
      if (value.isNotEmpty) {
        final image = await Navigator.push(context,
            MaterialPageRoute(builder: (_) => CameraScreen(cameras: value)));
        if (image != null) _uploadPhotoBloc.add(AddPhotoEvent(File(image)));
      } else {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'camera.not_available'.tr(),
              style: Theme.of(context)
                  .primaryTextTheme
                  .bodyMedium
                  ?.copyWith(color: Theme.of(context).primaryColor),
            ),
            action: SnackBarAction(
              label: 'snackbar.close'.tr(),
              textColor: lmGreenColor,
              onPressed: () {
                // Some code to undo the change.
              },
            ),
          ),
        );
      }
    });
  }
}

class MyTextField extends StatelessWidget {
  final String? hintText;
  final TextEditingController controller;
  final FocusNode focus;
  final TextInputAction textInputAction;
  final Function(String) onSubmitted;
  final Function(String) onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  const MyTextField({
    Key? key,
    required this.controller,
    required this.focus,
    required this.textInputAction,
    required this.onSubmitted,
    required this.onChanged,
    this.hintText,
    this.inputFormatters,
    this.keyboardType,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focus,
      textInputAction: textInputAction,
      onFieldSubmitted: onSubmitted,
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      cursorColor: Theme.of(context).colorScheme.secondary,
      onChanged: onChanged,
      style: Theme.of(context).primaryTextTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w400,
            color: Theme.of(context).colorScheme.secondary,
          ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: dmMatBodyText2.copyWith(fontSize: 16.0),
        suffixIcon: focus.hasFocus && controller.text.isNotEmpty
            ? InkWell(
                onTap: () {
                  controller.clear();
                },
                child: Icon(
                  Icons.cancel_rounded,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              )
            : null,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            width: 2.0,
            color: Theme.of(context).colorScheme.surface.withOpacity(0.4),
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            width: 2.0,
            color: Theme.of(context).colorScheme.error,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.surface.withOpacity(0.4),
          ),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      ),
    );
  }
}
