import 'package:flutter/material.dart';
import 'package:velo_toulouse_app/ui/theme/theme.dart';

// add multi provider later
void mainCommon() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text("veloToulouse", style: AppText.heading,),),
       body: Center(
          child: ShaderMask(
            shaderCallback: (bounds) =>
                AppGradient.primary.createShader(bounds),
            child: Text(
              "Welcome",
              style: AppText.body.copyWith(color: AppColor.white)
            ),
          ),
        ),
      ),
    );
  }
}
