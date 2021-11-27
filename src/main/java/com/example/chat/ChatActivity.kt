package com.example.chat

import android.content.Context
import android.util.AttributeSet
import android.util.Log
import android.view.LayoutInflater
import android.widget.RelativeLayout
import android.widget.TextView
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import org.json.JSONException
import org.json.JSONObject

class ChatActivity :  RelativeLayout {

    private lateinit var username: TextView
    private lateinit var chatList: ArrayList<Message>
    private lateinit var lblsend: TextView
    private lateinit var mensaje: TextView
    private lateinit var roomId: String
    private lateinit var recyclerChat: RecyclerView
    private val mSocket = SocketHandler.getSocket()

    constructor(context: Context?) : super(context){
        val li = LayoutInflater.from(context)
        li.inflate(R.layout.activity_chat,this,true)

    }
    constructor(context: Context?, attrs: AttributeSet?) : super(context, attrs){
        val li = LayoutInflater.from(context)
        li.inflate(R.layout.activity_chat,this,true)
    }
    constructor(context: Context?, attrs: AttributeSet?, defStyleAttr: Int) : super(
        context,
        attrs,
        defStyleAttr
    ){
        val li = LayoutInflater.from(context)
        li.inflate(R.layout.activity_chat,this,true)
    }

    init {
        lblsend=findViewById(R.id.lblSend)
        mensaje=findViewById(R.id.txtmensaje)
        recyclerChat=findViewById(R.id.recyclerChat)

        lblsend.setOnClickListener {
            if(mensaje.text.toString() != ""){
                chatList.add(Message(username.text.toString(),mensaje.text.toString(),roomId,0))
                enviarMensajes()
            }
        }

        SocketHandler.setSocket()
        SocketHandler.establishConnection()
        mSocket.on("updateChat") { args ->
            if (args[0] != null) {
                val datos = args as JSONObject
                println("Respuesta del socket")
                println(datos.toString())
                runOnUiThread {
                    chatList.add(Message(datos.get("username").toString(),datos.get("messageContent").toString(),datos.get("chatId").toString(),1))
                    val adapter = ChatAdapter(context,chatList)
                    recyclerChat.setHasFixedSize(true)
                    recyclerChat.layoutManager=LinearLayoutManager(context)
                    recyclerChat.adapter=adapter
                }
            }
        }
    }

    public fun setRoomId(roomId: String){
        this.roomId = roomId
    }

    public fun setUserName(username:String){
        this.username = findViewById(R.id.lblPalyerName)
        this.username.text = username
    }

    private fun enviarMensajes(){
        print("Entre a enviar mensaje")
        SocketHandler.setSocket()
        SocketHandler.establishConnection()
        val mSocket = SocketHandler.getSocket()

        val data: JSONObject = JSONObject()
        try {
            data.put("username", chatList.last().userName)
            data.put("chatId", chatList.last().roomName)
            data.put("message",chatList.last().messageContent)
        } catch (e: JSONException) {
            Log.d("Error", e.toString())
        }
        print("Mando al socket")
        print(data.toString())
        mSocket.emit("newMessage", data)

    }



}