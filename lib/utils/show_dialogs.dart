import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import 'package:tablero_tareas/router.dart';

void showAcceptDialog({
  required BuildContext context,
  QuickAlertType type = QuickAlertType.info,
  String? title,
  String? text,
  String confirmButtonText = 'Aceptar',
  VoidCallback? onConfirm,
  bool autoClose = true,
}) {
  QuickAlert.show(
    context: context,
    type: type,
    title: title,
    text: text,
    confirmBtnText: confirmButtonText,
    onConfirmBtnTap: () {
      _closeDialogThen(onConfirm);
    },
    autoCloseDuration: autoClose ? Duration(seconds: 5) : null,
  );
}

void showLoadingDialog({
  required BuildContext context,
  String text = 'Cargando',
}) {
  QuickAlert.show(
    context: context,
    type: QuickAlertType.loading,
    text: text,
    barrierDismissible: false,
    disableBackBtn: true,
  );
}

void showConfirmDialog({
  required BuildContext context,
  QuickAlertType type = QuickAlertType.info,
  String? title,
  String? text,
  String confirmButtonText = 'Aceptar',
  String cancelButtonText = 'Cancelar',
  required VoidCallback onConfirm,
  required VoidCallback onCancel,
}) {
  QuickAlert.show(
    context: context,
    type: QuickAlertType.confirm,
    title: title,
    text: text,
    confirmBtnText: confirmButtonText,
    cancelBtnText: cancelButtonText,
    cancelBtnTextStyle: TextStyle(color: Colors.red),
    onConfirmBtnTap: () {
      _closeDialogThen(onConfirm);
    },
    onCancelBtnTap: () {
      _closeDialogThen(onCancel);
    },
    barrierDismissible: false,
  );
}

void _closeDialogThen(VoidCallback? callback) {
  router.pop();
  if (callback != null) callback();
}
