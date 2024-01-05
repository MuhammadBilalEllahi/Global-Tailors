
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:tailor_flutter/SplashScreen/splash.dart';

class SplashStarterPage extends StatefulWidget {
  const SplashStarterPage({super.key, required this.showAuthPage, });
  final  VoidCallback showAuthPage;

  @override
  State<SplashStarterPage> createState() => _SplashStarterPageState();
}


class _SplashStarterPageState extends State<SplashStarterPage> {

  @override
  void initState() {
        FlutterNativeSplash.remove();

    // TODO: implement initState
    Future.delayed(const Duration(seconds: 3)).then((value) => {
      // showAuthPage
      widget.showAuthPage()
      // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>  ))
    });
    
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        
        body:  Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
               const ScissorAnimation(direction: -1), 
               const ScissorAnimation(direction: 1), 
              Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 228, 226, 226),
                  borderRadius: BorderRadius.all(Radius.circular(10))
                ),
              ),
            ],
          ),
        ),
      
    );
  }
}
