package com.jd.jd_adtiming_plugin


import android.app.Activity
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
                    }
                })



                RewardedVideoAd.setAdListener(object : RewardedVideoListener {
                    override fun onRewardedVideoAvailabilityChanged(available: Boolean) {
                    }

                    override fun onRewardedVideoAdShowed(scene: Scene) {
                        channel.invokeMethod("rewardedVideoAdListener", "rewardedVideoAdShowed")
                    }

                    override fun onRewardedVideoAdShowFailed(scene: Scene, error: Error) {
                        channel.invokeMethod("rewardedVideoAdListener", "rewardedVideoAdShowFailed")
                    }

                    override fun onRewardedVideoAdClicked(scene: Scene) {
                    }

                    override fun onRewardedVideoAdClosed(scene: Scene) {
                        channel.invokeMethod("rewardedVideoAdListener", "rewardedVideoAdClosed")
                    }

                    override fun onRewardedVideoAdStarted(scene: Scene) {
                    }

                    override fun onRewardedVideoAdEnded(scene: Scene) {
                    }

                    override fun onRewardedVideoAdRewarded(scene: Scene) {
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
                result.success(InterstitialAd.isReady())
            }

            "checkRewardedVideoAd" -> {
                result.success(RewardedVideoAd.isReady())
            }


            "rewardedVideoAdLoad" -> {
                RewardedVideoAd.loadAd()
            }

            "rewardedVideoShowLoad" -> {
                val extId = call.argument<String>("extId") ?: ""
                if (RewardedVideoAd.isReady()) {
                    RewardedVideoAd.setExtId("", extId)
                    RewardedVideoAd.showAd()
                }
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
