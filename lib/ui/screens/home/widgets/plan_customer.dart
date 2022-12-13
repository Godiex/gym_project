import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym/configs/colors.dart';
import 'package:gym/data/menu_options.dart';
import 'package:gym/data/repositories/plan_repository.dart';
import 'package:gym/states/user_info/user_info_bloc.dart';
import 'package:gym/ui/screens/home/widgets/plan_customer_card.dart';
import 'package:gym/ui/widgets/app_background.dart';

import '../../../../domain/entities/plan.dart';
import '../../../../routes.dart';
import '../../../widgets/dialog.dart';
import 'category_card.dart';

class PlanCustomer extends StatefulWidget {
  @override
  State<PlanCustomer> createState() => PlanCustomerState();
}

class PlanCustomerState extends State<PlanCustomer> {
  final globalDialog = GlobalWidgetDialog();

  Future<dynamic> getPlanCustomerInfo(context) async {
    var userInfo =
        BlocProvider.of<UserInfoBloc>(context, listen: true).state.userInfo;
    final PlanRepository repository = new PlanDefaultRepository();
    try {
      return await repository.getPlanCustomer(userInfo.id);
    } on DioError catch (_) {
      print(_);
      globalDialog.seeDialogError(context, _.response?.data['message']);
    } catch (exception) {
      print(exception);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBackground(child: LayoutBuilder(
      builder: (context, constrains) {
        return FutureBuilder(
          future: getPlanCustomerInfo(context),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              case ConnectionState.done:
                var planCustomerInfo = snapshot.data;
                return Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                      alignment: Alignment.topCenter,
                      child: Text(
                        'Datos de mi plan',
                        style: TextStyle(
                          fontSize: 25,
                          height: 1.6,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.fromLTRB(30, 40, 0, 0),
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Tipo de plan: ' + planCustomerInfo!.name!,
                          style: TextStyle(
                            fontSize: 18,
                            height: 1.6,
                            fontWeight: FontWeight.w600,
                          ),
                        )),
                    Container(
                        padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Duración: ' +
                              planCustomerInfo!.duration!.toString() +
                              ' días',
                          style: TextStyle(
                            fontSize: 18,
                            height: 1.6,
                            fontWeight: FontWeight.w600,
                          ),
                        )),
                    Container(
                        padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
                        alignment: Alignment.topCenter,
                        child: Text(
                          'Mis rutinas',
                          style: TextStyle(
                            fontSize: 20,
                            height: 1.6,
                            fontWeight: FontWeight.w900,
                          ),
                        )),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.fromLTRB(28, 22, 28, 62),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisExtent: 100,
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        childAspectRatio: 2.6,
                        mainAxisSpacing: 15,
                      ),
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return PlanCustomerCard(
                            Colors.primaries[
                                Random().nextInt(Colors.primaries.length)],
                            planCustomerInfo!.routines[index], index + 1);
                      },
                    )
                  ],
                );
              default:
                return Text('Vuelva a la vista anterior e inténtelo de nuevo');
            }
          },
        );
      },
    ));
  }
}
