package com.example.chat

import android.os.Bundle
import android.os.PersistableBundle
import android.widget.Button
import android.widget.EditText
import androidx.appcompat.app.AppCompatActivity

class Room2Activity : AppCompatActivity() {

    private lateinit var roomCode:EditText
    private lateinit var playBtn:Button

    override fun onCreate(savedInstanceState: Bundle?, persistentState: PersistableBundle?) {
        super.onCreate(savedInstanceState, persistentState)
        setContentView(R.layout.activity_room2)

        roomCode = findViewById(R.id.roomCode)
        playBtn = findViewById(R.id.playBtn)
        val username: String? = intent.getStringExtra("username")

        playBtn.setOnClickListener {
            if(roomCode.text.length>0){
                requestRoom(username!!, roomCode.text.toString())
            }
        }

    }

    private fun requestRoom(username: String, roomCode: String){

    }
}