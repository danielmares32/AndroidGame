/*package com.example.guesswho

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ImageView
import android.widget.LinearLayout
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.example.chat.R

data class Personaje (val Foto:String,val Nom:String)
class AdaptadorPersonaje(private val datos:MutableList<Personaje>,
                         private val clickListener : (Personaje)->Unit ): RecyclerView.Adapter<AdaptadorPersonaje.PersonajesViewHolder>() {
    class PersonajesViewHolder(val item: View):RecyclerView.ViewHolder(item) {
        val lblnom=item.findViewById(R.id.Nombre)as TextView
        val Foto= item.findViewById(R.id.PImagen)as ImageView
       // val lbltel = item.findViewById(R.id.Tel)as TextView
        fun bindPersonaje (titular: Personaje){
            lblnom.text=titular.Nom
            Foto.setImageResource(titular.Foto.toInt())
        }
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): PersonajesViewHolder {
        val item= LayoutInflater.from(parent.context)
            .inflate(R.layout.listitem_personaje,parent,false)as LinearLayout
        return PersonajesViewHolder(item)

    }

    override fun onBindViewHolder(holder: PersonajesViewHolder, position: Int) {
        val titular = datos[position]
        holder.bindPersonaje(titular)
        holder.item.setOnClickListener{clickListener(titular)}
    }

    override fun getItemCount(): Int {
        return datos.size
    }

}*/