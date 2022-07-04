import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WatchBox {
  bool _isShowing = false;
  static WatchBox? _instance;
  WatchBox._();
  static WatchBox get instance => _instance ??= WatchBox._();

  void show(BuildContext context) {
    if (!_isShowing) {
      _isShowing = true;
      _dialog(context);
    }
  }

  void _dialog(BuildContext context) {
    showGeneralDialog(
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 500),
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return Container(
          height: double.infinity,
          margin: const EdgeInsets.only(left: 100),
          color: Colors.white,
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    dismiss(context);
                  },
                  child: const Text('close'))
            ],
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(begin: const Offset(1, 0), end: const Offset(0, 0))
              .animate(anim1),
          child: child,
        );
      },
    ).then((shouldUpdate) {
      _isShowing = false;
    });
  }

  void dismiss(BuildContext context) {
    if (_isShowing) {
      Navigator.pop(context);
      _isShowing = false;
    }
  }
}
