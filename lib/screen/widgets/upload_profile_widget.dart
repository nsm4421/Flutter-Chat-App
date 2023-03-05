import 'package:flutter/material.dart';
import 'package:flutter_prj/screen/custom_desgin/colors.dart';

import '../custom_desgin/theme.dart';

class ProfileUploadWidget extends StatelessWidget {
  final double _size = 100.0;
  final Function onTap;

  const ProfileUploadWidget({Key key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _size,
      width: _size,
      child: Material(
        color: _color(context),
        borderRadius: BorderRadius.circular(128.0),
        child: InkWell(
          onTap: onTap,
          child: Stack(
            fit: StackFit.expand,
            children: [
              _circularAvatar(context, _size),
              Align(
                alignment: Alignment.bottomRight,
                child: Icon(
                  Icons.add_circle_outline_rounded,
                  size: _size * 0.3,
                  color: kPrimary,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Color _color(context) =>
    isLightTheme(context) ? const Color(0xFFF2F2F2) : Colors.black;
Color _iconColor(context) =>
    isLightTheme(context) ? kIconLight : Colors.black;

Widget _circularAvatar(BuildContext context, double size) {
  return CircleAvatar(
      backgroundColor: Colors.transparent,
      child: Icon(
        Icons.person_outline_rounded,
        size: size * 0.8,
        color: _iconColor(context),
      ));
}