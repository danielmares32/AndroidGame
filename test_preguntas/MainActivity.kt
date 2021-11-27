package com.example.test_preguntas


import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.View
import android.widget.*

class MainActivity : AppCompatActivity() {

    private var pregunta : String = ""
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val preguntar = findViewById<Button>(R.id.btnPreguntar)
        preguntar.setOnClickListener {
            Toast.makeText(this, "pregunta:"+pregunta, Toast.LENGTH_SHORT).show()
        }

        //creacion de los adaptadores
        val datos= arrayOf("juegos","genero","rol","letra inicial","color cabello","tipo cabello","piel","vestimenta","personaje")
        val adaptador1 = ArrayAdapter(this,android.R.layout.simple_spinner_item,datos)
        val cmbOpciones1 : Spinner =findViewById(R.id.Categorias)
        adaptador1.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item)
        cmbOpciones1.adapter = adaptador1


        //spiner de preguntas de juegos
        val juegos = arrayOf("¿pertenece al juego de persona 5?","¿pertenece al juego overwatch?","¿pertenece al juego halo?","¿pertenece al juego league of legends?","¿pertenece al juego minecraft?","¿pertenece al juego packman?")
        val adaptadorJuegos = ArrayAdapter(this,android.R.layout.simple_spinner_item,juegos)
        val cmbOpcionesJuegos: Spinner =findViewById(R.id.Juego)
        adaptadorJuegos.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item)
        cmbOpcionesJuegos.adapter = adaptadorJuegos


        //spiner de preguntas de genero
        val genero = arrayOf("¿es hombre?","¿es mujer?","¿es de genero desconocido?")
        val adaptadorGenero = ArrayAdapter(this,android.R.layout.simple_spinner_item,genero)
        val cmbOpcionesGenero: Spinner = findViewById(R.id.genero)
        adaptadorGenero.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item)
        cmbOpcionesGenero.adapter=adaptadorGenero

        //spiner de preguntas de rol
        val rol = arrayOf("¿es heroe?","¿es villano?")
        val adaptadorRol = ArrayAdapter(this,android.R.layout.simple_spinner_item,rol)
        val cmbOpcionesRol: Spinner = findViewById(R.id.rol)
        adaptadorRol.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item)
        cmbOpcionesRol.adapter = adaptadorRol

        //spiner de preguntas de letra inicial
        val letras = arrayOf("¿la primer letra del nombre esta entre A y G?","¿la primer letra del nombre esta entre H y P?","¿la primer letra del nombre esta entre Q y G?")
        val adaptadorLetras = ArrayAdapter(this,android.R.layout.simple_spinner_item,letras)
        val cmbOpcionesLetras : Spinner =findViewById(R.id.letra_nombre)
        adaptadorLetras.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item)
        cmbOpcionesLetras.adapter=adaptadorLetras

        //spiner de preguntas de color de cabello
        val colorC = arrayOf("¿tiene el cabello negro?","¿tiene el cabello rojo?","¿tiene el cabello azul?","¿tiene el cabello cafe?","¿tiene el cabello naranja?","¿tiene el cabello blanco?","¿no tiene cabello?")
        val adaptadorColorC = ArrayAdapter(this,android.R.layout.simple_spinner_item,colorC)
        val cmbOpcionesColorC : Spinner =findViewById(R.id.color_cabello)
        adaptadorColorC.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item)
        cmbOpcionesColorC.adapter = adaptadorColorC

        //spiner de preguntas tipo de cabello
        val tipoC= arrayOf("¿tiene el cabello grueso?","¿tiene el cabello lacio?","¿tiene el cabello ondulado?","¿tiene nada de cabello?")
        val adaptadorTipoC= ArrayAdapter(this,android.R.layout.simple_spinner_item,tipoC)
        val cmbOpcionesTipoC: Spinner =findViewById(R.id.tipo_cabello)
        adaptadorTipoC.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item)
        cmbOpcionesTipoC.adapter=adaptadorTipoC

        //spiner de preguntas de color de piel
        val colorP= arrayOf("¿tiene la piel clara?","¿tiene la piel oscura?","¿tiene la piel de color?","¿se le ve la piel?")
        val adaptadorColorP= ArrayAdapter(this,android.R.layout.simple_spinner_item,colorP)
        val cmbOpcionesColorP: Spinner =findViewById(R.id.color_piel)
        adaptadorColorP.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item)
        cmbOpcionesColorP.adapter=adaptadorColorP

        //spiner de preguntas de vestimenta
        val vestimenta = arrayOf("¿viste de negro?","¿viste de verde?","¿tiene la piel de color?","¿viste de blanco?","¿viste de azul?","¿usa mascara?","¿usa gorra?","¿usa sombrero?","¿usa zapatos?","¿no viste nada?")
        val adaptadorVestimenta = ArrayAdapter(this,android.R.layout.simple_spinner_item,vestimenta)
        val cmbOpcionesVestimenta : Spinner = findViewById(R.id.vestimenta)
        adaptadorVestimenta.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item)
        cmbOpcionesVestimenta.adapter=adaptadorVestimenta



        //spiner de preguntas por personaje
        val personajes= arrayOf("¿es joker?","¿es futaba?","¿es haru?","¿es kasumi?")
        val adaptadorPersonajes = ArrayAdapter(this,android.R.layout.simple_spinner_item,personajes)
        val cmbOpcionesPersonajes : Spinner =findViewById(R.id.nombre)
        adaptadorPersonajes.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item)
        cmbOpcionesPersonajes.adapter=adaptadorPersonajes

        //hashmap
        var hashMapCat : HashMap<Int, Spinner> = HashMap<Int,Spinner> ()
        hashMapCat.put(1,cmbOpcionesJuegos)
        hashMapCat.put(2,cmbOpcionesGenero)
        hashMapCat.put(3,cmbOpcionesRol)
        hashMapCat.put(4,cmbOpcionesLetras)
        hashMapCat.put(5,cmbOpcionesColorC)
        hashMapCat.put(6,cmbOpcionesTipoC)
        hashMapCat.put(7,cmbOpcionesColorP)
        hashMapCat.put(8,cmbOpcionesVestimenta)
        hashMapCat.put(9,cmbOpcionesPersonajes)

        for(num in 1..9){
            hashMapCat.get(num)?.visibility  = View.GONE
        }

        cmbOpciones1.onItemSelectedListener = object : AdapterView.OnItemSelectedListener {
            override fun onNothingSelected(p0: AdapterView<*>?) {
                Toast.makeText(
                    applicationContext, "Preguntar por...", Toast.LENGTH_SHORT
                ).show()
            }

            override fun onItemSelected(
                parent: AdapterView<*>,
                view: View?,
                position: Int,
                id: Long
            ) {
                val pos = cmbOpciones1.selectedItem.toString()
                var key = 0
                when(pos){
                    "juegos"->key = 1
                    "genero"->key = 2
                    "rol"->key = 3
                    "letra inicial"->key = 4
                    "color cabello"->key = 5
                    "tipo cabello"->key = 6
                    "piel"->key = 7
                    "vestimenta"-> key = 8
                    "personaje"->key = 9

                }

                //habilitamos que solo se vea el spinner seleccionado
                for(num in 1..9){
                    hashMapCat.get(num)?.visibility  = View.GONE
                }
                hashMapCat.get(key)?.visibility = View.VISIBLE


                //se muestra el spinner de la categoria seleccionada
                hashMapCat.get(key)?.onItemSelectedListener = object : AdapterView.OnItemSelectedListener{
                    override fun onNothingSelected(p0: AdapterView<*>?) {
                        Toast.makeText(
                            applicationContext, "Seleccione la pregunta", Toast.LENGTH_SHORT
                        ).show()
                    }

                    override fun onItemSelected(p0: AdapterView<*>?, p1: View?, p2: Int, p3: Long) {
                             pregunta = hashMapCat.get(key)?.selectedItem.toString()

                    }
                }

            }
        }





    }
}