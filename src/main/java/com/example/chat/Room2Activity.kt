package com.example.chat

import android.content.Intent
import android.os.Bundle
import android.os.PersistableBundle
import android.util.Log
import android.widget.Button
import android.widget.EditText
import androidx.appcompat.app.AppCompatActivity
import org.json.JSONException
import org.json.JSONObject

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
            if(roomCode.text.isNotEmpty()){
                requestRoom(username!!, roomCode.text.toString())
            }
        }

    }

    private fun requestRoom(username: String, roomCode: String){
        SocketHandler.setSocket()
        SocketHandler.establishConnection()
        val mSocket = SocketHandler.getSocket()

        val data: JSONObject = JSONObject()
        try {
            data.put("user", username)
            data.put("chatId", roomCode)
        } catch (e: JSONException){
            Log.d("Error",e.toString())
        }

        mSocket.emit("chat",data)

        mSocket.on("chat"){ args ->
            if (args[0] != null) {
                val player2 = args[0] as String
                runOnUiThread {
                    val intent = Intent(this,gameActivity()::class.java).apply { putExtra("username",player2) }
                    startActivity(intent)
                }
            }
        }

    }
}