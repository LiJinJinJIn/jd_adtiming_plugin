package com.jd.jd_adtiming_plugin


import android.app.Activity
import android.util.Log
import androidx.annotation.NonNull
import com.openmediation.sdk.InitCallback
import com.openmediation.sdk.InitConfiguration
import com.openmediation.sdk.OmAds
import com.openmediation.sdk.interstitial.InterstitialAd
import com.openmediation.sdk.interstitial.InterstitialAdListener
import com.openmediation.sdk.utils.error.Error
import com.openmediation.sdk.utils.model.Scene
import com.openmediation.sdk.video.RewardedVideoAd
import com.openmediation.sdk.video.RewardedVideoListener
import com.openmediation.testsuite.TestSuite
import com.tapjoy.*
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.util.*


/** JdAdtimingPlugin */
class JdAdtimingPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
    private lateinit var channel: MethodChannel
    private lateinit var activity: Activity
    private lateinit var placement: TJPlacement


    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "jd_adtiming_plugin")
        channel.setMethodCallHandler(this)
    }


    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }


    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            "init" -> {
                val appKey = call.argument<String>("appKey") ?: ""
                val configuration = InitConfiguration.Builder()
                        .appKey(appKey)
                        .logEnable(true)
                        .build()

                OmAds.init(activity, configuration, object : InitCallback {
                    override fun onSuccess() {
                        channel.invokeMethod("init", "success")
                    }

                    override fun onError(result: Error) {
                        channel.invokeMethod("init", "fail")
                    }
                })

                InterstitialAd.setAdListener(object : InterstitialAdListener {
                    override fun onInterstitialAdAvailabilityChanged(available: Boolean) {
                        if (available) {
                            channel.invokeMethod("interstitialAdListener", "interstitialAdAvailabilityChanged")
                        }
                    }

                    override fun onInterstitialAdShowed(scene: Scene) {
                        channel.invokeMethod("interstitialAdListener", "interstitialAdShowed")
                    }

                    override fun onInterstitialAdShowFailed(scene: Scene, error: Error) {
                        channel.invokeMethod("interstitialAdListener", "interstitialAdShowFailed")
                    }

                    override fun onInterstitialAdClosed(scene: Scene) {
                        channel.invokeMethod("interstitialAdListener", "interstitialAdClosed")
                    }

                    override fun onInterstitialAdClicked(scene: Scene) {
                        channel.invokeMethod("interstitialAdListener", "interstitialAdClicked")
                    }
                })

                RewardedVideoAd.setAdListener(object : RewardedVideoListener {
                    override fun onRewardedVideoAvailabilityChanged(available: Boolean) {
                        if (available) {
                            channel.invokeMethod("rewardedVideoAdListener", "rewardedVideoAvailabilityChanged")
                        }
                    }

                    override fun onRewardedVideoAdShowed(scene: Scene) {
                        channel.invokeMethod("rewardedVideoAdListener", "rewardedVideoAdShowed")
                    }

                    override fun onRewardedVideoAdShowFailed(scene: Scene, error: Error) {
                        channel.invokeMethod("rewardedVideoAdListener", "rewardedVideoAdShowFailed")
                    }

                    override fun onRewardedVideoAdClicked(scene: Scene) {
                        channel.invokeMethod("rewardedVideoAdListener", "rewardedVideoAdClicked")
                    }

                    override fun onRewardedVideoAdClosed(scene: Scene) {
                        channel.invokeMethod("rewardedVideoAdListener", "rewardedVideoAdClosed")
                    }

                    override fun onRewardedVideoAdStarted(scene: Scene) {
                        channel.invokeMethod("rewardedVideoAdListener", "rewardedVideoAdStarted")
                    }

                    override fun onRewardedVideoAdEnded(scene: Scene) {
                        channel.invokeMethod("rewardedVideoAdListener", "rewardedVideoAdEnded")
                    }

                    override fun onRewardedVideoAdRewarded(scene: Scene) {
                        channel.invokeMethod("rewardedVideoAdListener", "rewardedVideoAdRewarded")
                    }
                })

            }

            "interstitialAdLoad" -> {
                InterstitialAd.loadAd()
            }

            "interstitialShowLoad" -> {
                if (InterstitialAd.isReady()) {
                    InterstitialAd.showAd()
                }
            }

            "checkInterstitialAd" -> {
                channel.invokeMethod("checkInterstitialAd", InterstitialAd.isReady())
            }

            "checkRewardedVideoAd" -> {
                channel.invokeMethod("checkRewardedVideoAd", RewardedVideoAd.isReady())
            }

            "rewardedVideoAdLoad" -> {
                RewardedVideoAd.loadAd()
            }

            "rewardedVideoShowLoad" -> {
                if (RewardedVideoAd.isReady()) {
                    RewardedVideoAd.showAd()
                }
            }

            "testSuiteLaunch" -> {
                val appKey = call.argument<String>("appKey") ?: ""
                TestSuite.launch(activity, appKey)
            }


            ///初始化，这里实现初始化方法
            "initTapJoy" -> {
                val sdkKey = call.argument<String>("sdkKey") ?: ""
                Log.e("xxxx123", "sdkKey>>>                  $sdkKey")
                val connectFlags = Hashtable<String, Any>()
                connectFlags[TapjoyConnectFlag.ENABLE_LOGGING] = "true"
                Tapjoy.connect(activity, sdkKey, connectFlags, object : TJConnectListener {
                    override fun onConnectSuccess() {
                        Log.e("xxxx123", "onConnectSuccess")
                        channel.invokeMethod("initTapJoy", "success")
                    }

                    override fun onConnectFailure() {
                        Log.e("xxxx123", "onConnectFailure")
                        channel.invokeMethod("initTapJoy", "fail")
                    }
                })
            }

            "getPlacement" -> {
                val placementName = call.argument<String>("placementName") ?: ""
                val userid = call.argument<String>("userid") ?: ""
                Log.e("xxxx123", "placementName>>>                  $placementName")
                Tapjoy.setActivity(activity)
                Tapjoy.setUserID(userid)
                placement = Tapjoy.getPlacement(placementName, object : TJPlacementListener {
                    override fun onClick(placement: TJPlacement?) {

                    }

                    override fun onContentShow(placement: TJPlacement?) {
                    }

                    override fun onRequestFailure(placement: TJPlacement?, error: TJError?) {
                        Log.e("xxxx123", "onRequestFailure")
                        runFuncInUIThread {
                            channel.invokeMethod("getPlacement", "onRequestFailure")
                        }
                    }

                    override fun onPurchaseRequest(placement: TJPlacement?, request: TJActionRequest?, productId: String?) {
                    }

                    override fun onRequestSuccess(placement: TJPlacement?) {
                    }

                    override fun onRewardRequest(placement: TJPlacement?, request: TJActionRequest?, itemId: String?, quantity: Int) {
                    }

                    override fun onContentReady(placement: TJPlacement?) {
                        Log.e("xxxx123", "onContentReady")
                        runFuncInUIThread {
                            channel.invokeMethod("getPlacement", "onContentReady")
                            if (placement != null && placement.isContentReady) {
                                placement.showContent()
                            }
                        }

                    }

                    override fun onContentDismiss(placement: TJPlacement?) {
                        Log.e("xxxx123", "onContentDismiss")
                        runFuncInUIThread {
                            channel.invokeMethod("getPlacement", "onContentDismiss")
                        }
                    }

                })
            }

            "requestContent" -> {
                if (Tapjoy.isConnected()) {
                    placement.requestContent()
                }
            }

            else -> {
                result.notImplemented()
            }
        }
    }


    fun runFuncInUIThread(action: () -> Unit) {
        activity.runOnUiThread {
            action()
        }
    }

    override fun onDetachedFromActivity() {
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onDetachedFromActivityForConfigChanges() {
    }
}
