import 'package:flutter/material.dart';
class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key key,
    @required this.message,
  }) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height / 3,
        child: Center(
          child: CircularProgressIndicator(),
        )
    );
  }
}
