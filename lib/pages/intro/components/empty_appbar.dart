import 'package:nf_og/constant.dart';
import 'package:flutter/material.dart';

class EmptyAppBar extends StatelessWidget implements PreferredSizeWidget{

  @override

  Size get preferredSize => const Size.fromHeight(kAppBarHeight);
  
  const EmptyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: kDarkColor,
      elevation: kRadius,
    );
  }
  
}