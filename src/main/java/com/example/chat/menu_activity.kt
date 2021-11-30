package com.example.chat

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Button
import com.example.chat.MainActivity
import com.example.chat.R

class menu_activity : AppCompatActivity() {
    private lateinit var individual : Button
    private lateinit var pvpNew : Button
    private lateinit var pvpJoin : Button
    private lateinit var historial : Button
    private lateinit var salir : Button
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_menu)

        individual = findViewById(R.id.btnInd)
        pvpNew= findViewById(R.id.btnPvpNew)
        pvpJoin= findViewById(R.id.btnPvpJoin)
        historial = findViewById(R.id.btnHist)
        salir = findViewById(R.id.btnSalir)

        //recibimos el id del jugador que ha iniciado sesion
        val id_jugador = intent.getSerializableExtra("username") as String

        //salir definitivamente de la aplicacion.
        salir.setOnClickListener {
            val intent = Intent(applicationContext, MainActivity::class.java)
            intent.flags = Intent.FLAG_ACTIVITY_CLEAR_TOP
            intent.putExtra("EXIT", true)
            startActivity(intent)
        }




        individual.setOnClickListener {
            val intent = Intent(this,PvE()::class.java).apply { putExtra("username",id_jugador) }
            startActivity(intent)
        }

        pvpNew.setOnClickListener {
            val intent = Intent(this,RoomActivity()::class.java).apply { putExtra("username",id_jugador);putExtra("usernameGlobal",id_jugador)  }
            startActivity(intent)
        }

        pvpJoin.setOnClickListener {
            val intent = Intent(this,Room2Activity()::class.java).apply { putExtra("username",id_jugador);putExtra("usernameGlabal",id_jugador) }
            startActivity(intent)
        }

        historial.setOnClickListener{
            val intent= Intent(this,historial_activity::class.java)
            intent.putExtra("username",id_jugador)
            startActivity(intent)
        }
    }
}