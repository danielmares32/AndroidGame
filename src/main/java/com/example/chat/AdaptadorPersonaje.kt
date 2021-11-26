package com.example.chat

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ImageView
import android.widget.LinearLayout
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.bumptech.glide.Glide
import com.wajahatkarim3.easyflipview.EasyFlipView

//import jdk.javadoc.internal.doclets.toolkit.util.DocPath.parent




data class Personaje (val Foto:String,val Nom:String)

class AdaptadorPersonaje(private val datos:MutableList<Personaje>,
                         private val clickListener : (Personaje)->Unit ): RecyclerView.Adapter<AdaptadorPersonaje.PersonajesViewHolder>() {
    lateinit var mClickListener: ItemClickListener


    public  class PersonajesViewHolder:RecyclerView.ViewHolder, View.OnClickListener {

       lateinit var  itemc:View
       lateinit var  lblnom:TextView
        lateinit var Foto: ImageView
        lateinit var myEasyFlipView:EasyFlipView

        constructor(item: View) : super(item) {
            itemc = item
            lblnom=itemc.findViewById(R.id.Nombre)as TextView
            Foto= itemc.findViewById(R.id.PImagen)as ImageView
            myEasyFlipView=item.findViewById(R.id.flipC)
            item.setOnClickListener(this)
        }




        // val lbltel = item.findViewById(R.id.Tel)as TextView
        fun bindPersonaje (titular: Personaje){
            lblnom.text=titular.Nom

           Glide.with(Foto.context)
               .load(titular.Foto.toInt())
               .into(Foto)
            //Foto.setImageResource(titular.Foto.toInt())
        }


       override fun onClick(view: View?) {
           myEasyFlipView.flipTheView()

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
      //  holder.itemc.setOnClickListener{clickListener(titular)}
    }

    override fun getItemCount(): Int {
        return datos.size
    }

    fun setClickListener(it:ItemClickListener){
        this.mClickListener=it
    }

   public interface ItemClickListener {
         fun onItemClick(view: View?, position:Int);
    }

}