import Flutter
import UIKit
import OpenMediation


public class SwiftJdAdtimingPlugin: NSObject, FlutterPlugin ,OMRewardedVideoDelegate,OMInterstitialDelegate{
  static var channel: FlutterMethodChannel!
    
  public static func register(with registrar: FlutterPluginRegistrar) {
    channel = FlutterMethodChannel(name: "jd_adtiming_plugin", binaryMessenger: registrar.messenger())
    let instance = SwiftJdAdtimingPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
        case "init":
            guard let dic = call.arguments as? Dictionary<String, Any> else { return }
            let appKey = dic["appKey"] as? String ?? ""
            OpenMediation.initWithAppKey(appKey)
            OMRewardedVideo.sharedInstance().add(self)
            OMInterstitial.sharedInstance().add(self)

        case "testSuiteLaunch":
            guard let dic = call.arguments as? Dictionary<String, Any> else { return }
            let appKey = dic["appKey"] as? String ?? ""
            let viewController = UIApplication.shared.keyWindow?.rootViewController as? FlutterViewController
            if (viewController != nil) {
                OMTestSuite.present(withAppKey: appKey, on:viewController!)
            }
            
        case "rewardedVideoAdLoad":
            OMRewardedVideo.load()
            
        case "rewardedVideoShowLoad":
            if OMRewardedVideo.sharedInstance().isReady() {
                let viewController = UIApplication.shared.keyWindow?.rootViewController as? FlutterViewController
                if (viewController != nil) {
                    OMRewardedVideo.sharedInstance().show(with: viewController!, scene: "YOUR_SCENE_NAME")
                }
                
            }
        case "interstitialAdLoad":
            OMInterstitial.load()
            
        case "interstitialShowLoad":
            if OMInterstitial.sharedInstance().isReady() {
                let viewController = UIApplication.shared.keyWindow?.rootViewController as? FlutterViewController
                if (viewController != nil) {
                    OMInterstitial.sharedInstance().show(with: viewController!, scene: "YOUR_SCENE_NAME")
                }
            }
            
        case "checkInterstitialAd":
            SwiftJdAdtimingPlugin.channel.invokeMethod("checkInterstitialAd", arguments: OMInterstitial.sharedInstance().isReady())
            
        case "checkRewardedVideoAd":
            SwiftJdAdtimingPlugin.channel.invokeMethod("checkRewardedVideoAd", arguments: OMRewardedVideo.sharedInstance().isReady())
        default:
            break
    }
  }
    
    
    // 插屏广告回调
  public func omInterstitialChangedAvailability(_ available: Bool) {
    SwiftJdAdtimingPlugin.channel.invokeMethod("interstitialAdListener", arguments: "interstitialAdAvailabilityChanged")
  }
    
  public func omInterstitialDidShow(_ scene: OMScene) {
    SwiftJdAdtimingPlugin.channel.invokeMethod("interstitialAdListener", arguments: "interstitialAdShowed")
  }
    
  public func omInterstitialDidClick(_ scene: OMScene) {
    SwiftJdAdtimingPlugin.channel.invokeMethod("interstitialAdListener", arguments: "interstitialAdClicked")
  }
    
  public func omInterstitialDidClose(_ scene: OMScene) {
    SwiftJdAdtimingPlugin.channel.invokeMethod("interstitialAdListener", arguments: "interstitialAdClosed")
  }
    
  public func omInterstitialDidFail(toShow scene: OMScene, withError error: Error) {
    SwiftJdAdtimingPlugin.channel.invokeMethod("interstitialAdListener", arguments: "interstitialAdShowFailed")
  }
    
    // 激励广告回调
  public func omRewardedVideoChangedAvailability(_ available: Bool) {
    SwiftJdAdtimingPlugin.channel.invokeMethod("rewardedVideoAdListener", arguments: "rewardedVideoAvailabilityChanged")
  }

  public func omRewardedVideoPlayStart(_ scene: OMScene) {
    SwiftJdAdtimingPlugin.channel.invokeMethod("rewardedVideoAdListener", arguments: "rewardedVideoAdStarted")
  }
    
  public func omRewardedVideoPlayEnd(_ scene: OMScene) {
    SwiftJdAdtimingPlugin.channel.invokeMethod("rewardedVideoAdListener", arguments: "rewardedVideoAdEnded")
  }
    
  public func omRewardedVideoDidClick(_ scene: OMScene) {
    SwiftJdAdtimingPlugin.channel.invokeMethod("rewardedVideoAdListener", arguments: "rewardedVideoAdClicked")
  }
    
  public func omRewardedVideoDidReceiveReward(_ scene: OMScene) {
    SwiftJdAdtimingPlugin.channel.invokeMethod("rewardedVideoAdListener", arguments: "rewardedVideoAdRewarded")
  }
    
  public func omRewardedVideoDidClose(_ scene: OMScene) {
    SwiftJdAdtimingPlugin.channel.invokeMethod("rewardedVideoAdListener", arguments: "rewardedVideoAdClosed")
  }
    
  public func omRewardedVideoDidFail(toShow scene: OMScene, withError error: Error) {
    SwiftJdAdtimingPlugin.channel.invokeMethod("rewardedVideoAdListener", arguments: "rewardedVideoAdShowFailed")
  }
    
}
