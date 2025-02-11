import 'package:constriturar/app/core/components/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:constriturar/app/core/config/app_colors.dart';
import 'dart:math';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> animation;
  late Animation<double> scalAnimation;

  bool isSideMenuClosed = true;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    )..addListener(() {
        setState(() {});
      });

    animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));

    scalAnimation = Tween<double>(begin: 1, end: 0.8).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: Stack(
          children: [
            AnimatedPositioned(
              duration: Duration(milliseconds: 200),
              curve: Curves.fastOutSlowIn,
              width: 288,
              left: isSideMenuClosed ? -288 : 0,
              height: MediaQuery.of(context).size.height,
              child: SideMenu(),
            ),
            Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(animation.value - 30 * animation.value * pi / 180),
              child: Transform.translate(
                offset: Offset(animation.value * 265, 0),
                child: Transform.scale(
                  scale: scalAnimation.value,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(
                        Radius.circular(isSideMenuClosed ? 0 : 24)),
                    child: HomeScreen(),
                  ),
                ),
              ),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 200),
              curve: Curves.fastOutSlowIn,
              left: isSideMenuClosed ? 0 : 220,
              top: 16,
              child: MenuBtn(
                press: () {
                  setState(() {
                    isSideMenuClosed = !isSideMenuClosed;
                    if (isSideMenuClosed) {
                      _animationController.reverse();
                    } else {
                      _animationController.forward();
                    }
                  });
                },
                isSideMenuClosed: isSideMenuClosed,
              ),
            ),
          ],
        ),
        bottomNavigationBar: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.all(Radius.circular(24)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 36,
                  width: 36,
                  child: Icon(
                    Icons.home,
                    color: AppColors.white,
                  ),
                ),
                SizedBox(
                  height: 36,
                  width: 36,
                  child: Icon(
                    Icons.search,
                    color: AppColors.white,
                  ),
                ),
                SizedBox(
                  height: 36,
                  width: 36,
                  child: Icon(
                    Icons.person,
                    color: AppColors.white,
                  ),
                ),
                SizedBox(
                  height: 36,
                  width: 36,
                  child: Icon(
                    Icons.logout,
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  "Inicio",
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: AppColors.black, fontWeight: FontWeight.bold),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MenuBtn extends StatelessWidget {
  const MenuBtn({
    super.key,
    required this.press,
    required this.isSideMenuClosed,
  });

  final VoidCallback press;
  final bool isSideMenuClosed;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: press,
        child: Container(
          margin: EdgeInsets.only(left: 16),
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: AppColors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.primary,
                offset: Offset(0, 3),
                blurRadius: 8,
              )
            ],
          ),
          child: Icon(
            isSideMenuClosed ? Icons.menu : Icons.close, // Cambia el ícono aquí
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }
}
