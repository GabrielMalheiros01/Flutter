import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController txtcep = TextEditingController();
  String? cp;
  String? logra;
  String? bai;
  String? cida;
  String? esta;

  _consultarCep() async {
    String ceps = txtcep.text;
    var url = Uri.parse("https://viacep.com.br/ws/$ceps/json/");
    var response = await http.get(url);

    Map<String, dynamic> retorno = json.decode(response.body);

    String logradouro = retorno["logradouro"];
    String bairro = retorno["bairro"];
    String cidade = retorno["localidade"];
    String estado = retorno["uf"];
    String cip = retorno["cep"];
    setState(() {
      cp = "\n$cip";
      logra = "\n$logradouro";
      bai = "\n$bairro";
      cida = "\n$cidade";
      esta = "\n$estado";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Consultando um CEP via API"),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          TextField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Digite o Cep, ex: 1833400",
            ),
            style: const TextStyle(fontSize: 30),
            controller: txtcep,
          ),
          ElevatedButton(
            onPressed: () {
              _consultarCep();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const Tela2();
                  },
                ),
              );
            },
            child: const Text(
              "Consultar",
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class Tela2 extends StatelessWidget {
  const Tela2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: const Text('Tela 2'),
        ),
        body: const Center(
          child: Text(
            "$cp",
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ));
  }
}
