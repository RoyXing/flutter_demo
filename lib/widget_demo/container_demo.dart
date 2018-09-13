import 'package:flutter/material.dart';

class ContainerDemo extends StatefulWidget{

  @override
  ContainerDemoState createState() {
    return new ContainerDemoState();
  }
}

class ContainerDemoState extends State<ContainerDemo> {
  var currentColor = Colors.purple;

  Container topView(BuildContext context){
    return new Container(
      alignment:Alignment.center,
      padding: const EdgeInsets.all(8.0),
      constraints: new BoxConstraints.expand(
          height: Theme.of(context).textTheme.display1.fontSize*1.1+200.0
      ),

      decoration: new BoxDecoration(
          border: new Border.all(width: 2.0,color: Colors.red),
          color: Colors.cyanAccent,
          borderRadius: new BorderRadius.all(new Radius.circular(20.0)),
          image: new DecorationImage(
            fit: BoxFit.fill,
            image: new NetworkImage('http://a.hiphotos.baidu.com/image/h%3D300/sign=381f7e282b9759ee555066cb82fa434e/0dd7912397dda1449dd17697bfb7d0a20cf4863e.jpg'),
//             centerSlice: new Rect.fromLTRB(0.0, 180.0, 1360.0, 730.0)
          )),
      child: new Text("Container demo",style: Theme.of(context).textTheme.display1.copyWith(color: Colors.black),),
      transform: new Matrix4.rotationZ(0.3),
    );
  }

  Container buttonView1(){
    return Container(
      height: 30.0,
      color: Colors.purple,
      child: new Text(''),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,

      children: <Widget>[
        topView(context),
        Padding(padding: const EdgeInsets.symmetric(vertical: 50.0),),
        new LYRoundButton(
          title: new Text('I am a default button',
          style: new TextStyle(
            fontSize: 18.0,
            color: Colors.white
          ),),
          onPress: (){
            final snackBar = new SnackBar(content: new Text("click one"));
            Scaffold.of(context).showSnackBar(snackBar);
          },
        ),
        Padding(padding: const EdgeInsets.symmetric(vertical: 10.0),),
        new LYRoundButton(
          height: 80.0,
          width: 250.0,
          backgroundColor: const Color(0xFF41CB39),
          activeBackgroundColor: const Color(0xB341CB39),
          disableBackgroundColor: const Color(0x3341CB39),
          title: new Text('I am a default button',
          style: new TextStyle(
            fontSize: 18.0,
            color: Colors.white
          ),),
          onPress: (){
            final snackBar = new SnackBar(content: new Text("click Two"));
            Scaffold.of(context).showSnackBar(snackBar);
          },
        ),
        Padding(padding: const EdgeInsets.symmetric(vertical: 10.0),),
        new LYRoundButton(
          title: new Text('I am a disable button',
          style: new TextStyle(
            fontSize: 18.0,
            color: Colors.white
          ),),
          disabled: true,
          onPress: (){
            final snackBar = new SnackBar(content: new Text("click Three"));
            Scaffold.of(context).showSnackBar(snackBar);
          },
        ),
      ],
    );
  }
}

class LYRoundButton extends StatefulWidget{

  static const defaultBackgroundColor = const Color(0xFF8B5FFE);
  static const defaultActiveBackgroundColor = const Color(0xB38B5FFE);
  static const defaultDisableBackgroundColor = const Color(0x338B5FFE);


  LYRoundButton({
    this.title,
    this.onPress,
    this.height = 52.0,
    this.width= double.infinity,
    this.disabled = false,
    this.backgroundColor = defaultBackgroundColor,
    this.activeBackgroundColor = defaultActiveBackgroundColor,
    this.disableBackgroundColor = defaultDisableBackgroundColor
  });

  final Widget title;
  final Color backgroundColor,activeBackgroundColor,disableBackgroundColor;
  final VoidCallback onPress;
  final double height,width;
  final bool disabled;

  @override
  LYRoundButtonState createState() {
    return new LYRoundButtonState();
  }
}

class LYRoundButtonState extends State<LYRoundButton> {

  Color currentColor;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.disabled){
      currentColor = widget.disableBackgroundColor;
    }else{
      currentColor = widget.backgroundColor;
    }
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    currentColor = widget.backgroundColor;
  }

  @override
  Widget build(BuildContext context) {
   return new GestureDetector(
     onTap: (){
       if(widget.onPress!=null&&!widget.disabled){
         widget.onPress();
       }
     },
     onTapDown: (TapDownDetails details){
       if(!widget.disabled){
         setState(() {
           currentColor = widget.activeBackgroundColor;
         });
       }
     },
     onTapUp: (TapUpDetails details){
       if(!widget.disabled){
         setState(() {
           currentColor = widget.backgroundColor;
         });
       }
     },
     onTapCancel: (){
       if(!widget.disabled){
         setState(() {
           currentColor = widget.backgroundColor;
         });
       }
     },

     child: new Container(
       decoration: new BoxDecoration(
         color: currentColor,
         borderRadius: new BorderRadius.all(new Radius.circular(widget.height/2)),
       ),
       height: widget.height,
       width: widget.width,
       alignment: Alignment.center,
       child: widget.title,
     ),
   );
  }
}