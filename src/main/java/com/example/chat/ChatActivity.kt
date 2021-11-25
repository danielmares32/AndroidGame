package com.example.chat

import android.content.Context
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.AttributeSet
import android.view.LayoutInflater
import android.view.View
import android.widget.RelativeLayout
import android.widget.TextView

class ChatActivity :  RelativeLayout {

    private lateinit var username: TextView
    private lateinit var chatList: ArrayList<Message>

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

    public fun setUserName(username:String){
        this.username = findViewById(R.id.lblPalyerName)
        this.username.text = username
    }

}