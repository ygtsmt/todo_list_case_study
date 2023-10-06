import "package:flutter/material.dart";
import "package:gpt/core/keys.dart";
import "package:injectable/injectable.dart";

@injectable
class SnackBarService {
  void showSnackBar(final String? message) {
    final snackBar = SnackBar(
      elevation: 2,
      behavior: SnackBarBehavior.fixed,
      content: Text(message ?? "ssddff"),
    );

    snackbarKey.currentState?.hideCurrentSnackBar();
    snackbarKey.currentState?.showSnackBar(snackBar);
  }
}
