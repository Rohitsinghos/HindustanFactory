# Razorpay keep rules
-keep class com.razorpay.** { *; }
-dontwarn com.razorpay.**
-keep class proguard.annotation.Keep
-keep class proguard.annotation.KeepClassMembers
-keep @interface proguard.annotation.Keep
-keep @interface proguard.annotation.KeepClassMembers
