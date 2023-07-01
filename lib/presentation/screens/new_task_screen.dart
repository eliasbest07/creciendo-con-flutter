import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class NewTaskScreen extends StatelessWidget {

  const NewTaskScreen({Key? key}) : super(key: key);
  static final List<String> _usuarios = [
    'Juan Perez',
    'Christian Valverde',
    'Alejandro Canto',
    'Jhon Doe',
    'Pablo Picasso',
    'Ivan Perkovich',
    'Santiago Acasiete',
    'Alejandro de las Casas',
    'Vicot Valdez',
    'Cesar Campos',
    'Teofilo Gutierrez',
    'Jeronimo Hinostroza',
    'Sydney Farfan',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Nueva Tarea',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.check),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
        // key: _formKey,
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20.0),
            TextFormField(
              controller: TextEditingController(),// _nombreController,
              decoration: const InputDecoration(
                icon: Icon(Icons.task),
                hintText: 'Ingrese un nombre.',
                labelText: 'Nombre *',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, ingresa el nombre';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: TextEditingController(),//_descripcionController,
              decoration: const InputDecoration(
                icon: Icon(Icons.description),
                hintText: 'Ingrese una descripción.',
                labelText: 'Descripción *',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, ingresa una descripcion';
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: TextEditingController(),//_comentarioController,
              decoration: const InputDecoration(
                icon: Icon(Icons.comment),
                labelText: 'Comentarios',
                hintText: 'Ingrese comentarios.',
              ),
              validator: (value) { 
                return null;
              },
            ),
            const SizedBox(height: 16.0), 
            TypeAheadField<String>(
              getImmediateSuggestions: false,
              textFieldConfiguration: const TextFieldConfiguration(
                decoration: InputDecoration(
                    labelText: 'Usuario',
                    icon: Icon(Icons.person),
                    hintText: 'Seleccione un usuario.'),
              ),
              suggestionsCallback: (String pattern) async {
                return _usuarios
                    .where((item) =>
                        item.toLowerCase().startsWith(pattern.toLowerCase()))
                    .toList();
              },
              itemBuilder: (context, String suggestion) {
                return ListTile(
                  title: Text(suggestion),
                );
              },
              itemSeparatorBuilder: (context, index) {
                return Divider();
              },
              onSuggestionSelected: (String suggestion) {
                print("Suggestion selected");
              },
            ),
      
           /* TextFormField(
              controller: _usuarioController,
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                labelText: 'Usuario',
                hintText: 'Ingrese un usuario.',
              ),
              validator: (value) {
                return null;
              },
            ), 
            */
            /*InkWell(
              onTap: _showDatePicker1,
              child: InputDecorator(
                decoration: const InputDecoration(
                  icon: Icon(Icons.date_range),
                  labelText: 'Fecha creada  *',
                  hintText: 'Ingrese una fecha.',
                ),
                child: Text(
                  _fechaCreadaSeleccionada != null
                      ? "${_fechaCreadaSeleccionada!.day}/${_fechaCreadaSeleccionada!.month}/${_fechaCreadaSeleccionada!.year}"  
                      : '',
                ),
              ),
            ),
            */
            const SizedBox(height: 16.0),
            TextField(
                controller: TextEditingController(),// _fechaInicioController, //editing controller of this TextField
                  decoration: const InputDecoration( 
                            icon: Icon(Icons.date_range), //icon of text field
                          labelText: 'Fecha Inicio *',
                          hintText:  'Seleccione una fecha'//label text of field
                    ),
                  readOnly: true,  // when true user cannot edit text 
                  onTap: () async {
                        DateTime? pickedDate= await showDatePicker(context: context, 
                          initialDate: DateTime.now(), 
                          firstDate: DateTime(2000), 
                          lastDate: DateTime(2100)); 
                        if(pickedDate!=null){
                          // String formattedDate=DateFormat("dd/MM/yyyy").format(pickedDate);
                          // setState(() {
                          //   _fechaInicioController.text=formattedDate.toString();
                          // });
                        }   //when click we have to show the datepicker
                    }
              ),
            const SizedBox(height: 16.0),
            TextField(
                controller: TextEditingController(),// _fechaEstablecidaController, //editing controller of this TextField
                  decoration: const InputDecoration( 
                            icon: Icon(Icons.date_range), //icon of text field
                          labelText: 'Fecha Establecida *',
                          hintText:  'Seleccione una fecha'//label text of field
                    ),
                  readOnly: true,  // when true user cannot edit text 
                  onTap: () async {
                        DateTime? pickedDate= await showDatePicker(context: context, 
                          initialDate: DateTime.now(), 
                          firstDate: DateTime(2000), 
                          lastDate: DateTime(2100)); 
                        if(pickedDate!=null){
                          // String formattedDate=DateFormat("dd/MM/yyyy").format(pickedDate);
                          // setState(() {
                          //   _fechaEstablecidaController.text=formattedDate.toString();
                          // });
                        }   //when click we have to show the datepicker
                    }
              ),
            const SizedBox(height: 16.0), 
            TextFormField(
              controller: TextEditingController(),//_estadoController,
              decoration: const InputDecoration(
                icon: Icon(Icons.check_box),
                labelText: 'Estado',
                hintText: 'Ingrese estado.',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, seleccione un estado';
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller:TextEditingController(),// _nivelController,
              decoration: const InputDecoration(
                icon: Icon(Icons.rocket_launch),
                labelText: 'Nivel',
                hintText: 'Ingrese un nivel.',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, ingrese un nivel';
                }
                return null;
              },
            ),
            const SizedBox(height: 26.0),
            ElevatedButton(
              onPressed: () {
                // if (_formKey.currentState!.validate()) {
                //   _formKey.currentState!.save();
      
                //   print('Nombre: ${_nombreController.text}');
                //   print('Descripcion: ${_descripcionController.text}');
                //   if (_fechaInicioController != null) {
                //     print('Fecha seleccionada: ${_fechaInicioController.toString()}');
                //   }
                //   if (_fechaEstablecidaController != null) {
                //     print('Fecha seleccionada: ${_fechaEstablecidaController.toString()}');
                //   }
                // }
              },
              child: const Text('Crear Tarea'),
            ),
          ],
        ),
          ),
      )
    );
  }
}