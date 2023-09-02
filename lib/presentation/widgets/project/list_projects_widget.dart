import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/proyecto/usuario_proyecto_entity.dart';

class ListProjectWidget extends StatelessWidget {
  const ListProjectWidget({super.key, 
    required this.listProject, 
    required this.onMetas, 
    required this.onConfiguraciones, 
    required this.isLider});

  final List<ProyectoByRol> listProject;
  final Function onMetas;
  final Function onConfiguraciones;
  final bool isLider;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        itemCount: listProject.length,
        itemBuilder: (context, index) {
          return _CardProject( isLider:isLider, project: listProject[index], onMetas: ()=> onMetas(listProject[index].proyectoId), onConfiguraciones: ()=> onConfiguraciones(),);
        },
        separatorBuilder: (context, index) => const SizedBox(height: 10.0),
      ),
    );
  }
}

class _CardProject extends StatelessWidget {
  const _CardProject( { 
    required this.project, 
    required this.onMetas, 
    required this.onConfiguraciones, 
    required this.isLider});

  final ProyectoByRol project;
  final Function onMetas;
  final Function onConfiguraciones;
   final bool isLider;

  @override
  Widget build(BuildContext context) {
    
    //final size = MediaQuery.of(context).size;

    final borderRadius = BorderRadius.circular(20.0);
    const boxShadow = BoxShadow(
      color: Color.fromARGB(24, 46, 46, 46),
      offset: Offset(0.0, 1.0),
      blurRadius: 5.0,
    );
    const color = Colors.white;
    const margin = EdgeInsets.symmetric(horizontal: 5.0);
    const padding = EdgeInsets.only(left: 15.0, right: 15.0, top: 18.0);

    return Container(
      width: double.infinity,
      //height: size.height * 0.3,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: color,
        boxShadow: const [boxShadow],
      ),
      child: Column(
        children: [
          Padding(
            padding: padding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(project.nombre,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    _InfoCard(
                      title: 'Estado:',
                      labelChip: project.estado,
                      colorChip: Colors.green,
                    ),
                    _InfoCard(
                      title: 'Creado por:',
                      labelChip: project.creadopor,
                      colorChip: Colors.blue,
                    ),
                  ],
                ),
                _PhotoProject(urlImage: project.icono),
              ],
            ),
          ),
          const SizedBox(height: 10.0),
           isLider ? _Buttons(onMeta:()=> onMetas(), onConfiguracion: ()=> onConfiguraciones(), ) : 
           const SizedBox( width:10),
        ],
      ),
    );
  }
}

class _Buttons extends StatelessWidget {
  const _Buttons({required this.onMeta, required this.onConfiguracion});

  final Function onMeta;
  final Function onConfiguracion;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
      child: Row(
        children: [
          Expanded(
            child: MaterialButton(
              elevation: 0,
              height: 55,
              shape: const Border(
                top: BorderSide(
                    color: Colors.grey), // Borde gris en la parte superior
                right: BorderSide(
                    color: Colors.grey), // Borde gris en el lado derecho
              ),
              color: Colors.white,
              onPressed: () => onMeta(),
              child: const Text(
                'Ir a  Metas',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          Expanded(
            child: MaterialButton(
              height: 55,
              elevation: 0,
              shape: const Border(
                top: BorderSide(color: Colors.grey),
              ),
              color: Colors.white,
              onPressed: () => onConfiguracion(),
              child: const Text(
                'Configuraciones',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final String labelChip;
  final Color colorChip;

  const _InfoCard({
    required this.title,
    required this.labelChip,
    required this.colorChip,
  });

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(
      fontSize: 14,
      color: Color(0xffB9B9B9),
      fontWeight: FontWeight.w500,
    );
    final borderRadius = BorderRadius.circular(50);

    return Column(
      children: [
        Row(
          children: [
            Text(title, style: style),
            const SizedBox(width: 7.0),
            Container(
              height: 25,
              decoration: BoxDecoration(
                borderRadius: borderRadius,
                color: colorChip,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Center(
                  child: Text(
                    labelChip,
                    style: style.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 5.0),
      ],
    );
  }
}

class _PhotoProject extends StatelessWidget {
  const _PhotoProject({required this.urlImage});
  final String urlImage;
  @override
  Widget build(BuildContext context) {
    
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 1),
            color: Color.fromARGB(26, 46, 46, 46),
            blurRadius: 10,
          )
        ],
        color: Colors.white,
      ),
      height: 88,
      width: 88,
      padding: const EdgeInsets.all(15),

child: urlImage == 'vacio' ? const SizedBox(width:10) : CachedNetworkImage(
        imageUrl: urlImage,
      ),
    );
  }
}
