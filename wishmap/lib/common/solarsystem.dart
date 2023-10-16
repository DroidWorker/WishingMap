import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:wishmap/data/models.dart';
import 'dart:math';
import 'package:flutter/physics.dart';

import '../repository/Repository.dart';

class CircleWidget extends StatefulWidget {
  final itemId;
  final Circle circle;
  final double size;
  final Function(double) onRotate;
  final Function(DragEndDetails) onEndRotate;
  final Function(int id, int itemId) startMoving;

  CircleWidget({Key? key,required this.itemId, required this.circle, required this.size, required this.onRotate, required this.onEndRotate, required this.startMoving}) : super(key: key);

  @override
  _CircleWidgetState createState() => _CircleWidgetState();
}

class _CircleWidgetState extends State<CircleWidget>{
  double startAngle = 0.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        widget.startMoving(widget.circle.id, widget.itemId);
      },
      onPanStart: (details) {
        final centerX = widget.size/2-40;
        final centerY = widget.size/2-40;
        startAngle = atan2(details.localPosition.dy - centerY, details.localPosition.dx - centerX);
      },
      onPanUpdate: (details) {
        final centerX = widget.size/2-40;
        final centerY = widget.size/2-40;
        final currentAngle = atan2(details.localPosition.dy - centerY, details.localPosition.dx - centerX);
        double difference = (currentAngle - startAngle + pi) % (2 * pi) - pi;
        final angleChange = difference < -pi ? difference + 2 * pi : difference;

        startAngle = currentAngle;
        widget.onRotate(angleChange);
      },
      onPanEnd: (details) {
        widget.onEndRotate(details);
      },
      child: Container(
        width: widget.circle.radius.toDouble(),
        height: widget.circle.radius.toDouble(),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: widget.circle.color,
        ),
        child: Center( // Используйте Center, чтобы разместить текст по центру
          child: AutoSizeText(
            widget.circle.text,
            maxLines: 1,
            style: const TextStyle(color: Colors.white, fontSize: 16),
            textAlign: TextAlign.center,
          )
        ),
      ),
    );
  }
}
class CircularDraggableCircles extends StatefulWidget {
  List<Circle> circles;
  List<MainCircle> centralCircles;
  double size;
  Pair center;

  CircularDraggableCircles({super.key, required this.circles, required this.centralCircles, required this.size, required this.center});

  @override
  _CircularDraggableCirclesState createState() => _CircularDraggableCirclesState();
}

class _CircularDraggableCirclesState extends State<CircularDraggableCircles> with TickerProviderStateMixin {
  List<Offset> circlePositions = [];
  List<double> circleRotations = [];
  List<Offset> plusesPositions = [];
  List<double> plusesRotations = [];

  double lastRotation = 0.0;
  double inertia = 0.0;
  late AnimationController ctrl;

  double widgetTop = 0.0;
  double widgetLeft = 0.0;
  double alphaAnimValue = 1.0;
  late Animation<double> AlphaAnimation;
  late Animation<double> ReverceAlphaAnimation;
  late AnimationController movingController;
  late AnimationController afterMovingController;
  bool animationDirectionForward = true;
  //late Size screenSize;

  Size getScreenSize(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    return mediaQueryData.size;
  }

  @override
  void initState() {
    super.initState();
    ctrl = AnimationController.unbounded(vsync: this);
    movingController = AnimationController.unbounded(vsync: this);
    afterMovingController = AnimationController.unbounded(vsync: this);
    final angleBetween = 2*pi/widget.circles.length;
    for (int i = 0; i < widget.circles.length; i++) {
      final x = widget.center.key-40 + (widget.size-widget.circles[i].radius)/2 * cos(2 * pi * i / widget.circles.length);
      final y = widget.center.value-40 + (widget.size-widget.circles[i].radius)/2 * sin(2 * pi * i / widget.circles.length);
      circlePositions.add(Offset(x, y));
      circleRotations.add(2 * pi * i / widget.circles.length);
      final px = widget.center.key-40 + (widget.size-widget.circles[i].radius)/2 * cos((2 * pi * i / widget.circles.length)+angleBetween/2);
      final py = widget.center.value-40 + (widget.size-widget.circles[i].radius)/2 * sin((2 * pi * i / widget.circles.length)+angleBetween/2);
      plusesPositions.add(Offset(px,py));
      plusesRotations.add((2 * pi * i / widget.circles.length)+angleBetween/2);
    }
    //screenSize = getScreenSize(this as BuildContext);
    movingController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000), // Длительность анимации
    );
    afterMovingController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700), // Длительность анимации
    );
    AlphaAnimation = Tween(begin: 1.0, end: 0.0).animate(movingController);
    ReverceAlphaAnimation = Tween(begin: 0.0, end: 1.0).animate(afterMovingController);
    movingController.addStatusListener(animStatusListener);
  }
  @override
  void dispose() {
    ctrl.dispose();
    super.dispose();
  }
  void startInertia(double velocity) {
    ctrl.animateWith(
      FrictionSimulation(
        0.1, // Коэффициент трения (настройте по своему усмотрению)
        ctrl.value,
        velocity / 100, // Скорость инерции (настройте по своему усмотрению)
      ),
    );
  }

  void initAnim(int id, int itemId){
    final initialTop = animationDirectionForward?widget.center.value-widget.centralCircles.last.radius:-50.0;//widget.centralCircles.last.coords.value;
    final initialLeft = animationDirectionForward?widget.center.key-widget.centralCircles.last.radius:widget.center.key * 2 - 100;//widget.centralCircles.last.coords.key;
    final finalTop = animationDirectionForward?-50.0:widget.center.value-widget.centralCircles[widget.centralCircles.length-2].radius;
    final finalRight = animationDirectionForward?widget.center.key * 2 - 100:widget.center.key-widget.centralCircles[widget.centralCircles.length-2].radius;

    final radiusToCenterInitialTop = animationDirectionForward?circlePositions[itemId].dy:widget.center.value - 40;
    final radiusToCenterInitialLeft = animationDirectionForward?circlePositions[itemId].dx:widget.center.key - 40;
    final radiusToCenterFinalTop = animationDirectionForward?widget.center.value - 40:circlePositions[itemId].dy;
    final radiusToCenterFinalLeft = animationDirectionForward?widget.center.key - 40:circlePositions[itemId].dx;
    //duplicate clicked sphere
    if(animationDirectionForward) {
      widget.centralCircles.add(MainCircle(id: id,
          coords: Pair(key: circlePositions[itemId].dx,
              value: circlePositions[itemId].dy),
          text: widget.circles[itemId].text,
          textSize: 12,
          color: widget.circles[itemId].color,
          radius: widget.circles[itemId].radius / 2));
      if (widget.centralCircles.length > 2) {
        widget.centralCircles[widget.centralCircles
            .length - 3].isVisible = false;
      }
      AlphaAnimation = Tween(begin: 1.0, end: 0.0).animate(movingController);
      ReverceAlphaAnimation = Tween(begin: 0.0, end: 1.0).animate(afterMovingController);
    }else{
      AlphaAnimation = Tween(begin: 0.0, end: 1.0).animate(movingController);
      ReverceAlphaAnimation = Tween(begin: 1.0, end: 0.0).animate(afterMovingController);
    }

    // Создаем анимацию перемещения виджета
    final Vanimation = Tween(
        begin: initialTop, end: finalTop).animate(
      CurvedAnimation(
        parent: movingController,
        // controller - это объект AnimationController
        curve: Curves
            .easeInOut, // Вы можете выбрать другую кривую анимации
      ),
    );
    final Hanimation = Tween(
        begin: initialLeft, end: finalRight).animate(
      CurvedAnimation(
        parent: movingController,
        // controller - это объект AnimationController
        curve: Curves
            .easeInOut, // Вы можете выбрать другую кривую анимации
      ),
    );
    final radiusToCenterVanimation = Tween(
        begin: radiusToCenterInitialTop,
        end: radiusToCenterFinalTop).animate(
      CurvedAnimation(
        parent: movingController,
        // controller - это объект AnimationController
        curve: Curves
            .easeInOut, // Вы можете выбрать другую кривую анимации
      ),
    );
    final radiusToCenterHanimation = Tween(
        begin: radiusToCenterInitialLeft,
        end: radiusToCenterFinalLeft).animate(
      CurvedAnimation(
        parent: movingController,
        // controller - это объект AnimationController
        curve: Curves
            .easeInOut, // Вы можете выбрать другую кривую анимации
      ),
    );
    // Добавляем слушателя анимации для обновления состояния и перерисовки виджета
    Vanimation.addListener(() {
      setState(() {
        widget.centralCircles[widget.centralCircles
            .length - 2].coords.value =
            Vanimation.value;
      });
    });
    Hanimation.addListener(() {
      setState(() {
        widget.centralCircles[widget.centralCircles
            .length - 2].coords.key =
            Hanimation.value;
      });
    });
    radiusToCenterVanimation.addListener(() {
      setState(() {
        widget.centralCircles[widget.centralCircles
            .length - 1].coords.value =
            radiusToCenterVanimation.value;
      });
    });
    radiusToCenterHanimation.addListener(() {
      setState(() {
        widget.centralCircles[widget.centralCircles
            .length - 1].coords.key =
            radiusToCenterHanimation.value;
      });
    });
    AlphaAnimation.addListener(() {
      setState(() {
        alphaAnimValue = AlphaAnimation.value;
      });
    });
    ReverceAlphaAnimation.addListener(() {
      setState(() {
        alphaAnimValue = ReverceAlphaAnimation.value;
      });
    });
  }

  void animStatusListener(status){
    if (status == AnimationStatus.completed) {
      if(animationDirectionForward){
        widget.circles = Repository.getChildrenSpheres(2);
        circlePositions.clear();
        circleRotations.clear();
        plusesPositions.clear();
        plusesRotations.clear();
        final angleBetween = 2*pi/widget.circles.length;
        for (int i = 0; i < widget.circles.length; i++) {
          final x = widget.center.key-40 + (widget.size-widget.circles[i].radius)/2 * cos(2 * pi * i / widget.circles.length);
          final y = widget.center.value-40 + (widget.size-widget.circles[i].radius)/2 * sin(2 * pi * i / widget.circles.length);
          circlePositions.add(Offset(x, y));
          circleRotations.add(2 * pi * i / widget.circles.length);
          final px = widget.center.key-40 + (widget.size-widget.circles[i].radius)/2 * cos((2 * pi * i / widget.circles.length)+angleBetween/2);
          final py = widget.center.value-40 + (widget.size-widget.circles[i].radius)/2 * sin((2 * pi * i / widget.circles.length)+angleBetween/2);
          plusesPositions.add(Offset(px,py));
          plusesRotations.add((2 * pi * i / widget.circles.length)+angleBetween/2);
        }
        afterMovingController.reset();
        afterMovingController.forward();
      }else{{
        if(widget.centralCircles.length>2){
          widget.centralCircles[widget.centralCircles.length-3].isVisible = true;
        }
        setState(() {
          print("before rem ${widget.centralCircles.length}");
          widget.centralCircles.removeLast();
          print("after rem ${widget.centralCircles.length}");
        });
      }}
    }
  }

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i<widget.centralCircles.length; i++) {
      if(widget.centralCircles[i].coords.key==0.0||widget.centralCircles[i].coords.value==0.0) {
        widget.centralCircles[i].coords = Pair(key: widget.center.key-widget.centralCircles[i].radius, value: widget.center.value-widget.centralCircles[i].radius);
      }
    }

    return Container(
        child: AnimatedBuilder(
          animation: ctrl,
          builder: (context, child){
            final newRotation = ctrl.value - lastRotation;
            lastRotation = ctrl.value;
            if(ctrl.isAnimating) _updateCircleRotation(newRotation, widget.size, widget.center, (widget.size-widget.circles.first.radius)/2, isAnim: true);
            return Stack(
              children: [
                Positioned(
                  left: widget.center.key+40-widget.size/2,
                  top: widget.center.value+40-widget.size/2,
                  child:
                  Container(
                    width: widget.size-80, // Ширина контейнера
                    height: widget.size-80, // Высота контейнера
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.transparent,
                        border: Border.all(color:  Colors.grey, width: 2)
                    ),
                    child: const SizedBox(),
                  ),),
                ...circlePositions.asMap().entries.map((e) {
                  return Positioned(
                    left: plusesPositions[e.key].dx+35,
                    top: plusesPositions[e.key].dy+35,
                    child:
                      Container(
                        width: 10, // Ширина контейнера
                        height: 10, // Высота контейнера
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey,
                        ),
                        child: const Center(
                          child: Text("+", style: TextStyle(fontSize: 10, color: Colors.white),),
                        ),
                      ));
                }
                ),
                ...widget.circles.asMap().entries.map((entry) {
                  final index = entry.key;
                  final circle = entry.value;

                  return Positioned(
                    left: circlePositions[index].dx,
                    top: circlePositions[index].dy,
                    child: AnimatedBuilder(
                      animation: AlphaAnimation,
                      builder: (context, child) {
                        return Opacity(
                          opacity: alphaAnimValue,
                          child: CircleWidget(
                            itemId: index,
                            circle: circle,
                            size: widget.size,
                            onRotate: (angle) {
                              _updateCircleRotation(angle, widget.size, widget.center, (widget.size-widget.circles.first.radius)/2);
                            },
                            onEndRotate: (details){
                              startInertia(details.velocity.pixelsPerSecond.dx);
                            },
                            startMoving: (id, itemId) {
                              animationDirectionForward = true;
                              initAnim(id, itemId);
                              // Запускаем анимацию
                              movingController.reset(); // Сбрасываем анимацию
                              movingController.forward(); // Запускаем анимаци

                            })
                        );
                      },
                    )
                  );
                }).toList(),
                ...widget.centralCircles.asMap().entries.where((entry) {
                  return entry.value.isVisible; // Фильтруем элементы по условию isVisible
                }).map((entry){
                  final index = entry.key;
                  final value = entry.value;
                  return Positioned(
                    left: value.coords.key,
                    top: value.coords.value,
                    child: GestureDetector(
                      child: Container(
                          width: value.radius*2,
                          height: value.radius*2,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: value.color,
                          ),
                          child: Center(
                              child: IntrinsicHeight(
                                child: Column(children: [
                                  const SizedBox(height: 5,),
                                  Text(
                                    value.text,
                                    style: TextStyle(color: Colors.white, fontSize: (value.textSize).toDouble()),
                                    textAlign: TextAlign.center,
                                  ),
                                  AnimatedBuilder(
                                    animation: AlphaAnimation,
                                    builder: (context, child) {
                                      return Opacity(
                                        opacity: AlphaAnimation.value,
                                        child: const Text(
                                          "состояние",
                                          style: TextStyle(color: Colors.white, fontSize: 10),
                                          textAlign: TextAlign.center,
                                        ),
                                      );
                                    },
                                  )
                                ],),
                              )
                          )
                      ),
                      onTap: (){
                        animationDirectionForward= false;
                        //afterMovingController.reverse();
                        widget.circles = Repository.getChildrenSpheres(value.id);
                        circleRotations.clear();
                        circlePositions.clear();
                        plusesPositions.clear();
                        plusesRotations.clear();
                        final angleBetween = 2*pi/widget.circles.length;
                        for (int i = 0; i < widget.circles.length; i++) {
                          final x = widget.center.key-40 + (widget.size-widget.circles[i].radius)/2 * cos(2 * pi * i / widget.circles.length);
                          final y = widget.center.value-40 + (widget.size-widget.circles[i].radius)/2 * sin(2 * pi * i / widget.circles.length);
                          circlePositions.add(Offset(x, y));
                          circleRotations.add(2 * pi * i / widget.circles.length);
                          final px = widget.center.key-40 + (widget.size-widget.circles[i].radius)/2 * cos((2 * pi * i / widget.circles.length)+angleBetween/2);
                          final py = widget.center.value-40 + (widget.size-widget.circles[i].radius)/2 * sin((2 * pi * i / widget.circles.length)+angleBetween/2);
                          plusesPositions.add(Offset(px,py));
                          plusesRotations.add((2 * pi * i / widget.circles.length)+angleBetween/2);
                        }
                        initAnim(widget.centralCircles.last.id, widget.circles.indexWhere((element) => element.id==widget.centralCircles.last.id));
                        movingController.reset();
                        movingController.forward();
                      },
                    )
                  );
                }).toList()
              ],
            );
          },
        )
    );
  }

  void _updateCircleRotation(double newRotation, double size, Pair center, double radius, {bool isAnim = false}) {
    final centerX = widget.center.key-40;
    final centerY = widget.center.value-40;

    for (int i = 0; i < widget.circles.length; i++) {
      final oldRotation = circleRotations[i];
      final oldPlusRotation = plusesRotations[i];

      // Вычисляем новый угол поворота, учитывая старый угол и новый угол
      final newRotationInRadians = (oldRotation + newRotation);
      final newPlusRotationInRadians = (oldPlusRotation + newRotation);

      // Вычисляем новые координаты на основе нового угла поворота, радиуса и центральных координат
      final newX = centerX + radius * cos(newRotationInRadians);
      final newY = centerY + radius * sin(newRotationInRadians);
      final newPlusX = centerX + radius * cos(newPlusRotationInRadians);
      final newPlusY = centerY + radius * sin(newPlusRotationInRadians);

      // Обновляем позицию каждой окружности и угол поворота
      circlePositions[i] = Offset(newX, newY);
      circleRotations[i] = oldRotation+newRotation;
      plusesPositions[i] = Offset(newPlusX, newPlusY);
      plusesRotations[i] = oldPlusRotation+newRotation;
    }

    // Вызываем setState, чтобы обновить виджет
    if(!isAnim)setState(() {});
  }
}
