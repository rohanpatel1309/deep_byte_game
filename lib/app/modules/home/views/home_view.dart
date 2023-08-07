import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/size.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(

      body:  SizedBox(
        width: width,
        height: height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            const Text("TIC TOC TOE", style: TextStyle(fontSize: 40),),

            SizedBox(height: height * 0.05,),

            MaterialButton(
                onPressed: controller.navigateToGame,
                child: const Text("PLAY GAME"),
                color: Colors.black,
                textColor: Colors.white,
            )

          ],
        ),
      ),
    );
  }
}
