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


    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "jd_adtiming_plugin")
        channel.setMethodCallHandler(this)
    }


    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }


    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        Log.e("xxxx123", " method               ${call.method}");
        when (call.method) {
            "init" -> {
                val appKey = call.argument<String>("appKey") ?: ""
                Log.e("xxxx123", "appKey :      $appKey")

                val configuration = InitConfiguration.Builder()
                        .appKey(appKey)
                        .logEnable(true)
                        .build()

                OmAds.init(activity, configuration, object : InitCallback {
                    override fun onSuccess() {
                        Log.e("xxxx123", " 11>>>>>>        success")
                        channel.invokeMethod("init", "success")
                    }

                    override fun onError(result: Error) {
                        Log.e("xxxx123", " 11>>>>>>        fail")

                        channel.invokeMethod("init", "fail")
                    }
                })

                InterstitialAd.setAdListener(object :
                        InterstitialAdListener {
                    override fun onInterstitialAdAvailabilityChanged(available: Boolean) {
                        if (available) {
                            channel.invokeMethod("interstitialAdListener", "interstitialAdAvailabilityChanged")
                        }
                    }

                    override fun onInterstitialAdShowed(scene: Scene) {
                        channel.invokeMethod("interstitialAdListener", "interstitialAdShowed")
                    }

                    override fun onInterstitialAdShowFailed(scene: Scene, error: Error) {
                        Log.e("xxxx123", "error:          $error")
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
                        Log.e("xxxx123", "onRewardedVideoAvailabilityChanged :      $available")
                        if (available) {
                            channel.invokeMethod("rewardedVideoAdListener", "rewardedVideoAvailabilityChanged")
                        }
                    }

                    override fun onRewardedVideoAdShowed(scene: Scene) {
                        Log.e("xxxx123", "onRewardedVideoAdShowed")
                        channel.invokeMethod("rewardedVideoAdListener", "rewardedVideoAdShowed")
                    }

                    override fun onRewardedVideoAdShowFailed(scene: Scene, error: Error) {
                        Log.e("xxxx123", "onRewardedVideoAdShowFailed")
                        channel.invokeMethod("rewardedVideoAdListener", "rewardedVideoAdShowFailed")
                    }

                    override fun onRewardedVideoAdClicked(scene: Scene) {
                        Log.e("xxxx123", "onRewardedVideoAdClicked")
                        channel.invokeMethod("rewardedVideoAdListener", "rewardedVideoAdClicked")
                    }

                    override fun onRewardedVideoAdClosed(scene: Scene) {
                        Log.e("xxxx123", "onRewardedVideoAdClosed")
                        channel.invokeMethod("rewardedVideoAdListener", "rewardedVideoAdClosed")
                    }

                    override fun onRewardedVideoAdStarted(scene: Scene) {
                        Log.e("xxxx123", "onRewardedVideoAdStarted")
                        channel.invokeMethod("rewardedVideoAdListener", "rewardedVideoAdStarted")
                    }

                    override fun onRewardedVideoAdEnded(scene: Scene) {
                        Log.e("xxxx123", "onRewardedVideoAdEnded")
                        channel.invokeMethod("rewardedVideoAdListener", "rewardedVideoAdEnded")
                    }

                    override fun onRewardedVideoAdRewarded(scene: Scene) {
                        Log.e("xxxx123", "onRewardedVideoAdRewarded")
                        channel.invokeMethod("rewardedVideoAdListener", "rewardedVideoAdRewarded")
                    }
                })

            }

            "interstitialAdLoad" -> {
                Log.e("xxxx123", " 进来               interstitialAdLoad")
                InterstitialAd.loadAd()
            }

            "interstitialShowLoad" -> {
                Log.e("xxxx123", " interstitialShowLoad               ${InterstitialAd.isReady()}")
                if (InterstitialAd.isReady()) {
                    InterstitialAd.showAd()
                }
            }

            "checkInterstitialAd"->{
                channel.invokeMethod("checkInterstitialAd", InterstitialAd.isReady())
            }
            
            "checkRewardedVideoAd"->{
                channel.invokeMethod("checkRewardedVideoAd", RewardedVideoAd.isReady())
            }


            "rewardedVideoAdLoad" -> {
                Log.e("xxxx123", " 进来               rewardedVideoAdLoad")
                RewardedVideoAd.loadAd()
            }

            "rewardedVideoShowLoad" -> {
                Log.e("xxxx123", " rewardedVideoShowLoad               ${RewardedVideoAd.isReady()}")
                if (RewardedVideoAd.isReady()) {
                    RewardedVideoAd.showAd()
                }
            }

            "testSuiteLaunch" -> {
                val appKey = call.argument<String>("appKey") ?: ""
                Log.e("xxxx123", "testSuiteLaunch :      $appKey")
                TestSuite.launch(activity, appKey)
            }

            else -> {
                result.notImplemented()
            }
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
