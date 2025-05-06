# Giữ lại tất cả class Flutter
-keep class io.flutter.** { *; }

# Giữ lại Activity chính của bạn
-keep class com.dhapp.music_streaming_app.MainActivity { *; }

# Không thu nhỏ các class của Kotlin (tránh lỗi)
-keep class kotlin.** { *; }

# Giữ lại tất cả phương thức và lớp có annotation @Keep
-keep @androidx.annotation.Keep class * { *; }
-keepclasseswithmembers class * {
    @androidx.annotation.Keep <methods>;
}

# Giữ lại các class liên quan đến thư viện bên thứ ba (nếu cần)
-keep class com.google.gson.** { *; }
-keep class com.squareup.okhttp3.** { *; }



# Giữ lại các class liên quan đến SplitCompat
-keep class io.flutter.embedding.android.FlutterPlayStoreSplitApplication { *; }
-keep class io.flutter.embedding.engine.deferredcomponents.** { *; }

# Suppress warnings for missing classes (from missing_rules.txt)
-dontwarn com.google.android.play.core.splitcompat.SplitCompatApplication
-dontwarn com.google.android.play.core.splitinstall.SplitInstallException
-dontwarn com.google.android.play.core.splitinstall.SplitInstallManager
-dontwarn com.google.android.play.core.splitinstall.SplitInstallManagerFactory
-dontwarn com.google.android.play.core.splitinstall.SplitInstallRequest$Builder
-dontwarn com.google.android.play.core.splitinstall.SplitInstallRequest
-dontwarn com.google.android.play.core.splitinstall.SplitInstallSessionState
-dontwarn com.google.android.play.core.splitinstall.SplitInstallStateUpdatedListener
-dontwarn com.google.android.play.core.tasks.OnFailureListener
-dontwarn com.google.android.play.core.tasks.OnSuccessListener
-dontwarn com.google.android.play.core.tasks.Task