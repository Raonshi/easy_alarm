import 'dart:developer';
import 'package:easy_alarm/secret/keys.dart';
import 'package:easy_alarm/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BottomAdWidget extends StatefulWidget {
  const BottomAdWidget({super.key});

  @override
  State<BottomAdWidget> createState() => _BottomAdWidgetState();
}

class _BottomAdWidgetState extends State<BottomAdWidget> {
  NativeAd? _nativeAd;
  bool _nativeAdIsLoaded = false;

  @override
  void initState() {
    _nativeAd = NativeAd(
      adUnitId: Keys.testAdKey,
      request: const AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (Ad ad) {
          setState(() {
            _nativeAdIsLoaded = true;
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
        },
        onAdOpened: (Ad ad) => log('$NativeAd onAdOpened.'),
        onAdClosed: (Ad ad) => log('$NativeAd onAdClosed.'),
      ),
      nativeTemplateStyle: NativeTemplateStyle(
        templateType: TemplateType.small,
        mainBackgroundColor: Colors.white12,
        callToActionTextStyle: NativeTemplateTextStyle(
          size: 16.0,
        ),
        primaryTextStyle: NativeTemplateTextStyle(
          textColor: Colors.black38,
          backgroundColor: Colors.white70,
        ),
      ),
    );
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await _nativeAd!.load();
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _nativeAd?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CustomColors.white,
      height: 90.0,
      width: MediaQuery.of(context).size.width,
      child: _nativeAdIsLoaded ? AdWidget(ad: _nativeAd!) : const Center(child: Text('loading...')),
    );
  }
}
