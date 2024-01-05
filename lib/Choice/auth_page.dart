
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:tailor_flutter/Admob/admob.dart';
import 'package:tailor_flutter/Common/choosing_screen.dart';
import 'package:tailor_flutter/Common/my_elevatedbutton.dart';
import 'package:tailor_flutter/Tailor/tailor_init.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({
    super.key,
    // required this.showAuthPage
  });
  // final  VoidCallback showAuthPage;

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
// final _controller = PageController(initialPage: 1);

  BannerAd? _bannerAd;
  InterstitialAd? _interstitialAd;
  RewardedAd? _rewardedAd;
   int _rewardedAdScore = 0;






  late PageController _controller;
  final int _currentPage = 0;
  @override
  void initState() {
    // TODO: implement initState
    _controller =
        PageController(initialPage: _currentPage, viewportFraction: 1);
    super.initState();

    _createBanner();
    _createInterstellerAd();
    _createRewardedAd();
    

  }

  void _createRewardedAd(){
    RewardedAd.load(adUnitId: AdMobService.rewardedAdUnitId!, request: const AdRequest(),
     rewardedAdLoadCallback: RewardedAdLoadCallback(onAdLoaded: (ad)=> setState(() {
       _rewardedAd = ad;
     }),
    
      onAdFailedToLoad: (ad)=> setState(() {
        _rewardedAd = null;
      })

     ));    
  }

  void _createBanner() {
    _bannerAd = BannerAd(
        size: AdSize.fullBanner,
        adUnitId: AdMobService.bannerAdUnitId!,
        listener: AdMobService.bannerAdListener,
        request: const AdRequest())
      ..load();
  }


    void _createInterstellerAd() {
    InterstitialAd.load(
        adUnitId: AdMobService.interstitialAdUnitId!,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          // Called when an ad is successfully received.
          onAdLoaded: (ad) {
            debugPrint('$ad loaded.');
            // Keep a reference to the ad so you can show it later.
            _interstitialAd = ad;
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (LoadAdError error) {
            debugPrint('InterstitialAd failed to load: $error');
          },
        ));
  }

  void _showInterstellerAd(){
    if(_interstitialAd != null ){
      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          _createInterstellerAd();

        },

        onAdFailedToShowFullScreenContent: (ad,error){
          ad.dispose();
          _createInterstellerAd();
        }, 

        
      );
      _interstitialAd!.show();
      _interstitialAd == null;
    }

  }

  void _showRewardedAd(){
    if(_rewardedAd != null){
      _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad){
          ad.dispose();
          _createRewardedAd();
        }, 
         onAdFailedToShowFullScreenContent: (ad,error){
          ad.dispose();
          _createRewardedAd();
        }, 
        
      );

      _rewardedAd!.show(onUserEarnedReward: (ad,reward)=> setState(() {
        _rewardedAdScore++;
      }));
      _rewardedAd = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
               SizedBox(
                height: MediaQuery.of(context).size.width/20,
              ),
               Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextSized(
                  text: "Welcome to Tailor PRO",
                  fontSize: MediaQuery.of(context).size.width/12,
                ),
              ),
               Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextSized(
                  text: "Help us Find You Customers",
                  fontSize: MediaQuery.of(context).size.width/22
                ),
              ),
               SizedBox(
                height: MediaQuery.of(context).size.width/20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width/1.3,
                height: MediaQuery.of(context).size.width/2,
                child: PageView(
                  scrollDirection: Axis.horizontal,
                  controller: _controller,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(20),
                        // border: Border(bottom: BorderSide.lerp(const BorderSide(width: 20),const BorderSide(width: 20), 2))
                      ),
                      // color: const Color.fromARGB(255, 33, 229, 243),
                      child: Image.asset(
                        "assets/bg_splash.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(20),
                        // border: Border(bottom: BorderSide.lerp(const BorderSide(width: 20),const BorderSide(width: 20), 2))
                      ),
                      // color: const Color.fromARGB(255, 33, 229, 243),
                      child: Image.asset(
                        "assets/bg_splash.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(20),
                        // border: Border(bottom: BorderSide.lerp(const BorderSide(width: 20),const BorderSide(width: 20), 2))
                      ),
                      // color: const Color.fromARGB(255, 33, 229, 243),
                      child: Image.asset(
                        "assets/bg_splash.png",
                        fit: BoxFit.none,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                  onPressed: () {
                    
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>  const SignInUpAs()));
                        
                    //  Navigator.of(context).push(MaterialPageRoute(
                    //           builder: (context) => const RegisterPage())
                    //           );
                  },
                  style: const ButtonStyle(
                      fixedSize: MaterialStatePropertyAll(Size(250, 60)),
                      backgroundColor: MaterialStatePropertyAll(Colors.black)),
                  child: const Text(
                    "Lets Get Started",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),




               MyElevatedButtom(label: 'Ad', fontSize: 12, onPressed: (){

                _showInterstellerAd();
              },),
                MyElevatedButtom(label: 'Reward Ad', fontSize: 12, onPressed: (){

                _showRewardedAd();
              },),
              Text("Rewrd $_rewardedAdScore"),


            //  (_bannerAd == null) ? Container() : SizedBox(
            //                 height: 60,
            //                 width: 470,
            //                 child: AdWidget(ad: _bannerAd!),
            //               ), 

             
              // const SizedBox(
              //   height: 10,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     const Text("Already a User?"),
              //     TextButton(
              //         onPressed: () {
              //           // widget.showLoginPage();
              //            Navigator.of(context).push(MaterialPageRoute(
              //                 builder: (context) =>  const LoginPage())
              //                 );
              //         },
              //         child: const Text("Login",
              //             style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)))),
              //   ],
              // ),
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
