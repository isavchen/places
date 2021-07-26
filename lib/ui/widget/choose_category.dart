import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/res/assets.dart';

class ChooseCategory extends StatefulWidget {
  @override
  createState() {
    return ChooseCategoryState();
  }
}

class ChooseCategoryState extends State<ChooseCategory> {
  List<RadioModel> sampleData = [];
  String selectedCategory = '';

  @override
  void initState() {
    super.initState();
    for (final category in mocksCategory) {
      sampleData.add(RadioModel(false, category.name));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Категория'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 24.0,
          ),
          Expanded(
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: sampleData.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      sampleData
                          .forEach((element) => element.isSelected = false);
                      sampleData[index].isSelected = true;
                      selectedCategory = sampleData[index].text;
                    });
                  },
                  child: CategoryItem(sampleData[index]),
                );
              },
            ),
          ),

          Expanded(child: Container()),

          // кнопка сохранить
          SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: ElevatedButton(
                onPressed: selectedCategory.isEmpty
                    ? null
                    : () {
                        Navigator.pop(context, selectedCategory);
                      },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: Text("СОХРАНИТЬ"),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final RadioModel _item;
  CategoryItem(this._item);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 14.0, bottom: 14.0, right: 14.5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Text(
                  _item.text,
                  style: Theme.of(context).primaryTextTheme.subtitle1?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).accentColor,
                      ),
                ),
                _item.isSelected
                    ? SvgPicture.asset(
                        icSelect,
                        color: Theme.of(context).buttonColor,
                      )
                    : Container(),
              ],
            ),
          ),
          SizedBox(height: 0, child: Divider(height: 0.8)),
        ],
      ),
    );
  }
}

class RadioModel {
  bool isSelected;
  final String text;

  RadioModel(this.isSelected, this.text);
}
