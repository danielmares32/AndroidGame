package com.example.chat

import android.content.Intent
import android.os.Bundle
import android.os.PersistableBundle
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity

class RoomActivity :  AppCompatActivity() {

    private lateinit var enterCode: TextView

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_room)

        val username = intent.getSerializableExtra("username") as String

        enterCode = findViewById(R.id.enterCode)

        enterCode.setOnClickListener {
            val intent = Intent(this,Room2Activity()::class.java).apply { putExtra("username",username) }
            startActivity(intent)
        }

    }



}