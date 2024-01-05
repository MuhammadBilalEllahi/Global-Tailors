// import 'package:google_mobile_ads/google_mobile_ads.dart';
// import 'package:tailor_app/Admob/admob.dart';

//  _createBanner( _bannerAd) {
//     _bannerAd = BannerAd(
//         size: AdSize.fullBanner,
//         adUnitId: AdMobService.bannerAdUnitId!,
//         listener: AdMobService.bannerAdListener,
//         request: const AdRequest())
//       ..load();
//   }

// import 'package:flutter/material.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
// import 'package:tailor_app/Admob/admob.dart';
// BannerAd? _bannerAd;
// InterstitialAd? _interstitialAd;

// void _createBanner() {
//     _bannerAd = BannerAd(
//         size: AdSize.fullBanner,
//         adUnitId: AdMobService.bannerAdUnitId!,
//         listener: AdMobService.bannerAdListener,
//         request: const AdRequest())
//       ..load();
//   }

// void _createInterstellerAd() {
//     InterstitialAd.load(
//         adUnitId: AdMobService.interstitialAdUnitId!,
//         request: const AdRequest(),
//         adLoadCallback: InterstitialAdLoadCallback(
//           // Called when an ad is successfully received.
//           onAdLoaded: (ad) {
//             debugPrint('$ad loaded.');
//             // Keep a reference to the ad so you can show it later.
//             _interstitialAd = ad;
//           },
//           // Called when an ad request failed.
//           onAdFailedToLoad: (LoadAdError error) {
//             debugPrint('InterstitialAd failed to load: $error');
//           },
//         ));
//   }

//   void _showInterstellerAd(){
//     if(_interstitialAd != null ){
//       _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
//         onAdDismissedFullScreenContent: (ad) {
//           ad.dispose();
//           _createInterstellerAd();

//         },

//         onAdFailedToShowFullScreenContent: (ad,error){
//           ad.dispose();
//           _createInterstellerAd();
//         }, 

        
//       );
//       _interstitialAd!.show();
//       _interstitialAd == null;
//     }

//   }