import 'package:places/domain/category.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/res/assets.dart';

final List mocks = [
  Sight(
    name: "Золотые ворота",
    lat: 50.414363,
    lon: 30.529344,
    url:
        "http://thenewcamera.com/wp-content/uploads/2019/09/Fuji-X-A7-sample-image-1.jpg",
    details:
        "Lorem Ipsum is simply .",
    type: "Музей",
  ),
  Sight(
    name: "Золотые ворота",
    lat: 50.456206,
    lon: 30.548504,
    url:
        "http://thenewcamera.com/wp-content/uploads/2019/09/Fuji-X-A7-sample-image-1.jpg",
    details:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
    type: "Музей",
  ),
  Sight(
    name: "Андреевский спуск в Киеве",
    lat: 30.548504,
    lon: 1.2222,
    url:
        "https://cdn.turkishairlines.com/m/4118b6df9b5d7df7/original/Travel-Guide-of-Kiev-via-Turkish-Airlines.jpg",
    details:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
    type: "Парк",
  ),
  Sight(
    name: "Крещатик",
    lat: 50.456206,
    lon: 30.548504,
    url: "https://cdn2.civitatis.com/ucrania/kiev/free-tour-kiev.jpg",
    details:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
    type: "Особое место",
  ),
  Sight(
    name: "Пирогово",
    lat: 50.456206,
    lon: 30.548504,
    url:
        "http://thenewcamera.com/wp-content/uploads/2019/09/Fuji-X-A7-sample-image-1.jpg",
    details:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
    type: "Музей",
  ),
  Sight(
    name: "Кафе",
    lat: 50.414363,
    lon: 30.529344,
    url:
        "http://thenewcamera.com/wp-content/uploads/2019/09/Fuji-X-A7-sample-image-1.jpg",
    details:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
    type: "Кафе",
  ),
  Sight(
    name: "Отель",
    lat: 50.456206,
    lon: 30.548504,
    url:
        "http://thenewcamera.com/wp-content/uploads/2019/09/Fuji-X-A7-sample-image-1.jpg",
    details:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
    type: "Отель",
  ),
  Sight(
    name: "Ресторан",
    lat: 50.456206,
    lon: 30.548504,
    url:
        "http://thenewcamera.com/wp-content/uploads/2019/09/Fuji-X-A7-sample-image-1.jpg",
    details:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
    type: "Ресторан",
  ),
  Sight(
    name: "Отель",
    lat: 50.456206,
    lon: 30.548504,
    url:
        "http://thenewcamera.com/wp-content/uploads/2019/09/Fuji-X-A7-sample-image-1.jpg",
    details:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
    type: "Отель",
  ),
  Sight(
    name: "Особое место",
    lat: 50.456206,
    lon: 30.548504,
    url: "https://cdn2.civitatis.com/ucrania/kiev/free-tour-kiev.jpg",
    details:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
    type: "Особое место",
  ),
];

final List mocksCategory = [
  Category(
    name: "Отель",
    img: icHotel,
  ),
  Category(
    name: "Ресторан",
    img: icRestaurant,
  ),
  Category(
    name: "Особое место",
    img: icStar,
  ),
  Category(
    name: "Парк",
    img: icPark,
  ),
  Category(
    name: "Музей",
    img: icMuseum,
  ),
  Category(
    name: "Кафе",
    img: icCafe,
  ),
];
