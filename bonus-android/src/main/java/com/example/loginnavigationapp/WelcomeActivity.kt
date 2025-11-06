package com.example.loginnavigationapp

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import com.example.loginnavigationapp.databinding.ActivityWelcomeBinding

class WelcomeActivity : AppCompatActivity() {
    private lateinit var binding: ActivityWelcomeBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityWelcomeBinding.inflate(layoutInflater)
        setContentView(binding.root)

        // Get username from intent
        val username = intent.getStringExtra("username") ?: "User"
        binding.tvWelcome.text = getString(R.string.welcome, username)

        binding.btnLogout.setOnClickListener {
            // Return to login screen
            finish()
        }
    }
}

