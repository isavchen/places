import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/styles.dart';
import 'package:places/ui/screens/choose_category_screen.dart';
import 'package:places/ui/widget/image_dialog.dart';
import 'package:places/ui/widget/new_photo_card.dart';
import 'package:places/ui/widget/overscroll_glow_absorber.dart';

class AddSightScreen extends StatefulWidget {
  const AddSightScreen({Key? key}) : super(key: key);

  @override
  _AddSightScreenState createState() => _AddSightScreenState();
}

class _AddSightScreenState extends State<AddSightScreen> {
  String category = '';
  TextEditingController titleTextEditingController = TextEditingController();
  TextEditingController latTextEditingController = TextEditingController();
  TextEditingController lonTextEditingController = TextEditingController();
  TextEditingController descTextEditingController = TextEditingController();
  FocusNode titleFocusNode = FocusNode();
  FocusNode latFocusNode = FocusNode();
  FocusNode lonFocusNode = FocusNode();
  FocusNode descFocusNode = FocusNode();

  List<String> photoList = [];

  bool isValid() {
    if (titleTextEditingController.text.isNotEmpty &&
        latTextEditingController.text.isNotEmpty &&
        lonTextEditingController.text.isNotEmpty &&
        descTextEditingController.text.isNotEmpty &&
        category.isNotEmpty &&
        photoList.isNotEmpty) return true;
    return false;
  }

  @override
  void initState() {
    super.initState();
    titleTextEditingController.addListener(() {
      setState(() {});
    });
    latFocusNode.addListener(() {
      setState(() {});
    });
    lonFocusNode.addListener(() {
      setState(() {});
    });
    descFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    titleFocusNode.dispose();
    latFocusNode.dispose();
    lonFocusNode.dispose();
    descFocusNode.dispose();
    super.dispose();
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
            primary: dmSecondaryColor2,
            textStyle: Theme.of(context).primaryTextTheme.subtitle1,
          ),
        ),
        leadingWidth: 100,
        elevation: 0,
      ),
      body: SafeArea(
        child: OverscrollGlowAbsorber(
          child: ListView(
            physics: Platform.isIOS
                ? BouncingScrollPhysics()
                : ClampingScrollPhysics(),
            children: [
              // Блок добавления фотографии
              Container(
                height: 120,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      NewPhotoCard(
                        isAddButton: true,
                        imageUrl: "",
                        key: ValueKey("addbutton"),
                        onPressed: () {
                          _openImagePicker(context);
                        },
                      ),
                      // for (final photo in photoList)
                      for (int i = 0; i < photoList.length; i++)
                        NewPhotoCard(
                          imageUrl: photoList[i],
                          key:
                              UniqueKey(), //ValueKey(id),  заменить на ValueKey(id) на основе id сущности при работе с сетью.
                          onDelete: () {
                            setState(() {
                              photoList.removeAt(i);
                            });
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
                        final category1 = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChooseCategory()),
                        );
                        titleFocusNode.requestFocus();
                        if (category1 != null) {
                          setState(() {
                            category = category1;
                          });
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        height: 24,
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              category.isEmpty
                                  ? 'add_sight.not_selected'.tr()
                                  : category,
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .subtitle1
                                  ?.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: dmSecondaryColor2,
                                  ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Theme.of(context).colorScheme.secondary,
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
                        setState(() {});
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                setState(() {});
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                setState(() {});
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
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) {
                        descFocusNode.unfocus();
                      },
                      onChanged: (String val) {
                        setState(() {});
                      },
                      style:
                          Theme.of(context).primaryTextTheme.subtitle1?.copyWith(
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                      decoration: InputDecoration(
                        hintText: 'add_sight.enter_description'.tr(),
                        hintStyle: dmMatBodyText2.copyWith(fontSize: 16.0),
                        suffixIcon: descFocusNode.hasFocus &&
                                descTextEditingController.text.isNotEmpty
                            ? InkWell(
                                onTap: () {
                                  descTextEditingController.clear();
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
                            color: Theme.of(context).errorColor,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(
                            width: 2.0,
                            color: Theme.of(context).errorColor,
                          ),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      // кнопка создать

      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: ElevatedButton(
            onPressed: isValid()
                ? () {
                    mocks.add(
                      Sight(
                        id: mocks.last.id + 1,
                        name: titleTextEditingController.text.trim(),
                        lat: double.parse(latTextEditingController.text.trim()),
                        lon: double.parse(lonTextEditingController.text.trim()),
                        url: photoList.first,
                        details: descTextEditingController.text.trim(),
                        galery: photoList,
                        type: category.toLowerCase(),
                      ),
                    );
                    Navigator.of(context).pop(true);
                  }
                : null,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Text('add_sight.create_button'.tr().toUpperCase()),
            ),
          ),
        ),
      ),
    );
  }

  void _openImagePicker(BuildContext context) async {
    final res = await showDialog(
      context: context,
      builder: (_) {
        return ImageDialog();
      },
    );
    if (res != null) {
      setState(() {
        switch (res) {
          case 'camera':
            photoList.add(
                "http://thenewcamera.com/wp-content/uploads/2019/09/Fuji-X-A7-sample-image-1.jpg");
            break;
          case 'photo':
            photoList.add(
                "https://cdn.turkishairlines.com/m/4118b6df9b5d7df7/original/Travel-Guide-of-Kiev-via-Turkish-Airlines.jpg");
            break;
          case 'file':
            photoList.add(
                "https://www.dreamsbook.com.ua/uploads/15747xJILGQdTEiVPzpKH.jpg");
            break;
        }
      });
    }
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
      style: Theme.of(context).primaryTextTheme.subtitle1?.copyWith(
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
            color: Theme.of(context).errorColor,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            width: 2.0,
            color: Theme.of(context).errorColor,
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
