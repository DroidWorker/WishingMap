import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wishmap/data/models.dart';
import 'dart:math';
import 'package:flutter/physics.dart';

import '../navigation/navigation_block.dart';

class CircleWidget extends StatefulWidget {
  final Circle circle;
  final double size;
  final Function(double) onRotate;
  final Function(DragEndDetails) onEndRotate;

  CircleWidget({Key? key, required this.circle, required this.size, required this.onRotate, required this.onEndRotate}) : super(key: key);

  @override
  _CircleWidgetState createState() => _CircleWidgetState();
}

class _CircleWidgetState extends State<CircleWidget> {
  double startAngle = 0.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        BlocProvider.of<NavigationBloc>(context)
            .add(NavigateToSpheresOfLifeScreenEvent());
      },
      onPanStart: (details) {
        final centerX = (widget.size / 2)-10;
        final centerY = widget.size / 2;
        startAngle = atan2(details.localPosition.dy - centerY, details.localPosition.dx - centerX);
      },
      onPanUpdate: (details) {
        final centerX = (widget.size / 2)-10;
        final centerY = widget.size / 2;
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
        width: 40.0,
        height: 40.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: widget.circle.color,
        ),
        child: Text(
          widget.circle.text,
          style: const TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
class CircularDraggableCircles extends StatefulWidget {
  final List<Circle> circles;
  final double size;

  const CircularDraggableCircles({super.key, required this.circles, required this.size});

  @override
  _CircularDraggableCirclesState createState() => _CircularDraggableCirclesState();
}

class _CircularDraggableCirclesState extends State<CircularDraggableCircles> with SingleTickerProviderStateMixin{
  List<Offset> circlePositions = [];
  List<double> circleRotations = [];

  double lastRotation = 0.0;
  double inertia = 0.0;
  late AnimationController ctrl;

  @override
  void initState() {
    super.initState();
    ctrl = AnimationController.unbounded(vsync: this);
    for (int i = 0; i < widget.circles.length; i++) {
      final x = ((widget.size/2)-10) + (widget.size-2*widget.circles.first.radius)/2 * cos(2 * pi * i / widget.circles.length);
      final y = (widget.size/2-10) + (widget.size-2*widget.circles.first.radius)/2 * sin(2 * pi * i / widget.circles.length);
      circlePositions.add(Offset(x, y));
      circleRotations.add(2 * pi * i / widget.circles.length);
    }
  }
  @override
  void dispose() {
    ctrl.dispose();
    super.dispose();
  }
  void startInertia(double velocity) {
    ctrl.animateWith(
      FrictionSimulation(
        0.05, // Коэффициент трения (настройте по своему усмотрению)
        ctrl.value,
        velocity / 100, // Скорость инерции (настройте по своему усмотрению)
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: widget.size,
        height: widget.size,
        child: AnimatedBuilder(
          animation: ctrl,
          builder: (context, child){
            final newRotation = ctrl.value - lastRotation;
            lastRotation = ctrl.value;
            if(ctrl.isAnimating) _updateCircleRotation(newRotation, widget.size, (widget.size-2*widget.circles.first.radius)/2, isAnim: true);
            return Stack(
              children: [
                ...widget.circles.asMap().entries.map((entry) {
                  final index = entry.key;
                  final circle = entry.value;

                  return Positioned(
                    left: circlePositions[index].dx,
                    top: circlePositions[index].dy,
                    child: CircleWidget(
                      circle: circle,
                      size: widget.size,
                      onRotate: (angle) {
                        _updateCircleRotation(angle, widget.size, (widget.size-2*widget.circles.first.radius)/2);
                      },
                      onEndRotate: (details){
                        startInertia(details.velocity.pixelsPerSecond.dx);
                      },
                    ),
                  );
                }).toList(),
                Positioned(
                  left: widget.size/2-30,
                  top: widget.size/2-30,
                  child: Container(
                      width: 60.0,
                      height: 60.0,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black87,
                      ),
                      child: const Column(children: [
                        SizedBox(height: 10,),
                        Text(
                          "Я",
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "состояние",
                          style: TextStyle(color: Colors.white, fontSize: 10),
                          textAlign: TextAlign.center,
                        ),
                      ],)
                  ),
                ),
              ],
            );
          },
        )
    );
  }

  void _updateCircleRotation(double newRotation, double size, double radius, {bool isAnim = false}) {
    final centerX = size / 2 - 10;
    final centerY = size / 2 -10;

    for (int i = 0; i < widget.circles.length; i++) {
      final oldRotation = circleRotations[i];

      // Вычисляем новый угол поворота, учитывая старый угол и новый угол
      final newRotationInRadians = (oldRotation + newRotation);

      // Вычисляем новые координаты на основе нового угла поворота, радиуса и центральных координат
      final newX = centerX + radius * cos(newRotationInRadians);
      final newY = centerY + radius * sin(newRotationInRadians);

      // Обновляем позицию каждой окружности и угол поворота
      circlePositions[i] = Offset(newX, newY);
      circleRotations[i] = oldRotation+newRotation;
    }

    // Вызываем setState, чтобы обновить виджет
    if(!isAnim)setState(() {});
  }


}
