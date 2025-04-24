-keep class com.android.billingclient.** { *; }
-keepclassmembers class * {
    @com.android.billingclient.api.BillingClient$SkuType <fields>;
}
# Keep TensorFlow Lite GPU delegate classes
-keep class org.tensorflow.** { *; }
-dontwarn org.tensorflow.**
-keepattributes *Annotation*
