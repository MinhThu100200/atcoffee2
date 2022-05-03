import 'package:at_coffee/common/theme/colors.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;

  final String title;

  Header(
    this.title, {
    Key key,
  })  : preferredSize = Size.fromHeight(50.0),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: primary,
        padding: EdgeInsets.all(5),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(children: [
            Expanded(
              child: Container(
                color: Colors.white,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search",
                    contentPadding: EdgeInsets.all(10),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
