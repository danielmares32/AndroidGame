package com.example.chat

import android.content.Intent
import android.os.Bundle
import android.os.Handler
import android.os.PersistableBundle
import android.util.Log
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity
import com.android.volley.Request
import com.android.volley.toolbox.JsonObjectRequest
import com.android.volley.toolbox.Volley
import org.json.JSONException
import org.json.JSONObject

class RoomActivity :  AppCompatActivity() {

    private lateinit var gameId: String;
    private lateinit var gameIdLbl: TextView
    private lateinit var usernameGlobal: String

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_room)

        gameIdLbl = findViewById(R.id.roomCode)

        val username = intent.getSerializableExtra("username") as String
        this.usernameGlobal = intent.getSerializableExtra("username") as String
        crearPartida(username)
        Handler().postDelayed({
            requestRoom(username, gameId)
        }, 2000)

    }

    private fun crearPartida(username: String){
        val url: String = "http://10.0.2.2:3000/newGame"
        val requestQueue = Volley.newRequestQueue(this)
        val postData: JSONObject = JSONObject()
        try {
            postData.put("username",username)
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
                println(JSONObject(response.toString()).get("gameId"))
                this.gameId = JSONObject(response.toString()).get("gameId").toString()
                this.gameIdLbl.text = "Room Code: "+this.gameId
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
                    println(args[0].toString())
                    runOnUiThread {
                        val intent = Intent(this, gameActivity()::class.java).apply {
                            putExtra("username", player2)
                            putExtra("roomId", roomCode)
                            putExtra("usernameGlobal",usernameGlobal)
                        }
                        startActivity(intent)
                    }
                }
            }
        }

    }

}