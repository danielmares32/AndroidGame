package com.example.chat

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.TextView

class derrota_activity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_derrota)

        val continuar = findViewById<TextView>(R.id.finalizar)
        continuar.setOnClickListener {
            val intent= Intent(this,menu_activity::class.java)
            startActivity(intent)
        }
    }
}