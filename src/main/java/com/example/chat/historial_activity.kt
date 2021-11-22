package com.example.chat

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import android.widget.ImageButton
import android.widget.TextView
import com.android.volley.Response
import com.android.volley.toolbox.JsonObjectRequest
import com.android.volley.toolbox.Volley
import org.json.JSONException
import org.json.JSONObject

class historial_activity : AppCompatActivity() {
    private lateinit var partidas : TextView
    private lateinit var victorias : TextView
    private lateinit var derrotas : TextView
    private lateinit var puntos : TextView
    private lateinit var volver : ImageButton
    private val URL = "http://10.0.2.2:3000/buscar_puntuacion"
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_historial)

        //recibimos el id del jugador, necesario para mostrar sus datos
        val id_jugador = intent.getSerializableExtra("username") as String

        partidas = findViewById(R.id.lblPart)
        victorias = findViewById(R.id.lblV)
        derrotas = findViewById(R.id.lblD)
        puntos = findViewById(R.id.lblP)

        ConsultarInfo(id_jugador)
    }

    private fun ConsultarInfo(id_jugador : String){
        val cola = Volley.newRequestQueue(this)

        val postData = JSONObject()
        try {
            postData.put("id", id_jugador)

        } catch (e: JSONException){
            Log.d("Error",e.toString())
        }



        val JsonObjectRequest = JsonObjectRequest(URL,postData, Response.Listener{
            response ->
            Log.d("info_jugador","informacion:,$response")
            partidas.text = response.getString("total_partidas")
            victorias.text = response.getString("total_victorias")
            derrotas.text = response.getString("total_derrotas")
            puntos.text = response.getString("total_puntos")
        },
            Response.ErrorListener { error -> error.printStackTrace() })
        cola.add(JsonObjectRequest)
    }
}