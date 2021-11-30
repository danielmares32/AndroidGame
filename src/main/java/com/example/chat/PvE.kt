package com.example.chat

import android.app.AlertDialog
import android.content.DialogInterface
import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import android.view.View
import android.widget.*
import androidx.recyclerview.widget.DividerItemDecoration
import androidx.recyclerview.widget.GridLayoutManager
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.android.volley.Request
import com.android.volley.toolbox.JsonObjectRequest
import com.android.volley.toolbox.Volley
import io.socket.client.Socket
import org.json.JSONException
import org.json.JSONObject
import kotlin.system.exitProcess


class PvE : AppCompatActivity() {
    private lateinit var person: RecyclerView
    private lateinit var salir:Button
    private var pregunta : String = ""
    private lateinit var personaje: String
    private lateinit var respuesta: TextView
    private lateinit var btnAdivinar: Button
    private lateinit var username: String

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_pv_e)
        setPersonaje()
        salir=findViewById(R.id.sal)
        person = findViewById(R.id.Personaje)
        respuesta = findViewById(R.id.respuesta)
        btnAdivinar = findViewById(R.id.adivinar)
        username = intent.getSerializableExtra("username") as String

        salir.setOnClickListener{
            exitProcess(0)
        }

        val datos = MutableList(1){
            Personaje(R.drawable.chrono.toString(),"Chrono")
        }
        datos.add(Personaje(R.drawable.ashketchum.toString(),"Ash Ketchum"))
        datos.add(Personaje(R.drawable.cortana_halo.toString(),"Cortana"))
        datos.add(Personaje(R.drawable.bigboss.toString(),"Snake"))
        datos.add(Personaje(R.drawable.hunter.toString(),"Hunter"))
        datos.add(Personaje(R.drawable.samus.toString(),"Samus"))
        datos.add(Personaje(R.drawable.futaba_p5.toString(),"Futaba"))
        datos.add(Personaje(R.drawable.steve.toString(),"Steve"))
        datos.add(Personaje(R.drawable.yoshi.toString(),"Yoshi"))
        datos.add(Personaje(R.drawable.vader.toString(),"Vader"))
        datos.add(Personaje(R.drawable.pacman.toString(),"Pacman"))
        datos.add(Personaje(R.drawable.masterchief.toString(),"MasterChief"))
        datos.add(Personaje(R.drawable.mario.toString(),"Mario"))
        datos.add(Personaje(R.drawable.joker_p5.toString(),"Joker"))
        datos.add(Personaje(R.drawable.kratos.toString(),"Kratos"))
        datos.add(Personaje(R.drawable.a2_nier_automata.toString(),"A2"))
        datos.add(Personaje(R.drawable.batman.toString(),"Batman"))
        datos.add(Personaje(R.drawable.dva.toString(),"DVa"))
        datos.add(Personaje(R.drawable.ghost.toString(),"Ghost"))
        datos.add(Personaje(R.drawable.gwen.toString(),"Gwen"))
        datos.add(Personaje(R.drawable.haru_p5.toString(),"Haru"))
        datos.add(Personaje(R.drawable.jinx.toString(),"Powder"))
        datos.add(Personaje(R.drawable.toad.toString(),"Toad"))
        datos.add(Personaje(R.drawable.kasumi_p5.toString(),"Kasumi"))

        var nombres= mutableSetOf<CharSequence>()
        for (dato in datos){
            nombres.add(dato.Nom)
        }
        val nombresArray = nombres.toTypedArray()
        nombresArray.sort()
        btnAdivinar.setOnClickListener {
            val dialog = AlertDialog.Builder(this)
            dialog.setTitle("Seleccione el personaje a adivinar")
            dialog.setItems(nombresArray,
                DialogInterface.OnClickListener { dialog, position ->
                    Toast.makeText(
                        applicationContext,
                        "selected Item:$position, value:${nombresArray[position].toString().lowercase()}",
                        Toast.LENGTH_SHORT
                    ).show()
                    val builder = AlertDialog.Builder(this)
                    builder.setMessage("Selecciono a ${nombresArray[position]}, desea continuar?")
                        .setPositiveButton("Si",
                            DialogInterface.OnClickListener { dialog2, id ->
                                adivinar(nombresArray[position].toString().lowercase())
                            })
                        .setNegativeButton("No",
                            DialogInterface.OnClickListener { dialog2, id ->
                                // User cancelled the dialog
                            })
                    // Create the AlertDialog object and return it
                    builder.create().show()
                })
            dialog.setPositiveButton(
                "Cerrar"
            ) { dialog, which ->
                dialog.dismiss()
            }
            val alert = dialog.create()
            alert.show()
        }



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
        val preguntar = findViewById<Button>(R.id.btnPreguntar)
        preguntar.setOnClickListener {
            Toast.makeText(this, "pregunta:"+pregunta, Toast.LENGTH_SHORT).show()
            enviarPregunta()
        }



        //inicio de codigos de spinner

        //creacion de los adaptadores
        val datosc= arrayOf("juegos","genero","rol","letra inicial","color cabello","tipo cabello","piel","vestimenta","accesorio","personaje")
        val adaptador1 = ArrayAdapter(this,android.R.layout.simple_spinner_item,datosc)
        val cmbOpciones1 : Spinner =findViewById(R.id.Categorias)
        adaptador1.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item)
        cmbOpciones1.adapter = adaptador1


        //spiner de preguntas de juegos
        val juegos = arrayOf("¿pertenece al juego de persona 5?","¿pertenece al juego overwatch?","¿pertenece al juego halo?","¿pertenece al juego league of legends?","¿pertenece al juego minecraft?","¿pertenece al juego packman?",
            "¿pertenece al juego nier automata?","¿pertenece al juego mario party?","¿petenece al juego pokemon?","¿pertenece al juego  call of duty?",
            "¿pertenece al juego god of war?","¿pertenece al juego metroid?","¿pertenece al juego star wars?","¿pertenece al juego batman?",
            "¿pertenece al juego metal gear solid?","¿pertenece al juego monster hunter?","¿pertenece al juego chrono trigger?")
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
        val letras = arrayOf("¿la primer letra del nombre esta entre A y G?","¿la primer letra del nombre esta entre H y P?","¿la primer letra del nombre esta entre Q y Z?")
        val adaptadorLetras = ArrayAdapter(this,android.R.layout.simple_spinner_item,letras)
        val cmbOpcionesLetras : Spinner =findViewById(R.id.letra_nombre)
        adaptadorLetras.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item)
        cmbOpcionesLetras.adapter=adaptadorLetras

        //spiner de preguntas de color de cabello
        val colorC = arrayOf("¿tiene el cabello negro?","¿tiene el cabello rojo?","¿tiene el cabello azul?",
            "¿tiene el cabello cafe?","¿tiene el cabello naranja?","¿tiene el cabello blanco?","tiene el cabello amarillo?","¿no tiene cabello?")
        val adaptadorColorC = ArrayAdapter(this,android.R.layout.simple_spinner_item,colorC)
        val cmbOpcionesColorC : Spinner =findViewById(R.id.color_cabello)
        adaptadorColorC.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item)
        cmbOpcionesColorC.adapter = adaptadorColorC

        //spiner de preguntas tipo de cabello
        val tipoC= arrayOf("¿tiene el cabello grueso?","¿tiene el cabello lacio?","¿tiene el cabello ondulado?","¿tiene nada de cabello?",
            "¿tiene el cabello despeinado?","¿tiene el cabello mohawk?","¿tiene trenzas?")
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
        val vestimenta = arrayOf("¿viste de negro?","¿viste de verde?","¿tiene la piel de color?","¿viste de blanco?","¿viste de azul?",
            "¿no viste nada?","¿viste de gris?","¿viste de morado?","¿viste de dorado?")
        val adaptadorVestimenta = ArrayAdapter(this,android.R.layout.simple_spinner_item,vestimenta)
        val cmbOpcionesVestimenta : Spinner = findViewById(R.id.vestimenta)
        adaptadorVestimenta.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item)
        cmbOpcionesVestimenta.adapter=adaptadorVestimenta

        //spinner de preguntas de accesorios
        val accesorios= arrayOf("¿no tiene ningun accesorio?","¿usa mascara?","¿usa gorra?","¿usa sombrero?","¿usa zapatos?","¿usa armas?","¿usa un arma?","¿usa una hacha?","¿usa un parche?","¿usa una espada?")
        val adaptadorAccesorios= ArrayAdapter(this,android.R.layout.simple_spinner_item,accesorios)
        val cmbOpcionesAccesorios: Spinner =findViewById(R.id.accesorio)
        adaptadorAccesorios.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item)
        cmbOpcionesAccesorios.adapter=adaptadorAccesorios



        //spiner de preguntas por personaje
        val personajes= arrayOf("¿es joker?","¿es futaba?","¿es haru?","¿es kasumi?","¿es a2?","¿es gwen?",
            "¿es dva?","¿es cortana?","¿es ash?","¿es batman?","¿es simon riley?","¿es jinx?","¿es kratos?",
            "¿es mario?","¿es jhon?","¿es packman?","¿es samus?","¿es steve?","¿es toad?","¿es vader?","¿es yoshi?",
            "¿es hunter?","¿es big boss?","¿es crono?")
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
        hashMapCat.put(10,cmbOpcionesAccesorios)

        for(num in 1..10){
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
                    "accesorio"->key = 10

                }

                //habilitamos que solo se vea el spinner seleccionado
                for(num in 1..10){
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

        //fin de codigo de spinners

    }

    private fun enviarPregunta(){
        val url: String = "http://10.0.2.2:3000/respuestas"
        val requestQueue = Volley.newRequestQueue(this)
        val postData: JSONObject = JSONObject()
        try {
            postData.put("pregunta",pregunta)
            postData.put("id_personaje", personaje)
        } catch (e: JSONException){
            Log.d("Error",e.toString())
        }


        Log.d("Data", postData.toString())

        val jsonObjectRequest = JsonObjectRequest(
            Request.Method.POST,
            url,
            postData,
            { response ->
                println(response)
                println(JSONObject(response.toString()).get("respuesta"))
                val res = JSONObject(response.toString()).get("respuesta")
                respuesta.text = res.toString().uppercase()
            }
        ) { error -> error.printStackTrace() }

        requestQueue.add(jsonObjectRequest)
    }

    private fun setPersonaje(){
        val url: String = "http://10.0.2.2:3000/getPersonajeCPU"
        val requestQueue = Volley.newRequestQueue(this)

        val jsonObjectRequest = JsonObjectRequest(
            Request.Method.POST,
            url,
            null,
            { response ->
                println(response)
                println(JSONObject(response.toString()).get("id_personaje"))
                personaje = JSONObject(response.toString()).get("id_personaje").toString()
            }
        ) { error -> error.printStackTrace() }

        requestQueue.add(jsonObjectRequest)
    }

    private fun adivinar(personajeAdivinado: String){
        val url: String = "http://10.0.2.2:3000/respuestas"
        val requestQueue = Volley.newRequestQueue(this)
        val postData: JSONObject = JSONObject()
        try {
            postData.put("pregunta","¿es ${personajeAdivinado}?")
            postData.put("id_personaje", personaje)
        } catch (e: JSONException){
            Log.d("Error",e.toString())
        }


        Log.d("Data", postData.toString())

        val jsonObjectRequest = JsonObjectRequest(
            Request.Method.POST,
            url,
            postData,
            { response ->
                println(response)
                println(JSONObject(response.toString()).get("respuesta"))
                val res = JSONObject(response.toString()).get("respuesta")
                if(res == "si"){
                    val intent = Intent(this,pantalla_victoria()::class.java).apply { putExtra("usernameGlobal",username) }
                    startActivity(intent)
                } else{
                    val intent = Intent(this,derrota_activity()::class.java).apply { putExtra("usernameGlobal",username) }
                    startActivity(intent)
                }
            }
        ) { error -> error.printStackTrace() }

        requestQueue.add(jsonObjectRequest)
    }

}