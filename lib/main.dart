import 'package:flutter/material.dart';
import 'package:projeto/contato.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: ListaPage(),
    );
  }
}

class ListaPage extends StatefulWidget {
  ListaPage({Key? key}) : super(key: key);

  @override
  _ListaPageState createState() => _ListaPageState();
}

class _ListaPageState extends State<ListaPage> {
  int contador = 0;

  

  List<Contato> contatos = [
    Contato('João Silva', 'joaosilva@email.com'),
    Contato('Ana Santos', 'ana.santos@email.com'),
    Contato('Carlos Oliveira', 'oliveiracarlos@email.com'),
    Contato('Maria Costa', 'maria.costa@email.com'),
    Contato('Pedro Pereira', 'pedropereira@email.com'),
    Contato('Sofia Rodrigues', 'rodriguessofia@email.com'),
    Contato('Tiago Fernandes', 'tiago.fernandes@email.com'),
    Contato('Inês Almeida', 'ines.almeida@email.com'),
  ];

  void adicionarContato(String nome, String email) {
    setState(() {
      contatos.add(Contato(nome, email));
    });
  }

  void removerContato(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmar exclusão'),
          content: Text('Tem certeza que deseja excluir este contato?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  contatos.removeAt(index);
                  contador =
                      contatos.where((contato) => contato.favoritado).length;
                });
                Navigator.of(context).pop();
              },
              child: Text('Excluir'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'Contatos Favoritos $contador',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView.builder(
        itemCount: contatos.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage('https://i.pravatar.cc/150?imag=${index + 1}'),
            ),
            title: Text(contatos[index].nome),
            subtitle: Text(contatos[index].email),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: contatos[index].favoritado
                      ? Icon(Icons.favorite, color: Colors.red)
                      : Icon(Icons.favorite_border),
                  onPressed: () {
                    setState(() {
                      contatos[index].favoritado = !contatos[index].favoritado;
                      contador =
                          contatos.where((contato) => contato.favoritado).length;
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    removerContato(index);
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Exemplo de adicionar um novo contato ao clicar no botão de adição
          showDialog(
            context: context,
            builder: (BuildContext context) {
              String nome = '';
              String email = '';
              return AlertDialog(
                title: Text('Adicionar Contato'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(labelText: 'Nome'),
                      onChanged: (value) {
                        nome = value;
                      },
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: 'E-mail'),
                      onChanged: (value) {
                        email = value;
                      },
                    ),
                  ],
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancelar'),
                  ),
                  TextButton(
                    onPressed: () {
                      // Adicionar contato com os dados inseridos
                      adicionarContato(nome, email);
                      Navigator.of(context).pop();
                    },
                    child: Text('Adicionar'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
