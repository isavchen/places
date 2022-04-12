import 'package:places/domain/category.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/res/assets.dart';

final List<Sight> mocks = [
  Sight(
    id: 1,
    name: "1",
    lat: 50.414363,
    lon: 30.529344,
    url:
        "http://thenewcamera.com/wp-content/uploads/2019/09/Fuji-X-A7-sample-image-1.jpg",
    details: "Lorem Ipsum is simply .",
    type: "музей",
    galery: [
      'https://cdn.turkishairlines.com/m/4118b6df9b5d7df7/original/Travel-Guide-of-Kiev-via-Turkish-Airlines.jpg',
      "https://helpx.adobe.com/content/dam/help/en/photoshop/using/convert-color-image-black-white/jcr_content/main-pars/before_and_after/image-before/Landscape-Color.jpg",
      'http://thenewcamera.com/wp-content/uploads/2019/09/Fuji-X-A7-sample-image-1.jpg',
      'https://images.pexels.com/photos/533769/pexels-photo-533769.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
      'https://images.unsplash.com/photo-1612151855475-877969f4a6cc?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8aGQlMjBpbWFnZXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&w=1000&q=80',
    ],
  ),
  Sight(
    id: 2,
    name: "2",
    lat: 50.456206,
    lon: 30.548504,
    url:
        "http://thenewcamera.com/wp-content/uploads/2019/09/Fuji-X-A7-sample-image-1.jpg",
    details:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
    type: "музей",
    galery: [
      'https://images.pexels.com/photos/257499/pexels-photo-257499.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
      'https://images.pexels.com/photos/967070/pexels-photo-967070.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
      'https://images.pexels.com/photos/1730403/pexels-photo-1730403.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
    ],
  ),
  Sight(
    id: 3,
    name: "3",
    lat: 30.548504,
    lon: 1.2222,
    url:
        "https://helpx.adobe.com/content/dam/help/en/photoshop/using/convert-color-image-black-white/jcr_content/main-pars/before_and_after/image-before/Landscape-Color.jpg",
    details:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
    type: "парк",
    galery: [
      'https://images.pexels.com/photos/1730403/pexels-photo-1730403.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
    ],
  ),
  Sight(
    id: 4,
    name: "4",
    lat: 50.456206,
    lon: 30.548504,
    url:
        "https://helpx.adobe.com/content/dam/help/en/photoshop/using/convert-color-image-black-white/jcr_content/main-pars/before_and_after/image-before/Landscape-Color.jpg",
    details:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
    type: "особое место",
    galery: [
      'https://images.pexels.com/photos/1637802/pexels-photo-1637802.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
      'https://images.pexels.com/photos/997608/pexels-photo-997608.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
    ],
  ),
  Sight(
    id: 5,
    name: "5",
    lat: 50.456206,
    lon: 30.548504,
    url:
        "http://thenewcamera.com/wp-content/uploads/2019/09/Fuji-X-A7-sample-image-1.jpg",
    details:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
    type: "музей",
    galery: [
      'https://images.pexels.com/photos/257499/pexels-photo-257499.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
      'https://images.pexels.com/photos/967070/pexels-photo-967070.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
      'https://images.pexels.com/photos/1730403/pexels-photo-1730403.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
    ],
  ),
  Sight(
    id: 6,
    name: "6",
    lat: 50.414363,
    lon: 30.529344,
    url:
        "http://thenewcamera.com/wp-content/uploads/2019/09/Fuji-X-A7-sample-image-1.jpg",
    details:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
    type: "кафе",
    galery: [
      'https://images.pexels.com/photos/2084291/pexels-photo-2084291.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
      'https://images.pexels.com/photos/1579262/pexels-photo-1579262.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
      'https://images.pexels.com/photos/257385/pexels-photo-257385.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
      'https://images.pexels.com/photos/257499/pexels-photo-257499.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
      'https://images.pexels.com/photos/967070/pexels-photo-967070.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
    ],
  ),
  Sight(
    id: 7,
    name: "7",
    lat: 50.456206,
    lon: 30.548504,
    url:
        "http://thenewcamera.com/wp-content/uploads/2019/09/Fuji-X-A7-sample-image-1.jpg",
    details:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
    type: "отель",
    galery: [
      'https://images.pexels.com/photos/1637802/pexels-photo-1637802.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
      'https://images.pexels.com/photos/997608/pexels-photo-997608.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
    ],
  ),
  Sight(
    id: 8,
    name: "8",
    lat: 50.456206,
    lon: 30.548504,
    url:
        "http://thenewcamera.com/wp-content/uploads/2019/09/Fuji-X-A7-sample-image-1.jpg",
    details:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
    type: "ресторан",
    galery: [
      'http://thenewcamera.com/wp-content/uploads/2019/09/Fuji-X-A7-sample-image-1.jpg',
      'https://images.pexels.com/photos/533769/pexels-photo-533769.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
      'https://images.unsplash.com/photo-1612151855475-877969f4a6cc?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8aGQlMjBpbWFnZXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&w=1000&q=80',
    ],
  ),
  Sight(
    id: 9,
    name: "9",
    lat: 50.456206,
    lon: 30.548504,
    url:
        "http://thenewcamera.com/wp-content/uploads/2019/09/Fuji-X-A7-sample-image-1.jpg",
    details:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
    type: "отель",
    galery: [
      'https://images.pexels.com/photos/257499/pexels-photo-257499.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
      'https://images.pexels.com/photos/967070/pexels-photo-967070.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
      'https://images.pexels.com/photos/1730403/pexels-photo-1730403.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
    ],
  ),
  Sight(
    id: 10,
    name: "10",
    lat: 50.456206,
    lon: 30.548504,
    url:
        "https://helpx.adobe.com/content/dam/help/en/photoshop/using/convert-color-image-black-white/jcr_content/main-pars/before_and_after/image-before/Landscape-Color.jpg",
    details:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
    type: "особое место",
    galery: [
      "https://helpx.adobe.com/content/dam/help/en/photoshop/using/convert-color-image-black-white/jcr_content/main-pars/before_and_after/image-before/Landscape-Color.jpg",
      'https://images.pexels.com/photos/317372/pexels-photo-317372.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
    ],
  ),
];

final List mocksCategory = [
  Category(
    name: "Храм",
    img: icTemple,
  ),
  Category(
    name: "Памятник",
    img: icMonument,
  ),
  Category(
    name: "Парк",
    img: icPark,
  ),
  Category(
    name: "Театр",
    img: icTheatre,
  ),
  Category(
    name: "Музей",
    img: icMuseum,
  ),
  Category(
    name: "Отель",
    img: icHotel,
  ),
  Category(
    name: "Ресторан",
    img: icRestaurant,
  ),
  Category(
    name: "Кафе",
    img: icCafe,
  ),
  Category(
    name: "Остальное",
    img: icOther,
  ),
];
