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
        default:
      }
      return;
    });

    _channel.invokeMethod('init', <String, dynamic>{'appKey': Platform.isAndroid ? androidAppKey : iosAppKey});
  }

  Future<void> setRewardedVideoAdListener({
    rewardedVideoAdShowed: Function,
    rewardedVideoAdShowFailed: Function,
    rewardedVideoAdClosed: Function,
  }) async {
    _channel.setMethodCallHandler((MethodCall methodCall) {
      switch (methodCall.method) {

        ///激励广告监听
        case 'rewardedVideoAdListener':
          if (methodCall.arguments == "interstitialAdShowed") {
            if (rewardedVideoAdShowed != null) rewardedVideoAdShowed();
          } else if (methodCall.arguments == "rewardedVideoAdShowFailed") {
            if (rewardedVideoAdShowFailed != null) rewardedVideoAdShowFailed();
          } else if (methodCall.arguments == "rewardedVideoAdClosed") {
            if (rewardedVideoAdClosed != null) rewardedVideoAdClosed();
          }
          break;
        default:
      }
      return;
    });
  }

  ///todo
  Future<void> setInterstitialAdListener({
    adShowed: Function,
    adShowFailed: Function,
    adClosed: Function,
  }) async {
    _channel.setMethodCallHandler((MethodCall methodCall) {
      switch (methodCall.method) {

        ///差评广告监听
        case 'interstitialAdListener':
          if (methodCall.arguments == "interstitialAdShowed") {
            if (adShowed != null) adShowed();
          } else if (methodCall.arguments == "interstitialAdShowFailed") {
            if (adShowFailed != null) adShowFailed();
          } else if (methodCall.arguments == "interstitialAdClosed") {
            if (adClosed != null) adClosed();
          }
          break;

        default:
      }
      return;
    });
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
  Future<void> rewardedVideoShowLoad({String extId}) async {
    _channel.invokeMethod('rewardedVideoShowLoad', <String, dynamic>{'extId': extId});
  }

  ///检测插屏广告
  Future<bool> checkInterstitialAd({checkInterstitialAdListener: Function}) async {
    return await _channel.invokeMethod('checkInterstitialAd');
  }

  ///检测激励广告
  Future<bool> checkRewardedVideoAd({checkRewardedVideoAdListener: Function}) async {
    return await _channel.invokeMethod('checkRewardedVideoAd');
  }

  ///测试结果展示
  Future<void> testSuiteLaunch({@required String androidAppKey, @required String iosAppKey}) async {
    _channel.invokeMethod('testSuiteLaunch', <String, dynamic>{'appKey': Platform.isAndroid ? androidAppKey : iosAppKey});
  }
}
