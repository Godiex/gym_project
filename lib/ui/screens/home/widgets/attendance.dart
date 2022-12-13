import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym/states/theme/theme_cubit.dart';
import 'package:gym/states/user_info/user_info_bloc.dart';
import 'package:gym/ui/screens/home/widgets/scannerQRCode.dart';
import 'package:gym/ui/widgets/app_background.dart';
import '../../../../data/environment/env.dart';
import '../../../../domain/constants/type_user.dart';
import '../../../widgets/dialog.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class Attendance extends StatefulWidget {
  @override
  State<Attendance> createState() => AttendanceState();
}

class AttendanceState extends State<Attendance> {
  final globalDialog = GlobalWidgetDialog();

  String generateStringCode() {
    return '${Env.apiBaseUrl}/Attendance';
  }

  @override
  Widget build(BuildContext context) {
    var userInfo =
        BlocProvider.of<UserInfoBloc>(context, listen: true).state.userInfo;
    var themeCubit = BlocProvider.of<ThemeCubit>(context, listen: true);
    return AppBackground(child: LayoutBuilder(builder: (context, constrains) {
      return Column(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
              alignment: Alignment.topCenter,
              child: Text(
                'Asistencias - ' + userInfo.typeUser,
                style: TextStyle(
                  fontSize: 25,
                  height: 1.6,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
          Expanded(
            flex: userInfo.typeUser == TypeUser.Admin ? 6 : 10,
            child: userInfo.typeUser == TypeUser.Admin
                ? Container(
                    padding: EdgeInsets.fromLTRB(0, 70, 0, 0),
                    alignment: Alignment.topCenter,
                    child: QrImage(
                      foregroundColor:
                          themeCubit.isDark ? Colors.white : Colors.black,
                      data: generateStringCode(),
                      version: QrVersions.auto,
                      size: 300.0,
                    ),
                  )
                : Container(
                    padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                    alignment: Alignment.topCenter,
                    child: ScannerQRCode(context: context)),
          ),
          if (userInfo.typeUser == TypeUser.Admin)
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.fromLTRB(70, 20, 70, 0),
                alignment: Alignment.topCenter,
                child: Text(
                  textAlign: TextAlign.center,
                  'Con éste código tus clientes podrán registrar su asistencia',
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.6,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
        ],
      );
    }));
  }
}
