import 'package:flutter/material.dart';

class SlideView extends StatefulWidget {
  SlideView(this.data);

  var data;

  @override
  SlideViewState createState() {
    return new SlideViewState(data);
  }
}

class SlideViewState extends State<SlideView>
    with SingleTickerProviderStateMixin {
  SlideViewState(this.data);

  List data;

  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController =
        new TabController(length: data == null ? 0 : data.length, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = [];
    if (data != null && data.length > 0) {
      for (var i = 0; i < data.length; i++) {
        var item = data[i];
        var imgUrl = item['imagePath'];
        var title = item['title'];
        item['link'] = item['url'];
        items.add(new GestureDetector(
          onTap: () {
            _handleOnItemClick(item);
          },
          child: AspectRatio(
            aspectRatio: 2.0,
            child: new Stack(
              children: <Widget>[
                new Image.network(
                  imgUrl,
                  fit: BoxFit.fill,
                  width: 1000.0,
                ),
                new Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: new Container(
                    width: 1000.0,
                    color: const Color(0x50000000),
                    padding: const EdgeInsets.all(5.0),
                    child: new Text(
                      title,
                      style: new TextStyle(color: Colors.white, fontSize: 15.0),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
      }
    }
    return new TabBarView(
      children: items,
      controller: tabController,
    );
  }

  void _handleOnItemClick(item) {

  }
}
