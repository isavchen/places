import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SightDetailsScreen extends StatefulWidget {
  const SightDetailsScreen({Key? key}) : super(key: key);

  @override
  _SightDetailsScreenState createState() => _SightDetailsScreenState();
}

class _SightDetailsScreenState extends State<SightDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark));
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.green,
                  ),
                ),
                Positioned(
                  top: 36,
                  left: 16,
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Color(0xFF3B3E5B),
                      size: 20,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  child: Container(
                    width: 152.0,
                    height: 7.57,
                    decoration: BoxDecoration(
                      color: Color(0xFF3B3E5B),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                )
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Пряности и радости",
                    style: TextStyle(
                      fontFamily: "Roboto",
                      fontSize: 24.0,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF3B3E5B),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "ресторан",
                        style: TextStyle(
                          fontFamily: "Roboto",
                          fontSize: 14.0,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF3B3E5B),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text(
                          "закрыто до 09:00",
                          style: TextStyle(
                            fontFamily: "Roboto",
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF7C7E92),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Пряный вкус радостной жизни вместе с шеф-поваром Изо Дзандзава, благодаря которой у гостей ресторана есть возможность выбирать из двух направлений: европейского и восточного",
                style: TextStyle(
                  fontFamily: "Roboto",
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF3B3E5B),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 24.0,
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 13.0),
                decoration: BoxDecoration(
                  color: Color(0xFF4CAF50),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 15,
                      height: 15,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2),
                        color: Colors.transparent,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "ПОСТРОИТЬ МАРШРУТ",
                      style: TextStyle(
                        fontFamily: "Roboto",
                        fontSize: 14.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Divider(
                height: 0.8,
                color: Color.fromRGBO(124, 126, 146, 0.56),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 22,
                            height: 19,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color.fromRGBO(124, 126, 146, 0.56),
                                width: 2,
                              ),
                              color: Colors.transparent,
                            ),
                          ),
                          SizedBox(
                            width: 9,
                          ),
                          Text(
                            "Запланировать",
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color.fromRGBO(124, 126, 146, 0.56),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 22,
                            height: 19,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color(0xFF3B3E5B),
                                width: 2,
                              ),
                              color: Colors.transparent,
                            ),
                          ),
                          SizedBox(
                            width: 9,
                          ),
                          Text(
                            "В Избранное",
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF3B3E5B),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
