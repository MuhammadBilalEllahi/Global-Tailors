import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

const adUnitId = "ca-app-pub-3940256099942544/1033173712"; //test
// const adUnitId = "ca-app-pub-2314232719315576/9764778560";

// const appID = "ca-app-pub-2314232719315576~1150386409";

void loadAd() {
  InterstitialAd? interstitialAd;
  InterstitialAd.load(
      adUnitId: adUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          debugPrint('$ad loaded.');
          // Keep a reference to the ad so you can show it later.
          interstitialAd = ad;
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (LoadAdError error) {
          debugPrint('InterstitialAd failed to load: $error');
        },
      ));
}

class AdMobService {
  static String? get bannerAdUnitId {
    if (Platform.isAndroid) {
      // return "ca-app-pub-2314232719315576~1150386409";
      return "ca-app-pub-3940256099942544/6300978111";
    }
    return null;
  }

// AdUnitId
  static String? get interstitialAdUnitId {
    if (Platform.isAndroid) {
      // return "ca-app-pub-2314232719315576~1150386409";
      return "ca-app-pub-3940256099942544/1033173712";
    }
    return null;
  }

  static String? get rewardedAdUnitId {
    if (Platform.isAndroid) {
      // return "ca-app-pub-2314232719315576~1150386409";
      return "ca-app-pub-3940256099942544/5224354917";
    }
    return null;
  }

  static final BannerAdListener bannerAdListener = BannerAdListener(
      onAdLoaded: (ad) => debugPrint("Banner ad loaded"),
      onAdFailedToLoad: (ad, error) {
        ad.dispose();
        debugPrint('ad failed to load banner : $error');
      },
      onAdOpened: (ad) => debugPrint('banner ad opppend'),
      onAdClosed: (ad) => debugPrint('banner ad closed'));
}

  


// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';

// const adUnitId = "ca-app-pub-2314232719315576/9764778560";

// // const appID = "ca-app-pub-2314232719315576~1150386409";



//     void loadAd() {
//     InterstitialAd? interstitialAd;
//     InterstitialAd.load(
//         adUnitId: adUnitId,
//         request: const AdRequest(),
//         adLoadCallback: InterstitialAdLoadCallback(
//           // Called when an ad is successfully received.
//           onAdLoaded: (ad) {
//             debugPrint('$ad loaded.');
//             // Keep a reference to the ad so you can show it later.
//             interstitialAd = ad;
//           },
//           // Called when an ad request failed.
//           onAdFailedToLoad: (LoadAdError error) {
//             debugPrint('InterstitialAd failed to load: $error');
//           },
//         ));
//   }



//   class AdMobService {

//     static String? get bannerAdUnitId{
//       if(Platform.isAndroid){
//         // return "ca-app-pub-2314232719315576~1150386409";
//       return "ca-app-pub-2314232719315576/3379333613";
//       }
//       return null;
//     }  


// // AdUnitId
//     static String? get interstitialAdUnitId{
//       if(Platform.isAndroid){
//         // return "ca-app-pub-2314232719315576~1150386409";
//       return "ca-app-pub-2314232719315576/9764778560";
//       }
//       return null;
//     }  

//       static String? get rewardedAdUnitId{
//       if(Platform.isAndroid){
//         // return "ca-app-pub-2314232719315576~1150386409";
//       return "ca-app-pub-2314232719315576/9189492676";
//       }
//       return null;
//     }  

//   static final  BannerAdListener bannerAdListener =  BannerAdListener(

//     onAdLoaded: (ad) => debugPrint("BAnner ad loaded"), 
//     onAdFailedToLoad: (ad,error){
//       ad.dispose();
//       debugPrint('ad failed to load kkkjkjkjk : $error');
//     },
//     onAdOpened: (ad)=>   debugPrint('ad opppend'), 
//     onAdClosed: (ad)=>   debugPrint('add closedd')

//   );
//   }

  