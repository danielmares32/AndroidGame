package com.example.chat

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import android.widget.Button
import android.widget.Toast
import androidx.recyclerview.widget.DividerItemDecoration
import androidx.recyclerview.widget.GridLayoutManager
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.example.chat.R
import org.json.JSONException
import org.json.JSONObject
import android.content.DialogInterface
import android.app.AlertDialog
import android.graphics.drawable.Drawable

import android.view.LayoutInflater
import android.view.View
import android.widget.ImageView
import android.widget.TextView
import androidx.core.content.res.ResourcesCompat
import com.android.volley.Request
import com.android.volley.toolbox.JsonObjectRequest
import com.android.volley.toolbox.Volley




class gameActivity : AppCompatActivity() {
    private lateinit var person: RecyclerView
    private lateinit var chat: ChatActivity
    private lateinit var miPersonaje: Button
    private lateinit var btnAdivinar: Button
    private lateinit var username: String
    private lateinit var chatId: String
    private lateinit var personaje: String
    private val mSocket = SocketHandler.getSocket()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.game_activity)

        person = findViewById(R.id.Personaje)
        chat = findViewById(R.id.chat)
        miPersonaje = findViewById(R.id.miPersonaje)
        btnAdivinar = findViewById(R.id.btnAdivinar)

        username = intent.getStringExtra("username")!!
        chatId = intent.getStringExtra("roomId")!!
        chat.setUserName("Rival: "+username)

        setMiPersonajeApi()

        chat.getLblsend().setOnClickListener {
            if(chat.getMensaje().text.toString() != ""){
                chat.getChatList().add(Message(username,chat.getMensaje().text.toString(),chatId,0))
                val adapter = ChatAdapter(this, chat.getChatList())
                chat.getRecycler().layoutManager = LinearLayoutManager(this)
                chat.getRecycler().adapter = adapter
                chat.getRecycler().scrollToPosition(chat.getChatList().size - 1)
                enviarMensajes()
                chat.getMensaje().text = ""
            }
        }

        miPersonaje.setOnClickListener {
            getMiPersonaje(personaje)
        }


        SocketHandler.setSocket()
        SocketHandler.establishConnection()

        mSocket.on("updateChat") { args ->
            if (args[0] != null) {
                println("Respuesta del socket")
                val res = args[0] as String
                val datos = JSONObject(res)
                println(datos)
                if(datos.get("user").toString() != username) {
                    runOnUiThread {
                        chat.getChatList().add(
                            Message(
                                datos.get("user").toString(),
                                datos.get("messageContent").toString(),
                                datos.get("chatId").toString(),
                                1
                            )
                        )
                        val adapter = ChatAdapter(this, chat.getChatList())
                        chat.getRecycler().layoutManager = LinearLayoutManager(this)
                        chat.getRecycler().adapter = adapter
                        chat.getRecycler().scrollToPosition(chat.getChatList().size - 1)
                    }
                }
            }
        }


        val datos = MutableList(1){
            Personaje(R.drawable.chrono.toString(),"Chrono")
        }
        datos.add(Personaje(R.drawable.ashketchum.toString(),"Ash Ketchum"))
        datos.add(Personaje(R.drawable.cortana_halo.toString(),"Cortana"))
        datos.add(Personaje(R.drawable.bigboss.toString(),"Big Boss (Snake)"))
        datos.add(Personaje(R.drawable.hunter.toString(),"Cazador"))
        datos.add(Personaje(R.drawable.samus.toString(),"Samus"))
        datos.add(Personaje(R.drawable.futaba_p5.toString(),"Futaba"))
        datos.add(Personaje(R.drawable.steve.toString(),"Steve"))
        datos.add(Personaje(R.drawable.yoshi.toString(),"Yoshi"))
        datos.add(Personaje(R.drawable.vader.toString(),"Vader"))
        datos.add(Personaje(R.drawable.pacman.toString(),"Pacman"))
        datos.add(Personaje(R.drawable.masterchief.toString(),"Master Chief"))
        datos.add(Personaje(R.drawable.mario.toString(),"Mario"))
        datos.add(Personaje(R.drawable.joker_p5.toString(),"Joker"))
        datos.add(Personaje(R.drawable.kratos.toString(),"Kratos"))
        datos.add(Personaje(R.drawable.a2_nier_automata.toString(),"A2"))
        datos.add(Personaje(R.drawable.batman.toString(),"Batman"))
        datos.add(Personaje(R.drawable.dva.toString(),"D.Va"))
        datos.add(Personaje(R.drawable.ghost.toString(),"Ghost"))
        datos.add(Personaje(R.drawable.gwen.toString(),"Gwen"))
        datos.add(Personaje(R.drawable.haru_p5.toString(),"Haru"))
        datos.add(Personaje(R.drawable.jinx.toString(),"Powder"))
        datos.add(Personaje(R.drawable.toad.toString(),"Toad"))
        datos.add(Personaje(R.drawable.kasumi_p5.toString(),"Kasumi"))


        var nombres= mutableSetOf<CharSequence>()
        for (dato in datos){
            nombres.add(dato.Nom)
        }
        val nombresArray = nombres.toTypedArray()
        nombresArray.sort()
        btnAdivinar.setOnClickListener {
            val dialog = AlertDialog.Builder(this)
            dialog.setTitle("Seleccione el personaje a adivinar")
            dialog.setItems(nombresArray,
                DialogInterface.OnClickListener { dialog, position ->
                    Toast.makeText(
                        applicationContext,
                        "selected Item:$position",
                        Toast.LENGTH_SHORT
                    ).show()
                })
            dialog.setPositiveButton(
                "Cerrar"
            ) { dialog, which ->
                dialog.dismiss()
            }
            val alert = dialog.create()
            alert.show()
        }

        val adaptador= AdaptadorPersonaje(datos){
            //val intent = Intent (MainActivity@this,)
            Toast.makeText(this,"Personaje escogido: ${it.Nom}",Toast.LENGTH_SHORT).show()
        }
        person.setHasFixedSize(true)
        person.layoutManager=
            GridLayoutManager(this,3)
        person.addItemDecoration(DividerItemDecoration(this, DividerItemDecoration.VERTICAL))
        person.addItemDecoration(DividerItemDecoration(this,DividerItemDecoration.HORIZONTAL))
        person.adapter=adaptador

    }

    private fun enviarMensajes(){
        print("Entre a enviar mensaje")

        val data: JSONObject = JSONObject()
        try {
            data.put("username", chat.getChatList().last().userName)
            data.put("chatId", chat.getChatList().last().roomName)
            data.put("message",chat.getChatList().last().messageContent)
        } catch (e: JSONException) {
            Log.d("Error", e.toString())
        }
        print("Mando al socket")
        print(data.toString())
        mSocket.emit("newMessage", data)


    }

    private fun getMiPersonaje(personaje: String){
        val alertadd: AlertDialog.Builder = AlertDialog.Builder(this)
        val factory = LayoutInflater.from(this)
        val view: View = factory.inflate(R.layout.mi_personaje_dialog, null)
        val nombreMiPersonaje: TextView = view.findViewById(R.id.txtPersonaje)
        val imageMiPersonaje: ImageView = view.findViewById(R.id.PImagen)
        print(R.drawable.yoshi.toString())
        imageMiPersonaje.background = when(personaje){
            "a2"->ResourcesCompat.getDrawable(resources, R.drawable.a2_nier_automata, null)
            "ash"->ResourcesCompat.getDrawable(resources, R.drawable.ashketchum, null)
            "batman"->ResourcesCompat.getDrawable(resources, R.drawable.batman, null)
            "bigboss"->ResourcesCompat.getDrawable(resources, R.drawable.bigboss, null)
            "chrono"->ResourcesCompat.getDrawable(resources, R.drawable.chrono, null)
            "cortana"->ResourcesCompat.getDrawable(resources, R.drawable.cortana_halo, null)
            "dva"->ResourcesCompat.getDrawable(resources, R.drawable.dva, null)
            "futaba"->ResourcesCompat.getDrawable(resources, R.drawable.futaba_p5, null)
            "ghost"->ResourcesCompat.getDrawable(resources, R.drawable.ghost, null)
            "gwen"->ResourcesCompat.getDrawable(resources, R.drawable.gwen, null)
            "haru"->ResourcesCompat.getDrawable(resources, R.drawable.haru_p5, null)
            "hunter"->ResourcesCompat.getDrawable(resources, R.drawable.hunter, null)
            "jinx"->ResourcesCompat.getDrawable(resources, R.drawable.jinx, null)
            "joker"->ResourcesCompat.getDrawable(resources, R.drawable.joker_p5, null)
            "kasumi"->ResourcesCompat.getDrawable(resources, R.drawable.kasumi_p5, null)
            "kratos"->ResourcesCompat.getDrawable(resources, R.drawable.kratos, null)
            "mario"->ResourcesCompat.getDrawable(resources, R.drawable.mario, null)
            "masterchief"->ResourcesCompat.getDrawable(resources, R.drawable.masterchief, null)
            "pacman"->ResourcesCompat.getDrawable(resources, R.drawable.pacman, null)
            "samus"->ResourcesCompat.getDrawable(resources, R.drawable.samus, null)
            "steve"->ResourcesCompat.getDrawable(resources, R.drawable.steve, null)
            "toad"->ResourcesCompat.getDrawable(resources, R.drawable.toad, null)
            "vader"->ResourcesCompat.getDrawable(resources, R.drawable.vader, null)
            "yoshi"->ResourcesCompat.getDrawable(resources, R.drawable.yoshi, null)
            else -> ResourcesCompat.getDrawable(resources, R.drawable.yoshi, null)
        }
        nombreMiPersonaje.text = personaje
        alertadd.setView(view)
        alertadd.show()
    }

    private fun setMiPersonajeApi(){
        val url: String = "http://10.0.2.2:3000/getPersonaje"
        val requestQueue = Volley.newRequestQueue(this)
        val postData: JSONObject = JSONObject()
        try {
            postData.put("usuario",username)
            postData.put("chatId", chatId)
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
                println(JSONObject(response.toString()).get("personaje"))
                personaje = JSONObject(response.toString()).get("personaje").toString()
            }
        ) { error -> error.printStackTrace() }

        requestQueue.add(jsonObjectRequest)
    }
}