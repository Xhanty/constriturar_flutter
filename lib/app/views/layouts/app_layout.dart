import 'package:constriturar/app/core/services/auth_service.dart';
import 'package:constriturar/app/views/modules/home/home_page.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:constriturar/app/routes/routes.dart';
import 'package:constriturar/app/core/components/side_menu.dart';
import 'package:constriturar/app/core/config/app_colors.dart';

class AppLayout extends StatefulWidget {
  const AppLayout({super.key, required this.child});
  final Widget child;

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout>
    with SingleTickerProviderStateMixin {
  final AuthService _authService = AuthService();
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
              child: SideMenu(view: widget.child),
            ),
            PageContainer(
                animation: animation,
                scalAnimation: scalAnimation,
                isSideMenuClosed: isSideMenuClosed,
                widget: widget),
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
                GestureDetector(
                  onTap: () {
                    AppRoutes.setView(HomePage(), context);
                  },
                  child: SizedBox(
                    height: 36,
                    width: 36,
                    child: Icon(
                      Icons.home,
                      color: AppColors.white,
                    ),
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
                GestureDetector(
                  onTap: () {
                    _authService.logout();
                    Navigator.pushReplacementNamed(context, AppRoutes.login);
                  },
                  child: SizedBox(
                    height: 36,
                    width: 36,
                    child: Icon(
                      Icons.logout,
                      color: AppColors.white,
                    ),
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

class PageContainer extends StatelessWidget {
  const PageContainer({
    super.key,
    required this.animation,
    required this.scalAnimation,
    required this.isSideMenuClosed,
    required this.widget,
  });

  final Animation<double> animation;
  final Animation<double> scalAnimation;
  final bool isSideMenuClosed;
  final AppLayout widget;

  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateY(animation.value - 30 * animation.value * pi / 180),
      child: Transform.translate(
        offset: Offset(animation.value * 265, 0),
        child: Transform.scale(
          scale: scalAnimation.value,
          child: ClipRRect(
            borderRadius:
                BorderRadius.all(Radius.circular(isSideMenuClosed ? 0 : 24)),
            child: Column(
              children: [
                Container(
                  height: 55,
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                ),
                Expanded(child: widget.child),
              ],
            ),
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
                color: AppColors.lightShadow,
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
