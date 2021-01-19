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
  String ANDROID_APPKEY = 'i4hJpBqGWk80AecsmbbtnzE33Mp2Cnab';
  String IOS_APPKEY = 'EDFqfTqjvufhdFffteS2bELGGWW3Ifhn';

//tapJoy android 端对应key
  String TAP_JOY_ANDROID_API_KEY = 'q5mzN-kOQYiFw70aTK2ShQECWyXBh6hf8xneT4qXXTiisVLMsAYl_ivsRC9d';
//tapJoy android 端对应展示名称
  String TAP_JOY_ANDROID_PLACEMENT_NAME = 'newsPie_release';
//tapJoy ios 端对应key
  String TAP_JOY_IOS_API_KEY = '8NWIAtT5QpKmovEIwA-vpgEBSBAs5lUMo4We9r0fU1EtZuFlyZG5qdbwvQ2k';
//tapJoy ios 端对应展示名称
  String TAP_JOY_IOS_PLACEMENT_NAME = 'newsPie_ios_release';

  void showT(String msg) {
    print("xxxx123 >>>       $msg ");
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
                height: 30,
                child: Text('init'),
                color: Colors.red,
              ),
              onTap: () {
                jdAdtimingPlugin.init(
                  androidAppKey: ANDROID_APPKEY,
                  iosAppKey: IOS_APPKEY,
                  success: () => showT("success"),
                  fail: () => showT("fail"),
                  adAvailabilityChanged: () => showT("adAvailabilityChanged"),
                  adShowed: () => showT("adShowed"),
                  adShowFailed: () => showT("adShowFailed"),
                  adClosed: () => showT("adClosed"),
                  adClicked: () => showT("adClicked"),
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
            SizedBox(height: 10),
            InkWell(
              child: Container(
                alignment: Alignment.center,
                width: 200,
                height: 30,
                child: Text('加载插屏广告'),
                color: Colors.red,
              ),
              onTap: () {
                jdAdtimingPlugin.interstitialAdLoad();
              },
            ),
            SizedBox(height: 10),
            InkWell(
              child: Container(
                alignment: Alignment.center,
                width: 200,
                height: 30,
                child: Text('播放插屏广告'),
                color: Colors.red,
              ),
              onTap: () {
                jdAdtimingPlugin.interstitialShowLoad();
              },
            ),
            SizedBox(height: 10),
            InkWell(
              child: Container(
                alignment: Alignment.center,
                width: 200,
                height: 30,
                child: Text('加载激励广告'),
                color: Colors.red,
              ),
              onTap: () {
                jdAdtimingPlugin.rewardedVideoAdLoad();
              },
            ),
            SizedBox(height: 10),
            InkWell(
              child: Container(
                alignment: Alignment.center,
                width: 200,
                height: 30,
                child: Text('播放激励广告'),
                color: Colors.red,
              ),
              onTap: () {
                jdAdtimingPlugin.rewardedVideoShowLoad();
              },
            ),
            SizedBox(height: 10),
            InkWell(
              child: Container(
                alignment: Alignment.center,
                width: 200,
                height: 30,
                child: Text('测试'),
                color: Colors.green,
              ),
              onTap: () {
                jdAdtimingPlugin.testSuiteLaunch(androidAppKey: ANDROID_APPKEY, iosAppKey: IOS_APPKEY);
              },
            ),
            SizedBox(height: 10),
            InkWell(
              child: Container(
                alignment: Alignment.center,
                width: 200,
                height: 30,
                child: Text('检测是否有激励广告'),
                color: Colors.red,
              ),
              onTap: () {
                jdAdtimingPlugin.checkInterstitialAd(checkInterstitialAdListener: (bool isHave) {
                  showT("checkInterstitialAdListener:      $isHave");
                });
              },
            ),
            SizedBox(height: 10),
            InkWell(
              child: Container(
                alignment: Alignment.center,
                width: 200,
                height: 50,
                child: Text('检测是否有插屏广告'),
                color: Colors.red,
              ),
              onTap: () {
                jdAdtimingPlugin.checkRewardedVideoAd(checkRewardedVideoAdListener: (bool isHave) {
                  showT("checkRewardedVideoAdListener:      $isHave");
                });
              },
            ),
            SizedBox(height: 10),
            InkWell(
              child: Container(
                alignment: Alignment.center,
                width: 200,
                height: 50,
                child: Text('初始化tapjoy'),
                color: Colors.blue,
              ),
              onTap: () {
                jdAdtimingPlugin.initTapJoy(
                  androidAppKey: TAP_JOY_ANDROID_API_KEY,
                  iosAppKey: TAP_JOY_IOS_API_KEY,
                  initTapJoySuccessListener: () => showT(">>>         initTapJoySuccessListener"),
                  initTapJoyFailureListener: () => showT(">>>         initTapJoyFailureListener"),
                );
              },
            ),
            SizedBox(height: 10),
            InkWell(
              child: Container(
                alignment: Alignment.center,
                width: 200,
                height: 50,
                child: Text('初始化内容'),
                color: Colors.blue,
              ),
              onTap: () {
                jdAdtimingPlugin.getPlacement(
                  androidPlacementName: TAP_JOY_ANDROID_PLACEMENT_NAME,
                  iosPlacementName: TAP_JOY_IOS_PLACEMENT_NAME,
                  userId: '1111',
                  tapJoyRequestFailureListener: () => showT(">>>         tapJoyRequestFailureListener"),
                  tapJoyContentReadyListener: () => showT(">>>         tapJoyContentReadyListener"),
                  tapJoyContentDismissListener: () => showT(">>>         tapJoyContentDismissListener"),
                );
              },
            ),

            SizedBox(height: 10),
            InkWell(
              child: Container(
                alignment: Alignment.center,
                width: 200,
                height: 50,
                child: Text('展示'),
                color: Colors.blue,
              ),
              onTap: () {
                jdAdtimingPlugin.requestContent();
              },
            ),
          ],
        ),
      ),
    );
  }
}
