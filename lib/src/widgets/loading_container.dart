import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
        title: loadingShimmer(),
        subtitle: loadingSubTitleShimmer(),
        ),
        Divider(
          height: 8.0,
        ),
      ],
    );
  }

  Widget loadingShimmer() {
    return Container(
      color: Colors.grey[200],
      height: 24.0,
      width: 150.0,
      margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
    );
  }

  Widget loadingSubTitleShimmer() {
    return Container(
      color: Colors.grey[200],
      height: 24.0,
      width: 80.0,
      margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
    );
  }
}
