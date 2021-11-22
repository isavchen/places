import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/ui/res/assets.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/widget/page_indicator.dart';

class SightDetailsBottomsheet extends StatefulWidget {
  const SightDetailsBottomsheet({Key? key}) : super(key: key);

  @override
  State<SightDetailsBottomsheet> createState() =>
      _SightDetailsBottomsheetState();
}

class _SightDetailsBottomsheetState extends State<SightDetailsBottomsheet> {
  PageController _pageController = PageController();

  List<String> gallery = [
    'https://cdn.turkishairlines.com/m/4118b6df9b5d7df7/original/Travel-Guide-of-Kiev-via-Turkish-Airlines.jpg',
    'http://thenewcamera.com/wp-content/uploads/2019/09/Fuji-X-A7-sample-image-1.jpg',
    'https://images.unsplash.com/photo-1612151855475-877969f4a6cc?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8aGQlMjBpbWFnZXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&w=1000&q=80',
  ];

  void _pageChanged(int index) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: _pageChanged,
                  itemCount: gallery.length,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16.0),
                        topRight: Radius.circular(16.0),
                      ),
                      child: Image.network(
                        gallery[index],
                        fit: BoxFit.cover,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return Center(
                            child: Platform.isAndroid
                                ? CircularProgressIndicator(
                                    color: Color(0xFF252849),
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  )
                                : CupertinoActivityIndicator.partiallyRevealed(
                                    progress: loadingProgress
                                                .expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : 0,
                                  ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
              Positioned(
                top: 16,
                right: 16,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Icon(
                      Icons.close,
                      color: Theme.of(context).colorScheme.secondary,
                      size: 24,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0.0,
                child: PageIndicator(
                  width: MediaQuery.of(context).size.width / gallery.length,
                  controller: _pageController,
                  itemCount: gallery.length,
                  selectedColor: Theme.of(context).focusColor,
                  normalColor: Colors.transparent,
                ),
              ),
              Positioned(
                top: 12.0,
                left: MediaQuery.of(context).size.width / 2 - 20,
                child: Container(
                  height: 4.0,
                  width: 40.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 24,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                //TODO: выводить название места
                "Пряности и радости",
                style: Theme.of(context).primaryTextTheme.headline5,
              ),
              Row(
                children: [
                  Text(
                    //TODO: выводить тип места
                    "ресторан",
                    style: Theme.of(context).primaryTextTheme.subtitle2,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      //TODO: выводить время работы места
                      "закрыто до 09:00",
                      style: Theme.of(context).primaryTextTheme.bodyText2,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                //TODO: выводить описание места
                "Пряный вкус радостной жизни вместе с шеф-поваром Изо Дзандзава, благодаря которой у гостей ресторана есть возможность выбирать из двух направлений: европейского и восточного. ",
                style: Theme.of(context)
                    .primaryTextTheme
                    .bodyText2
                    ?.copyWith(color: Theme.of(context).focusColor),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: ElevatedButton(
                  onPressed: () {
                    //TODO: функционал кнопки
                    print("Кнопка Построить  маршрут нажата");
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(icRoute),
                        SizedBox(
                          width: 10,
                        ),
                        Text('sight_details.route'.tr()),
                      ],
                    ),
                  ),
                ),
              ),
              Divider(
                height: 0.8,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          //TODO: функционал кнопки
                          print("Кнопка Запланировать");
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                icCalendar,
                                width: 22,
                                color: dmInactiveColor,
                              ),
                              SizedBox(
                                width: 9,
                              ),
                              Text(
                                'sight_details.schedule'.tr(),
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .bodyText2,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          //TODO: функционал кнопки
                          print("Кнопка В Избранное");
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                icHeart,
                                width: 20,
                                color: Theme.of(context).focusColor,
                              ),
                              SizedBox(
                                width: 9,
                              ),
                              Text(
                                'sight_details.to_favorite'.tr(),
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .bodyText2
                                    ?.copyWith(
                                        color: Theme.of(context).focusColor),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
