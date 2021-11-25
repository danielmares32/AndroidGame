package com.example.chat

import android.content.Context
import android.content.Intent
import android.util.Log
import androidx.appcompat.app.AppCompatActivity
import androidx.core.content.ContextCompat.startActivity
import com.android.volley.Request
import com.android.volley.RequestQueue
import com.android.volley.toolbox.JsonObjectRequest
import com.android.volley.toolbox.Volley
import org.json.JSONException
import org.json.JSONObject

class ServerRequest() {
    private val url: String = "http://10.0.2.2:3000"
    private lateinit var requestQueue: RequestQueue

    constructor(context: Context) : this() {
        Log.d("Mensaje", "Se crea la clase")
        requestQueue = Volley.newRequestQueue(context)
    }

    public fun login(username: String, password: String){
        val url2 = url+"/login"
        val postData: JSONObject = JSONObject()
        var respuesta = false
        try {
            postData.put("usuario",username)
            postData.put("password", password)
        } catch (e: JSONException){
            Log.d("Error",e.toString())
        }


        Log.d("Data", postData.toString())

        val jsonObjectRequest = JsonObjectRequest(
            Request.Method.POST,
            url2,
            postData,
            { response ->
                println(response)
                println(JSONObject(response.toString()).get("mensaje"))
                val mensaje = JSONObject(response.toString()).get("mensaje")
                 if(mensaje == "login success!"){

                }
            }
        ) { error -> error.printStackTrace() }

        requestQueue.add(jsonObjectRequest)

    }
    public fun registro(name: String, username: String, country: String, password: String){
        val url2 = url+"/registro"
        val postData: JSONObject = JSONObject()
        try {
            postData.put("name", name)
            postData.put("username", username)
            postData.put("country",country)
            postData.put("password", password)
        } catch (e: JSONException){
            Log.d("Error",e.toString())
        }


        Log.d("Data", postData.toString())

        val jsonObjectRequest = JsonObjectRequest(
            Request.Method.POST,
            url2,
            postData,
            { response -> println(response) }
        ) { error -> error.printStackTrace() }

        requestQueue.add(jsonObjectRequest)
    }
    public fun puntuacion():HashMap<String,String>{
        val url2 = url+"/buscar_puntuacion"
        val postData: JSONObject = JSONObject()
        var respuestas = HashMap<String,String>()
        Log.d("Data", postData.toString())

        val jsonObjectRequest = JsonObjectRequest(
            Request.Method.POST,
            url2,
            postData,
            { response ->
                println(response)
                respuestas["total_partidas"] = JSONObject(response.toString()).get("total_partidas").toString()
                respuestas["total_victorias"] = JSONObject(response.toString()).get("total_victorias").toString()
                respuestas["total_derrotas"] = JSONObject(response.toString()).get("total_derrotas").toString()
                respuestas["total_puntos"] = JSONObject(response.toString()).get("total_puntos").toString()
            }
        ) { error -> error.printStackTrace() }

        requestQueue.add(jsonObjectRequest)

        return respuestas;
    }
    public fun nuevaPartida():String{
        val url2 = url+"/newGame"
        val postData: JSONObject = JSONObject()
        var respuesta: String = ""
        Log.d("Data", postData.toString())

        val jsonObjectRequest = JsonObjectRequest(
            Request.Method.POST,
            url2,
            postData,
            { response ->
                println(response)
                println(JSONObject(response.toString()).get("gameId"))
                respuesta = JSONObject(response.toString()).get("gameId").toString()
            }
        ) { error -> error.printStackTrace() }

        requestQueue.add(jsonObjectRequest)

        return respuesta;
    }
    public fun unirsePartida(username: String, roomCode: String):Boolean{
        val url2 = url+"/joinGame"
        var respuesta = false
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
                if(JSONObject(response.toString()).get("message").equals("Unido a la partida")) respuesta=true
            }
        ) { error -> error.printStackTrace() }

        requestQueue.add(jsonObjectRequest)
        return respuesta
    }

}