package com.example.chat

import android.os.Bundle
import android.util.Log
import android.widget.Button
import android.widget.EditText
import android.widget.TextView
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import com.android.volley.Request
import com.android.volley.toolbox.JsonObjectRequest
import com.android.volley.toolbox.Volley
import org.json.JSONException
import org.json.JSONObject

class RegistroActivity : AppCompatActivity() {

    private lateinit var name: EditText
    private lateinit var username: EditText
    private lateinit var country: EditText
    private lateinit var password: EditText
    private lateinit var passwordConfirm: EditText
    private lateinit var signUp: Button
    private lateinit var status:TextView

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_registro)

        name = findViewById(R.id.name)
        username = findViewById(R.id.username)
        country = findViewById(R.id.country)
        password = findViewById(R.id.password)
        passwordConfirm =findViewById(R.id.passwordConfirm)
        signUp = findViewById(R.id.signup)
        status= findViewById(R.id.stat)

        signUp.setOnClickListener {
            if(password.text.toString() != passwordConfirm.text.toString()){
                Toast.makeText(this, "Invalid Password", Toast.LENGTH_SHORT).show()
            } else {
                registro(name.text.toString(), username.text.toString(), country.text.toString(), password.text.toString())
            }
        }

    }

    private fun registro(name: String, username: String, country: String, password: String){
        val url: String = "http://10.0.2.2:3000/registro"
        val requestQueue = Volley.newRequestQueue(this)
        val postData: JSONObject = JSONObject()
        try {
            postData.put("name", name)
            postData.put("username", username)
            postData.put("country",country)
            postData.put("password", password)
        } catch (e: JSONException){
            status.visibility=TextView.VISIBLE
            status.text="${e.toString()}"

            Log.d("Error",e.toString())
        }


        Log.d("Data", postData.toString())

        val jsonObjectRequest = JsonObjectRequest(
            Request.Method.POST,
            url,
            postData,
            {   response -> println("Respuesta a registro: "+response)
                status.visibility=TextView.VISIBLE
                status.text="${response["message"].toString()}"
                status.visibility=TextView.VISIBLE
            }
        ) { error -> error.printStackTrace()
            status.visibility=TextView.VISIBLE
        }

        requestQueue.add(jsonObjectRequest)
    }

}