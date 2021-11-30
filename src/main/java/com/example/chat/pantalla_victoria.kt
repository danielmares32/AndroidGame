package com.example.chat

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.TextView

class pantalla_victoria : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_pantalla_victoria)
        val continuar = findViewById<TextView>(R.id.finalizar)
        val username = intent.getSerializableExtra("usernameGlobal") as String
        continuar.setOnClickListener {
            val intent= Intent(this,menu_activity::class.java).apply { putExtra("username",username) }
            startActivity(intent)
        }
    }
}