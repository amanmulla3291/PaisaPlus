package com.paisaplus.paisaplus

import io.flutter.embedding.android.FlutterFragmentActivity
import android.view.WindowManager
import android.os.Bundle

class MainActivity : FlutterFragmentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        // Prevent screenshots and obscurate app in recent apps list
        window.setFlags(WindowManager.LayoutParams.FLAG_SECURE, WindowManager.LayoutParams.FLAG_SECURE)
    }
}