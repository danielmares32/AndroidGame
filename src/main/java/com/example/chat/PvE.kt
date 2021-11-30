package com.example.chat

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import android.widget.Button
import android.widget.Toast
import androidx.recyclerview.widget.DividerItemDecoration
import androidx.recyclerview.widget.GridLayoutManager
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import io.socket.client.Socket
import org.json.JSONException
import org.json.JSONObject
import kotlin.system.exitProcess


class PvE : AppCompatActivity() {
    private lateinit var person: RecyclerView
    private lateinit var chat: ChatActivity
    private lateinit var  mSocket: Socket
    private lateinit var salir:Button

    override fun onCreate(savedInstanceState: Bundle?) {

        SocketHandler.setSocket()
        SocketHandler.establishConnection()
        mSocket=SocketHandler.getSocket()
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_pv_e)
        salir=findViewById(R.id.sal)
        person = findViewById(R.id.Personaje)
        chat = findViewById(R.id.chat)
        salir.setOnClickListener{
            exitProcess(0)
        }
        val username: String? = "CPU"
        val chatId: String? = intent.getStringExtra("roomId")
        chat.setUserName("Rival: "+username!!)

        chat.getLblsend().setOnClickListener {
            if(chat.getMensaje().text.toString() != ""){
                chat.getChatList().add(Message(username,chat.getMensaje().text.toString(),chatId!!,0))
                val adapter = ChatAdapter(this, chat.getChatList())
                //chat.getRecycler().setHasFixedSize(true)
                chat.getRecycler().layoutManager = LinearLayoutManager(this)
                chat.getRecycler().adapter = adapter
                chat.getRecycler().scrollToPosition(chat.getChatList().size - 1)
                enviarMensajes()
                chat.getMensaje().text = ""
            }
        }

        /*
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
                        //chat.getRecycler().setHasFixedSize(true)
                        chat.getRecycler().layoutManager = LinearLayoutManager(this)
                        chat.getRecycler().adapter = adapter
                        chat.getRecycler().scrollToPosition(chat.getChatList().size - 1)
                    }
                }
            }
        }
*/

        val datos = MutableList(1){
            Personaje(R.drawable.chrono.toString(),"Chrono")
        }
        datos.add(Personaje(R.drawable.ashketchum.toString(),"Ash Ketchum"))
        datos.add(Personaje(R.drawable.bigboss.toString(),"Big Boss (Snake)"))
        datos.add(Personaje(R.drawable.hunter.toString(),"Cazador"))
        //datos.add(Personaje(R.drawable.sumire.toString(),"Sumire"))
        //datos.add(Personaje(R.drawable.vergil.toString(),"Vergil"))
        datos.add(Personaje(R.drawable.yoshi.toString(),"Yoshi"))
        datos.add(Personaje(R.drawable.vader.toString(),"Vader"))
        datos.add(Personaje(R.drawable.pacman.toString(),"Pacman"))
        datos.add(Personaje(R.drawable.masterchief.toString(),"Master Chief"))
        datos.add(Personaje(R.drawable.mario.toString(),"Mario"))
        //datos.add(Personaje(R.drawable.lady_maria_bloodborne.toString(),"Lady Maria"))
        //datos.add(Personaje(R.drawable.joker_persona5.toString(),"Joker"))
        datos.add(Personaje(R.drawable.kratos.toString(),"Kratos"))
        datos.add(Personaje(R.drawable.a2_nier_automata.toString(),"A2"))
        datos.add(Personaje(R.drawable.batman.toString(),"Batman"))
        datos.add(Personaje(R.drawable.dva.toString(),"D.V"))
        datos.add(Personaje(R.drawable.ghost.toString(),"Ghost"))
        datos.add(Personaje(R.drawable.gwen.toString(),"Gwen"))
        //datos.add(Personaje(R.drawable.haru_persona5.toString(),"Haru"))
        datos.add(Personaje(R.drawable.jinx.toString(),"Powder"))

        val adaptador= AdaptadorPersonaje(datos){
            //val intent = Intent (MainActivity@this,)
            Toast.makeText(this,"Personaje escogido: ${it.Nom}", Toast.LENGTH_SHORT).show()
        }
        person.setHasFixedSize(true)
        person.layoutManager=
            GridLayoutManager(this,3)
        person.addItemDecoration(DividerItemDecoration(this, DividerItemDecoration.VERTICAL))
        person.addItemDecoration(DividerItemDecoration(this, DividerItemDecoration.HORIZONTAL))
        person.adapter=adaptador

    }

    private fun enviarMensajes(){
        print("Entre a enviar mensaje")
        /*SocketHandler.setSocket()
        SocketHandler.establishConnection()
        val mSocket = SocketHandler.getSocket()*/

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
}