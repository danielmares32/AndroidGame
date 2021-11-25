package com.example.chat

import android.content.Intent
import android.os.Bundle
import android.os.PersistableBundle
import android.util.Log
import android.widget.Button
import android.widget.EditText
import androidx.appcompat.app.AppCompatActivity
import com.android.volley.Request
import com.android.volley.toolbox.JsonObjectRequest
import com.android.volley.toolbox.Volley
import org.json.JSONException
import org.json.JSONObject

class Room2Activity : AppCompatActivity() {

    private lateinit var roomCode:EditText
    private lateinit var playBtn:Button

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_room2)

        roomCode = findViewById(R.id.roomCode)
        playBtn = findViewById(R.id.playBtn)
        val username: String? = intent.getStringExtra("username")

        playBtn.setOnClickListener {
            if(roomCode.text.isNotEmpty()){
                unirsePartida(username!!, roomCode.text.toString())
                requestRoom(username!!, roomCode.text.toString())
            }
        }

    }

    private fun unirsePartida(username: String, roomCode: String){
        val url: String = "http://10.0.2.2:3000/joinGame"
        val requestQueue = Volley.newRequestQueue(this)
        val postData: JSONObject = JSONObject()
        try {
            postData.put("username",username)
            postData.put("gameId", roomCode)
        } catch (e: JSONException){
            Log.d("Error",e.toString())
        }


        Log.d("Data", postData.toString())

        val jsonObjectRequest = JsonObjectRequest(
            Request.Method.POST,
            url,
            postData,
            { response ->
                println(response)
                println(JSONObject(response.toString()).get("message"))
            }
        ) { error -> error.printStackTrace() }

        requestQueue.add(jsonObjectRequest)
    }

    private fun requestRoom(username: String, roomCode: String){
        print("Entre a request room")
        SocketHandler.setSocket()
        SocketHandler.establishConnection()
        val mSocket = SocketHandler.getSocket()

        val data: JSONObject = JSONObject()
        try {
            data.put("user", username)
            data.put("chatId", roomCode)
        } catch (e: JSONException) {
            Log.d("Error", e.toString())
        }
        print("Mando al socket")
        print(data.toString())
        mSocket.emit("chat", data)
        mSocket.on("newUserToChatRoom") { args ->
            if (args[0] != null) {
                val player2 = args[0] as String
                if(player2 != username) {
                    println("Respuesta del socket")
                    println(player2)
                    runOnUiThread {
                        val intent = Intent(this, gameActivity()::class.java).apply {
                            putExtra("username", player2)
                        }
                        startActivity(intent)
                    }
                }
            }
        }

    }

}