# Razorpay keep rules
-keep class com.razorpay.** { *; }
-keep interface com.razorpay.** { *; }

# Keep Razorpay annotation references
-keepattributes *Annotation*
-dontwarn com.razorpay.**

# Fix for missing proguard.annotation.Keep issue
-dontwarn proguard.annotation.**
