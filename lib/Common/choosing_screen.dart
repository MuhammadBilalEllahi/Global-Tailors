import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:tailor_flutter/Admob/admob.dart';
import 'package:tailor_flutter/Auth/LoginPage/login.dart';
import 'package:tailor_flutter/Auth/Registration%20Page/register.dart';
import 'package:tailor_flutter/FireBase/firebase.dart';
import 'package:tailor_flutter/Tailor/tailor_complete_info.dart';

class SignInUpAs extends StatefulWidget {
 const  SignInUpAs({super.key});

  @override
  State<SignInUpAs> createState() => _SignInUpAsState();
}

class _SignInUpAsState extends State<SignInUpAs> {
  BannerAd? _bannerAd;

  @override
  void initState() {
    // TODO: implement initState
    _createBanner();
    super.initState();
  }

  void _createBanner() {
    _bannerAd = BannerAd(
        size: AdSize.fullBanner,
        adUnitId: AdMobService.bannerAdUnitId!,
        listener: AdMobService.bannerAdListener,
        request: const AdRequest())
      ..load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
               SizedBox(
                height: MediaQuery.of(context).size.width/5,
              ),
               SizedBox(
                  height: MediaQuery.of(context).size.width/3.5,
                  child: TextSized(
                   text: "Tailor App",
                    fontSize: MediaQuery.of(context).size.width/8
                  )),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(255, 224, 224, 224),
                ),
                width: 300,
                height: 220,
                // color: Colors.grey.shade400,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                      child: TextSized(
                        text: "Sign Up Now",
                        fontSize: 32),
                      
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const RegisterPage(type: "Customer"))
                              );
                      },
                      style: const ButtonStyle(
                          fixedSize: MaterialStatePropertyAll(Size(150, 30)),
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.black)),
                      child: const Text("As Customer",
                          style: TextStyle(color: Colors.white, fontSize: 15)),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    ElevatedButton(
                      onPressed: () {
                         Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const RegisterPage(type: "Tailor"))
                              );
                      },
                      style: const ButtonStyle(
                          fixedSize: MaterialStatePropertyAll(Size(150, 30)),
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.black)),
                      child: const Text("As Tailor",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          )),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Text(
                  "or",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  signInWithGoogle();
                },
                style: const ButtonStyle(
                    fixedSize: MaterialStatePropertyAll(Size(200, 50)),
                    backgroundColor: MaterialStatePropertyAll(Colors.black)),
                child: const Text("Google",
                    style: TextStyle(color: Colors.white, fontSize: 24)),
              ),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text("Already Have An Account? "),
                            TextButton(
                              
                              
                                onPressed: () {
        
                                  // widget.showLoginPage();
                                  
                                  // print(widget.showLoginPage.toString());
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => const LoginPage(type: "User",)));
                                },
                                child: const Text("Login Now", style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))))
                          ],
                        ),
                      )
            ],
          ),
        ),
      ),
      bottomNavigationBar:  (_bannerAd == null) ? Container() : SizedBox(
                            height: 60,
                            width: 470,
                            child: AdWidget(ad: _bannerAd!),
                          ), 
    );
  }
}
