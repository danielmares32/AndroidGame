package com.example.chat

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import android.widget.TextView
import com.android.volley.Request
import com.android.volley.toolbox.JsonObjectRequest
import com.android.volley.toolbox.Volley
import org.json.JSONException
import org.json.JSONObject

class derrota_activity : AppCompatActivity() {
    private lateinit var username:String
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_derrota)
        username = intent.getSerializableExtra("usernameGlobal") as String
        actualizarPuntuacion()
        val continuar = findViewById<TextView>(R.id.finalizar)
        continuar.setOnClickListener {
            val intent= Intent(this,menu_activity::class.java).apply { putExtra("username",username) }
            startActivity(intent)
        }
    }

    private fun actualizarPuntuacion(){
        val url: String = "http://10.0.2.2:3000/actualizarPuntuacionDerrota"
        val requestQueue = Volley.newRequestQueue(this)
        val postData: JSONObject = JSONObject()
        try {
            postData.put("usuario",username)
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
                println(JSONObject(response.toString()).get("result"))
            }
        ) { error -> error.printStackTrace() }

        requestQueue.add(jsonObjectRequest)
    }
}