import 'package:flutter/material.dart';

class AnimationWidget extends StatefulWidget {

  final Duration duration;
  final Widget child;
  final bool isAnimating;
  const AnimationWidget(this.duration,  this.child, this.isAnimating, { Key? key }) : super(key: key);

  @override
  State<AnimationWidget> createState() => _AnimationWidgetState();
}

class _AnimationWidgetState extends State<AnimationWidget> with SingleTickerProviderStateMixin{

  late AnimationController _animationController;
  late Animation<double> scale;


  @override
  void initState() {
  _animationController =AnimationController(vsync: this, duration: Duration(milliseconds: widget.duration.inMilliseconds ~/  2 ));
    super.initState();
    scale =  Tween<double>(begin: 1 , end: 1.2).animate(_animationController);
  }



@override
  void didUpdateWidget(covariant AnimationWidget oldWidget) {
   
    super.didUpdateWidget(oldWidget);

    if(widget.isAnimating != oldWidget.isAnimating){
           
           startAnimation();
      
    }
  }


 startAnimation() {

 }



  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}