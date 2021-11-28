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
    private var chatList: ArrayList<Message> = ArrayList<Message>()
    private var lblsend: TextView
    private var mensaje: TextView
    private var recyclerChat: RecyclerView

    constructor(context: Context?) : super(context){
        val li = LayoutInflater.from(context)
        li.inflate(R.layout.activity_chat,this,true)
        lblsend = findViewById(R.id.lblSend)
        mensaje = findViewById(R.id.txtmensaje)
        recyclerChat = findViewById(R.id.recyclerChat)

    }
    constructor(context: Context?, attrs: AttributeSet?) : super(context, attrs){
        val li = LayoutInflater.from(context)
        li.inflate(R.layout.activity_chat,this,true)
        lblsend = findViewById(R.id.lblSend)
        mensaje = findViewById(R.id.txtmensaje)
        recyclerChat = findViewById(R.id.recyclerChat)
    }
    constructor(context: Context?, attrs: AttributeSet?, defStyleAttr: Int) : super(
        context,
        attrs,
        defStyleAttr
    ){
        val li = LayoutInflater.from(context)
        li.inflate(R.layout.activity_chat,this,true)
        lblsend = findViewById(R.id.lblSend)
        mensaje = findViewById(R.id.txtmensaje)
        recyclerChat = findViewById(R.id.recyclerChat)
    }

    public fun setUserName(username:String){
        this.username = findViewById(R.id.lblPalyerName)
        this.username.text = username
    }

    public fun getLblsend():TextView{
        return this.lblsend
    }

    public fun getMensaje():TextView{
        return this.mensaje;
    }

    public fun getChatList():ArrayList<Message>{
        return this.chatList
    }

    public fun getRecycler():RecyclerView{
        return this.recyclerChat
    }

}