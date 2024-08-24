import 'package:flutter/material.dart';

void main() {
  runApp(ListaDeTarefasApp());
}

class ListaDeTarefasApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Tarefas',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Colors.grey[100], // Fundo suave e harmonioso
      ),
      home: TelaPrincipal(),
      debugShowCheckedModeBanner: false, // Remove o rótulo de debug
    );
  }
}

class TelaPrincipal extends StatefulWidget {
  @override
  _TelaPrincipalState createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  final List<Tarefa> _tarefas = []; // Lista de tarefas

  final TextEditingController _controladorDeTexto = TextEditingController();

  // Função para adicionar uma nova tarefa à lista
  void _adicionarTarefa(String descricao) {
    setState(() {
      _tarefas.add(Tarefa(descricao: descricao));
    });
    _controladorDeTexto.clear(); // Limpa o campo de texto após adicionar
  }

  // Função para marcar uma tarefa como concluída ou não
  void _alternarConclusao(int index) {
    setState(() {
      _tarefas[index].concluida = !_tarefas[index].concluida;
    });
  }

  // Função para remover uma tarefa da lista
  void _removerTarefa(int index) {
    setState(() {
      _tarefas.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Tarefas'),
        centerTitle: true,
        elevation: 2,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _controladorDeTexto,
              decoration: InputDecoration(
                labelText: 'Digite uma nova tarefa',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white, // Fundo branco para o campo de texto
                suffixIcon: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => _adicionarTarefa(_controladorDeTexto.text),
                ),
              ),
              onSubmitted: _adicionarTarefa,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _tarefas.length,
              itemBuilder: (context, index) {
                final tarefa = _tarefas[index];
                return Card(
                  elevation: 2,
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: ListTile(
                    title: Text(
                      tarefa.descricao,
                      style: TextStyle(
                        decoration: tarefa.concluida
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    leading: Checkbox(
                      value: tarefa.concluida,
                      onChanged: (_) => _alternarConclusao(index),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.redAccent),
                      onPressed: () => _removerTarefa(index),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Classe que representa uma tarefa
class Tarefa {
  final String descricao; // Descrição da tarefa
  bool concluida; // Estado de conclusão da tarefa

  Tarefa({required this.descricao, this.concluida = false});
}
