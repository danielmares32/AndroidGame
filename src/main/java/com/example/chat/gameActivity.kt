package com.example.chat

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Toast
import androidx.recyclerview.widget.DividerItemDecoration
import androidx.recyclerview.widget.GridLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.example.chat.R

class gameActivity : AppCompatActivity() {
    private lateinit var person: RecyclerView

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.game_activity)
        person = findViewById(R.id.Personaje)

        val datos = MutableList(1){
            Personaje(R.drawable.chrono.toString(),"Chrono")
        }
        datos.add(Personaje(R.drawable.ashketchum.toString(),"Ash Ketchum"))
        datos.add(Personaje(R.drawable.bigboss.toString(),"Big Boss (Snake)"))
        datos.add(Personaje(R.drawable.hunter.toString(),"Cazador"))
        datos.add(Personaje(R.drawable.sumire.toString(),"Sumire"))
        datos.add(Personaje(R.drawable.vergil.toString(),"Vergil"))
        datos.add(Personaje(R.drawable.yoshi.toString(),"Yoshi"))
        datos.add(Personaje(R.drawable.vader.toString(),"Vader"))
        datos.add(Personaje(R.drawable.pacman.toString(),"Pacman"))
        datos.add(Personaje(R.drawable.masterchief.toString(),"Master Chief"))
        datos.add(Personaje(R.drawable.mario.toString(),"Mario"))
        datos.add(Personaje(R.drawable.lady_maria_bloodborne.toString(),"Lady Maria"))
        datos.add(Personaje(R.drawable.joker_persona5.toString(),"Joker"))
        datos.add(Personaje(R.drawable.kratos.toString(),"Kratos"))
        datos.add(Personaje(R.drawable.a2_nier_automata.toString(),"A2"))
        datos.add(Personaje(R.drawable.batman.toString(),"Batman"))
        datos.add(Personaje(R.drawable.dva.toString(),"D.Va"))
        datos.add(Personaje(R.drawable.ghost.toString(),"Ghost"))
        datos.add(Personaje(R.drawable.gwen.toString(),"Gwen"))
        datos.add(Personaje(R.drawable.haru_persona5.toString(),"Haru"))
        datos.add(Personaje(R.drawable.jinx.toString(),"Powder"))

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
}