import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:constriturar/app/core/config/app_colors.dart';

class Upside extends StatelessWidget {
  const Upside({super.key, required this.imgUrl});
  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          width: size.width,
          height: size.height / 2,
          color: AppColors.primary,
          child: Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Image.asset(
              imgUrl,
              alignment: Alignment.topCenter,
              scale: 8,
            ),
          ),
        ),
        iconBackButton(context),
        // Positioned(
        //   left: 0,
        //   top: 175,
        //   child: Image.network(
        //     "https://ouch-cdn2.icons8.com/gEMjZ4ZC639WYTYjpan-J3XByArwXzS7lUcNL-UMVdk/rs:fit:196:289/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9zdmcvMi80/NzU5OTI4ZS04OWE3/LTRhOTYtYjdjMi0w/ZDA0MWI2Y2E3MTQu/c3Zn.png",
        //     scale: 3,
        //   ),
        // ),
        // Positioned(
        //   right: 0,
        //   top: 60,
        //   child: Image.network(
        //     "https://ouch-cdn2.icons8.com/vKz7XNZvZiNKlkUWT2HjP8oNZ8hZ0UblhuF8J6sGRGI/rs:fit:196:112/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9zdmcvNjg3/LzA3ZDZiZjRmLWFj/OTYtNGRmMy05ZGYz/LTNhNWQzOWI5NGYz/MC5zdmc.png",
        //     scale: 3,
        //   ),
        // ),
      ],
    );
  }
}

iconBackButton(BuildContext context) {
  if (Navigator.canPop(context)) {
    return IconButton(
      color: Colors.white,
      iconSize: 28,
      icon: const Icon(CupertinoIcons.arrow_left),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  } else {
    return Container(); // Return an empty container if there's no back route
  }
}
