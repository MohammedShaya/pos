import 'package:clay_containers/widgets/clay_container.dart';
import 'package:flutter/material.dart';
import 'package:pos/screans/home/left_home.dart';
import 'package:pos/screans/home/right_home.dart';
import 'package:pos/utls/colors.dart';

class HomeScrean extends StatefulWidget {
  const HomeScrean({super.key});

  @override
  State<HomeScrean> createState() => _HomeScreanState();
}

class _HomeScreanState extends State<HomeScrean> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
        body: Container(
            padding: const EdgeInsets.all(10),
            child: const ClayContainer(
                // parentColor: AppColors.scondaryColor,
                borderRadius: 10,
                spread: 1,
                child: Row(
                  children: [
                    Expanded(flex: 7, child: LeftHome() ),
                    Expanded(flex: 3, child: RightHome())
                  ],
                ))));
  }
}
