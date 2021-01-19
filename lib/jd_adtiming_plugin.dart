import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

///adtiming插件，这里对接双端api处理
class JdAdtimingPlugin {
  static const MethodChannel _channel = const MethodChannel('jd_adtiming_plugin');

  ///初始化api
  ///其中androidAppKey ， iosAppKey 为必须选项且必须适配
  Future<void> init({
    @required String androidAppKey,
    @required String iosAppKey,
    success: Function,
    fail: Function,
    adAvailabilityChanged: Function,
    adShowed: Function,
    adShowFailed: Function,
    adClosed: Function,
    adClicked: Function,
    rewardedVideoAvailabilityChanged: Function,
    rewardedVideoAdShowed: Function,
    rewardedVideoAdShowFailed: Function,
    rewardedVideoAdClicked: Function,
    rewardedVideoAdClosed: Function,
    rewardedVideoAdStarted: Function,
    rewardedVideoAdEnded: Function,
    rewardedVideoAdRewarded: Function,
  }) async {
    _channel.setMethodCallHandler((MethodCall methodCall) {
      switch (methodCall.method) {

        ///初始化
        case 'init':
          if (methodCall.arguments == "success") {
            if (success != null) success();
          } else {
            if (fail != null) fail();
          }
          break;

        ///差评广告监听
        case 'interstitialAdListener':
          if (methodCall.arguments == "interstitialAdAvailabilityChanged") {
            if (adAvailabilityChanged != null) adAvailabilityChanged();
          } else if (methodCall.arguments == "interstitialAdShowed") {
            if (adShowed != null) adShowed();
          } else if (methodCall.arguments == "interstitialAdShowFailed") {
            if (adShowFailed != null) adShowFailed();
          } else if (methodCall.arguments == "interstitialAdClosed") {
            if (adClosed != null) adClosed();
          } else if (methodCall.arguments == "interstitialAdClicked") {
            if (adClicked != null) adClicked();
          }
          break;

        ///激励广告监听
        case 'rewardedVideoAdListener':
          if (methodCall.arguments == "rewardedVideoAvailabilityChanged") {
            if (rewardedVideoAvailabilityChanged != null) rewardedVideoAvailabilityChanged();
          } else if (methodCall.arguments == "interstitialAdShowed") {
            if (rewardedVideoAdShowed != null) rewardedVideoAdShowed();
          } else if (methodCall.arguments == "rewardedVideoAdShowFailed") {
            if (rewardedVideoAdShowFailed != null) rewardedVideoAdShowFailed();
          } else if (methodCall.arguments == "rewardedVideoAdClicked") {
            if (rewardedVideoAdClicked != null) rewardedVideoAdClicked();
          } else if (methodCall.arguments == "rewardedVideoAdClosed") {
            if (rewardedVideoAdClosed != null) rewardedVideoAdClosed();
          } else if (methodCall.arguments == "rewardedVideoAdStarted") {
            if (rewardedVideoAdStarted != null) rewardedVideoAdStarted();
          } else if (methodCall.arguments == "rewardedVideoAdEnded") {
            if (rewardedVideoAdEnded != null) rewardedVideoAdEnded();
          } else if (methodCall.arguments == "rewardedVideoAdRewarded") {
            if (rewardedVideoAdRewarded != null) rewardedVideoAdRewarded();
          }

          break;
        default:
      }
      return;
    });

    _channel.invokeMethod('init', <String, dynamic>{'appKey': Platform.isAndroid ? androidAppKey : iosAppKey});
  }

  ///加载插屏广告
  Future<void> interstitialAdLoad() async {
    _channel.invokeMethod('interstitialAdLoad');
  }

  ///展示插屏广告
  Future<void> interstitialShowLoad() async {
    _channel.invokeMethod('interstitialShowLoad');
  }

  ///加载激励广告
  Future<void> rewardedVideoAdLoad() async {
    _channel.invokeMethod('rewardedVideoAdLoad');
  }

  ///展示激励广告
  Future<void> rewardedVideoShowLoad() async {
    _channel.invokeMethod('rewardedVideoShowLoad');
  }

  ///检测插屏广告
  Future<void> checkInterstitialAd({checkInterstitialAdListener: Function}) async {
    _channel.setMethodCallHandler((MethodCall methodCall) {
      switch (methodCall.method) {

        ///初始化
        case 'checkInterstitialAd':
          if (checkInterstitialAd != null) checkInterstitialAdListener(methodCall.arguments);
          break;
        default:
      }
      return;
    });

    _channel.invokeMethod('checkInterstitialAd');
  }

  ///检测激励广告
  Future<void> checkRewardedVideoAd({checkRewardedVideoAdListener: Function}) async {
    _channel.setMethodCallHandler((MethodCall methodCall) {
      switch (methodCall.method) {

        ///初始化
        case 'checkRewardedVideoAd':
          if (checkInterstitialAd != null) checkRewardedVideoAdListener(methodCall.arguments);
          break;
        default:
      }
      return;
    });

    _channel.invokeMethod('checkRewardedVideoAd');
  }

  ///测试结果展示
  Future<void> testSuiteLaunch({@required String androidAppKey, @required String iosAppKey}) async {
    _channel.invokeMethod('testSuiteLaunch', <String, dynamic>{'appKey': Platform.isAndroid ? androidAppKey : iosAppKey});
  }
}
