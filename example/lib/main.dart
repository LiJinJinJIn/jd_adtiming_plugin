import 'package:flutter/material.dart';
import 'package:jd_adtiming_plugin/jd_adtiming_plugin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  JdAdtimingPlugin jdAdtimingPlugin = JdAdtimingPlugin();
  String ANDROID_APPKEY = 'your android appkey';
  String IOS_APPKEY = 'your ios appkey';

  void showT(String msg) {
    print("msg>>>       $msg ");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Plugin example app'),
        ),
        body: Column(
          children: [
            InkWell(
              child: Container(
                alignment: Alignment.center,
                width: 200,
                height: 40,
                child: Text('init'),
                color: Colors.red,
              ),
              onTap: () {
                jdAdtimingPlugin.init(
                  androidAppKey: ANDROID_APPKEY,
                  iosAppKey: IOS_APPKEY,
                  success: () => showT("success"),
                  fail: () => showT("fail"),
                );
              },
            ),
            SizedBox(height: 20),
            InkWell(
              child: Container(
                alignment: Alignment.center,
                width: 200,
                height: 40,
                child: Text('加载插屏广告'),
                color: Colors.red,
              ),
              onTap: () {
                jdAdtimingPlugin.interstitialAdLoad();
              },
            ),
            SizedBox(height: 20),
            InkWell(
              child: Container(
                alignment: Alignment.center,
                width: 200,
                height: 40,
                child: Text('播放插屏广告'),
                color: Colors.red,
              ),
              onTap: () {
                jdAdtimingPlugin.interstitialShowLoad();

                jdAdtimingPlugin.setInterstitialAdListener(
                  adAvailabilityChanged: () => showT("adAvailabilityChanged"),
                  adShowed: () => showT("adShowed"),
                  adShowFailed: () => showT("adShowFailed"),
                  adClosed: () => showT("adClosed"),
                  adClicked: () => showT("adClicked"),
                );
              },
            ),
            SizedBox(height: 20),
            InkWell(
              child: Container(
                alignment: Alignment.center,
                width: 200,
                height: 40,
                child: Text('加载激励广告'),
                color: Colors.red,
              ),
              onTap: () {
                jdAdtimingPlugin.rewardedVideoAdLoad();
              },
            ),
            SizedBox(height: 20),
            InkWell(
              child: Container(
                alignment: Alignment.center,
                width: 200,
                height: 40,
                child: Text('播放激励广告'),
                color: Colors.red,
              ),
              onTap: () {
                jdAdtimingPlugin.rewardedVideoShowLoad();

                jdAdtimingPlugin.setRewardedVideoAdListener(
                  rewardedVideoAvailabilityChanged: () => showT("rewardedVideoAvailabilityChanged"),
                  rewardedVideoAdShowed: () => showT("rewardedVideoAdShowed"),
                  rewardedVideoAdShowFailed: () => showT("rewardedVideoAdShowFailed"),
                  rewardedVideoAdClicked: () => showT("rewardedVideoAdClicked"),
                  rewardedVideoAdClosed: () => showT("rewardedVideoAdClosed"),
                  rewardedVideoAdStarted: () => showT("rewardedVideoAdStarted"),
                  rewardedVideoAdEnded: () => showT("rewardedVideoAdEnded"),
                  rewardedVideoAdRewarded: () => showT("rewardedVideoAdRewarded"),
                );
              },
            ),
            SizedBox(height: 20),
            SizedBox(height: 20),
            InkWell(
              child: Container(
                alignment: Alignment.center,
                width: 200,
                height: 40,
                child: Text('检测是否有激励广告'),
                color: Colors.red,
              ),
              onTap: () {
                jdAdtimingPlugin.checkInterstitialAd(checkInterstitialAdListener: (bool isHave) {
                  showT("checkInterstitialAdListener:      $isHave");
                });
              },
            ),
            SizedBox(height: 20),
            InkWell(
              child: Container(
                alignment: Alignment.center,
                width: 200,
                height: 40,
                child: Text('检测是否有插屏广告'),
                color: Colors.red,
              ),
              onTap: () {
                jdAdtimingPlugin.checkRewardedVideoAd(checkRewardedVideoAdListener: (bool isHave) {
                  showT("checkRewardedVideoAdListener:      $isHave");
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
