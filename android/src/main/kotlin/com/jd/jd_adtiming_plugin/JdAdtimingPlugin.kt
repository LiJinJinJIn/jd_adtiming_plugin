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
                        showLog("onInterstitialAdAvailabilityChanged")
                    }

                    override fun onInterstitialAdShowed(scene: Scene) {
                        showLog("onInterstitialAdShowed")
                        channel.invokeMethod("interstitialAdListener", "interstitialAdShowed")
                    }

                    override fun onInterstitialAdShowFailed(scene: Scene, error: Error) {
                        showLog("onInterstitialAdShowFailed")
                        channel.invokeMethod("interstitialAdListener", "interstitialAdShowFailed")
                    }

                    override fun onInterstitialAdClosed(scene: Scene) {
                        showLog("onInterstitialAdClosed")
                        channel.invokeMethod("interstitialAdListener", "interstitialAdClosed")
                    }

                    override fun onInterstitialAdClicked(scene: Scene) {
                        showLog("onInterstitialAdClicked")
                    }
                })



                RewardedVideoAd.setAdListener(object : RewardedVideoListener {
                    override fun onRewardedVideoAvailabilityChanged(available: Boolean) {
                        showLog("onRewardedVideoAvailabilityChanged")
                    }

                    override fun onRewardedVideoAdShowed(scene: Scene) {
                        showLog("onRewardedVideoAdShowed")
                        channel.invokeMethod("rewardedVideoAdListener", "rewardedVideoAdShowed")
                    }

                    override fun onRewardedVideoAdShowFailed(scene: Scene, error: Error) {
                        showLog("onRewardedVideoAdShowFailed")
                        channel.invokeMethod("rewardedVideoAdListener", "rewardedVideoAdShowFailed")
                    }

                    override fun onRewardedVideoAdClicked(scene: Scene) {
                        showLog("onRewardedVideoAdClicked")
                    }

                    override fun onRewardedVideoAdClosed(scene: Scene) {
                        showLog("onRewardedVideoAdClosed")
                        channel.invokeMethod("rewardedVideoAdListener", "rewardedVideoAdClosed")
                    }

                    override fun onRewardedVideoAdStarted(scene: Scene) {
                        showLog("onRewardedVideoAdStarted")
                    }

                    override fun onRewardedVideoAdEnded(scene: Scene) {
                        showLog("onRewardedVideoAdEnded")
                    }

                    override fun onRewardedVideoAdRewarded(scene: Scene) {
                        showLog("onRewardedVideoAdRewarded")
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

    private fun showLog(msg: String) {
        Log.e("JdAdtimingPlugin", msg)
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
