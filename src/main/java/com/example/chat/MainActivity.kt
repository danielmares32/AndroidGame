package com.example.chat

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import android.widget.Button
import android.widget.EditText

class MainActivity : AppCompatActivity() {

    private lateinit var username: EditText
    private lateinit var password: EditText
    private lateinit var logibBtn: Button
    private lateinit var registroBtn: Button

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_login)

        this.username=findViewById(R.id.username)
        this.password=findViewById(R.id.password)
        this.logibBtn=findViewById(R.id.btnLogin)
        this.registroBtn=findViewById(R.id.btnRegistro)

        this.registroBtn.setOnClickListener {
            Log.d("click","Click a registro")
            val intent = Intent(this,RegistroActivity::class.java)
            startActivity(intent)
        }

    }
}