package com.example.chat

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import android.widget.Button
import android.widget.EditText
import com.android.volley.Request
import org.json.JSONObject
import com.android.volley.toolbox.Volley

import com.android.volley.RequestQueue
import com.android.volley.Response
import com.android.volley.VolleyError

import com.android.volley.toolbox.JsonObjectRequest
import org.json.JSONException




class MainActivity : AppCompatActivity() {

    private lateinit var username: EditText
    private lateinit var password: EditText
    private lateinit var loginBtn: Button
    private lateinit var registroBtn: Button

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_login)

        this.username=findViewById(R.id.username)
        this.password=findViewById(R.id.password)
        this.loginBtn=findViewById(R.id.btnLogin)
        this.registroBtn=findViewById(R.id.btnRegistro)


        this.loginBtn.setOnClickListener {
            login(username.text.toString(),password.text.toString())
        }

        this.registroBtn.setOnClickListener {
            val intent = Intent(this,RegistroActivity::class.java)
            startActivity(intent)
        }

    }

    private fun login(username: String, password: String){
        val url: String = "http://10.0.2.2:3000/login"
        val requestQueue = Volley.newRequestQueue(this)
        val postData: JSONObject = JSONObject()
        try {
            postData.put("usuario",username)
            postData.put("password", password)
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
                println(JSONObject(response.toString()).get("mensaje"))
                val mensaje = JSONObject(response.toString()).get("mensaje")
                if(mensaje == "login success!"){
                    val intent = Intent(this,gameActivity()::class.java).apply { putExtra("username",username) }
                    startActivity(intent)
                }
            }
        ) { error -> error.printStackTrace() }

        requestQueue.add(jsonObjectRequest)
    }

}