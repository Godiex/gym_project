import 'package:flutter/material.dart';
import 'package:gym/configs/images.dart';
import 'package:gym/data/menu_options.dart';

import '../../../../domain/entities/plan.dart';

class PlanCustomerCard extends StatelessWidget {
  final Color color;
  final Routine routine;
  final int index;

  const PlanCustomerCard(this.color, this.routine, this.index);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) {
        final itemHeight = constrains.maxHeight;
        final itemWidth = constrains.maxWidth;

        return Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.bottomCenter,
              child: _Shadows(color: color, width: itemWidth * 0.82),
            ),
            Material(
                color: color,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  splashColor: Colors.white10,
                  highlightColor: Colors.white10,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      _buildPokeballDecoration(height: itemHeight),
                      _buildCircleDecoration(height: itemHeight),
                      _CardContent(
                          routine.name!,
                          routine.training!,
                          index == 1
                              ? 'Lunes'
                              : index == 2
                                  ? 'Martes'
                                  : index == 3
                                      ? 'Miercoles'
                                      : index == 4
                                          ? 'Jueves'
                                          : 'Viernes'),
                    ],
                  ),
                ))
          ],
        );
      },
    );
  }

  Widget _buildCircleDecoration({required double height}) {
    return Positioned(
      top: -height * 0.616,
      left: -height * 0.53,
      child: CircleAvatar(
        radius: (height * 1.03) / 2,
        backgroundColor: Colors.white.withOpacity(0.14),
      ),
    );
  }

  Widget _buildPokeballDecoration({required double height}) {
    return Positioned(
      top: -height * 0.16,
      right: -height * 0.25,
      child: Image(
        image: AppImages.pokeball,
        width: height * 1.388,
        height: height * 1.388,
        color: Colors.white.withOpacity(0.14),
      ),
    );
  }
}

class _CardContent extends StatelessWidget {
  const _CardContent(this.name, this.training, this.dayOfWeek);

  final String name;
  final String training;
  final String dayOfWeek;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Expanded(
                flex: 2,
                child: Text(
                  dayOfWeek,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    height: 2,
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                )),
            Expanded(
                flex: 3,
                child: Text(
                  name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    height: 2,
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                )),
            Expanded(
                flex: 6,
                child: Text(
                  textAlign: TextAlign.left,
                  training,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                )),
          ],
        ));
  }
}

class _Shadows extends StatelessWidget {
  const _Shadows({required this.color, required this.width});

  final Color color;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width * 0.82,
      height: 11,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: color,
            offset: Offset(0, 3),
            blurRadius: 23,
          ),
        ],
      ),
    );
  }
}
