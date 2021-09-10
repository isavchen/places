import 'dart:io';

import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/styles.dart';
import 'package:places/ui/widget/choose_category.dart';
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

  List<String> photoList = [
    "http://thenewcamera.com/wp-content/uploads/2019/09/Fuji-X-A7-sample-image-1.jpg",
    "https://cdn.turkishairlines.com/m/4118b6df9b5d7df7/original/Travel-Guide-of-Kiev-via-Turkish-Airlines.jpg",
    "https://cdn2.civitatis.com/ucrania/kiev/free-tour-kiev.jpg",
    "http://thenewcamera.com/wp-content/uploads/2019/09/Fuji-X-A7-sample-image-1.jpg",
  ];

  bool isValid() {
    if (titleTextEditingController.text.isNotEmpty &&
        latTextEditingController.text.isNotEmpty &&
        lonTextEditingController.text.isNotEmpty &&
        descTextEditingController.text.isNotEmpty &&
        category.isNotEmpty) return true;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Новое место"),
        automaticallyImplyLeading: false,
        leading: TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Отмена"),
          style: TextButton.styleFrom(
            primary: dmSecondaryColor2,
            textStyle: Theme.of(context).primaryTextTheme.subtitle1,
          ),
        ),
        leadingWidth: 100,
        elevation: 0,
      ),
      body: OverscrollGlowAbsorber(
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
                        setState(() {
                          photoList.add(
                              "https://cdn2.civitatis.com/ucrania/kiev/free-tour-kiev.jpg");
                        });
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
                    "КАТЕГОРИЯ",
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
                            category.isEmpty ? "Не выбрано" : category,
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
                            color: Theme.of(context).accentColor,
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
              height: 68.0,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "НАЗВАНИЕ",
                    style: smallText.copyWith(fontSize: 12.0),
                  ),
                  MyTextField(
                    hintText: "введите название",
                    controller: titleTextEditingController,
                    focus: titleFocusNode,
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
              height: 68.0,
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
                            "ШИРОТА",
                            style: smallText.copyWith(fontSize: 12.0),
                          ),
                          MyTextField(
                            hintText: "введите широту",
                            controller: latTextEditingController,
                            focus: latFocusNode,
                            textInputAction: TextInputAction.next,
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
                            "ДОЛГОТА",
                            style: smallText.copyWith(fontSize: 12.0),
                          ),
                          MyTextField(
                            hintText: "введите долготу",
                            controller: lonTextEditingController,
                            focus: lonFocusNode,
                            textInputAction: TextInputAction.next,
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
                  print("Указать на карте");
                },
                child: Text("Указать на карте"),
              ),
            ),
            SizedBox(height: 37.0),

            //текстовое поле ввода описания
            Container(
              height: 108.0,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "ОПИСАНИЕ",
                    style: smallText.copyWith(fontSize: 12.0),
                  ),
                  TextField(
                    maxLines: 3,
                    controller: descTextEditingController,
                    focusNode: descFocusNode,
                    textInputAction: TextInputAction.done,
                    onSubmitted: (_) {
                      descFocusNode.unfocus();
                    },
                    onChanged: (String val) {
                      setState(() {});
                    },
                    style:
                        Theme.of(context).primaryTextTheme.subtitle1?.copyWith(
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).accentColor,
                            ),
                    decoration: InputDecoration(
                      hintText: 'введите текст',
                      hintStyle: dmMatBodyText2.copyWith(fontSize: 16.0),
                      suffixIcon: descFocusNode.hasFocus &&
                              descTextEditingController.text.isNotEmpty
                          ? InkWell(
                              onTap: () {
                                descTextEditingController.clear();
                              },
                              child: Icon(
                                Icons.cancel_rounded,
                                color: Theme.of(context).accentColor,
                              ),
                            )
                          : null,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(
                          width: 2.0,
                          color: Theme.of(context).buttonColor.withOpacity(0.4),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(
                          color: Theme.of(context).buttonColor.withOpacity(0.4),
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

      // кнопка создать

      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: ElevatedButton(
            onPressed: isValid()
                ? () {
                    mocks.add(Sight(
                        name: titleTextEditingController.text,
                        lat: double.parse(latTextEditingController.text),
                        lon: double.parse(lonTextEditingController.text),
                        url:
                            "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/1280px-Image_created_with_a_mobile_phone.png",
                        details: descTextEditingController.text,
                        type: category));
                    Navigator.of(context).pop();
                  }
                : null,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Text("СОЗДАТЬ"),
            ),
          ),
        ),
      ),
    );
  }
}

class MyTextField extends StatelessWidget {
  final String? hintText;
  final TextEditingController controller;
  final FocusNode focus;
  final TextInputAction textInputAction;
  final Function(String) onSubmitted;
  final Function(String) onChanged;
  const MyTextField({
    Key? key,
    required this.controller,
    required this.focus,
    required this.textInputAction,
    required this.onSubmitted,
    required this.onChanged,
    this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focus,
      textInputAction: textInputAction,
      onSubmitted: onSubmitted,
      cursorColor: Theme.of(context).accentColor,
      onChanged: onChanged,
      style: Theme.of(context).primaryTextTheme.subtitle1?.copyWith(
            fontWeight: FontWeight.w400,
            color: Theme.of(context).accentColor,
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
                  color: Theme.of(context).accentColor,
                ),
              )
            : null,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            width: 2.0,
            color: Theme.of(context).buttonColor.withOpacity(0.4),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: Theme.of(context).buttonColor.withOpacity(0.4),
          ),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      ),
    );
  }
}
