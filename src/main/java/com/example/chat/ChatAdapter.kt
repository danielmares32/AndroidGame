package com.example.chat

import android.content.Context
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView

class ChatAdapter(val context: Context, val chatList: ArrayList<Message>): RecyclerView.Adapter<ChatAdapter.ChatViewHolder>() {

    val CHAT_USUARIO = 0
    val CHAT_RIVAL = 1

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ChatViewHolder {

        var view : View? = null
        when(viewType){

            0 ->{
                view = LayoutInflater.from(context).inflate(R.layout.item_msg_enviado,parent,false)
            }

            1 ->{
                view = LayoutInflater.from(context).inflate(R.layout.item_msg_recibido,parent,false)
            }

        }

        return ChatViewHolder(view!!)
    }

    override fun getItemCount(): Int {
        return chatList.size
    }

    override fun getItemViewType(position: Int): Int {
        return chatList[position].viewType
    }

    override fun onBindViewHolder(holder: ChatViewHolder, position: Int) {
        val messageData  = chatList[position]
        val content = messageData.messageContent
        val viewType = messageData.viewType

        when(viewType) {

            CHAT_USUARIO -> {
                holder.message.setText(content)
            }
            CHAT_RIVAL ->{
                holder.message.setText(content)
            }

        }

    }
    class ChatViewHolder(itemView : View):  RecyclerView.ViewHolder(itemView) {
        val userName = itemView.findViewById<TextView>(R.id.username)
        val message = itemView.findViewById<TextView>(R.id.message)
        val text = itemView.findViewById<TextView>(R.id.text)
    }

}
