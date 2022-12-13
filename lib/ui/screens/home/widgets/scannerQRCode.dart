import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym/data/repositories/attendance_repository.dart';
import 'package:gym/states/user_info/user_info_bloc.dart';
import 'package:gym/ui/widgets/button.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScannerQRCode extends StatefulWidget {
  final BuildContext? context;
  const ScannerQRCode({Key? key, this.context}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ScannerQRCodeState();
}

class ScannerQRCodeState extends State<ScannerQRCode> {
  bool registered = false;
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  AttendanceRepository? attendanceRepository;
  String? userId;

  @override
  void initState() {
    attendanceRepository = AttendanceDefaultRepository();
    super.initState();
  }

  Future<bool> getAttendanceByCustomerId(context) async {
    userId =
        BlocProvider.of<UserInfoBloc>(context, listen: true).state.userInfo.id;
    return await attendanceRepository!.getAttendanceByCustomerId(userId!);
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: getAttendanceByCustomerId(context),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.connectionState == ConnectionState.done)
              registered = snapshot.data!;
            return Column(
              children: <Widget>[
                Expanded(
                  flex: 4,
                  child: result == null && !registered
                      ? _buildQrView(context)
                      : Container(
                          alignment: Alignment.center,
                          child: Text(
                            registered
                                ? 'Ya se ha registrado tu asistencia para hoy'
                                : 'Tu asistencia se registró exitosamente',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                fontSize: 40),
                          ),
                        ),
                ),
                Expanded(
                    flex: result == null && !registered ? 4 : 2,
                    child: result == null && !registered
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    margin: const EdgeInsets.all(8),
                                    child: ElevatedButton(
                                        onPressed: () async {
                                          await controller?.toggleFlash();
                                          setState(() {});
                                        },
                                        child: FutureBuilder(
                                          future: controller?.getFlashStatus(),
                                          builder: (context, snapshot) {
                                            return Text(
                                                'Flash: ${snapshot.data}');
                                          },
                                        )),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.all(8),
                                    child: ElevatedButton(
                                        onPressed: () async {
                                          await controller?.flipCamera();
                                          setState(() {});
                                        },
                                        child: FutureBuilder(
                                          future: controller?.getCameraInfo(),
                                          builder: (context, snapshot) {
                                            if (snapshot.data != null) {
                                              return Text(
                                                  'Camera facing ${describeEnum(snapshot.data!)}');
                                            } else {
                                              return const Text('loading');
                                            }
                                          },
                                        )),
                                  ),
                                ],
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(70, 0, 70, 0),
                                alignment: Alignment.topCenter,
                                child: Text(
                                  textAlign: TextAlign.center,
                                  'Escanea el código que generó el administrador para registrar tu asistencia',
                                  style: TextStyle(
                                    fontSize: 16,
                                    height: 1.6,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Container(
                            padding: EdgeInsets.fromLTRB(70, 0, 70, 0),
                            alignment: Alignment.topCenter,
                            child: RadialButton(
                              color: Colors.blueGrey,
                              press: () {
                                Navigator.pop(widget.context!);
                              },
                              text: 'Volver',
                              textColor: Colors.white,
                            ),
                          ))
              ],
            );
          }),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 250.0
        : 400.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      postAttendance(scanData, userId);
    });
  }

  postAttendance(scanData, userId) async {
    var response = await attendanceRepository!
        .postAttendanceByCustomerId(scanData.code, userId);
    if (response) {
      setState(() {
        result = scanData;
        this.controller?.pauseCamera();
        registered = true;
      });
    }
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
