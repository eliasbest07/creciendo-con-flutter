import 'package:flutter/material.dart';

class ListProjectWidget extends StatelessWidget {
  const ListProjectWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        itemCount: 6,
        itemBuilder: (context, index) {
          return _CardProject();
        },
        separatorBuilder: (context, index) => const SizedBox(height: 10.0),
      ),
    );
  }
}

class _CardProject extends StatelessWidget {
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
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'TASKFLOW',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    _InfoCard(
                      title: 'Estado:',
                      labelChip: 'Activo',
                      colorChip: Colors.green,
                    ),
                    _InfoCard(
                      title: 'Creado por:',
                      labelChip: 'Elias Best',
                      colorChip: Colors.blue,
                    ),
                  ],
                ),
                _PhotoProject(),
              ],
            ),
          ),
          const SizedBox(height: 10.0),
          _Buttons(),
        ],
      ),
    );
  }
}

class _Buttons extends StatelessWidget {
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
              onPressed: () {},
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
              onPressed: () {},
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
  @override
  Widget build(BuildContext context) {
    const urlImage =
        'https://cdn.discordapp.com/attachments/1112021237858828378/1125129276203745320/bf8bd3b3-2438-46e8-8a2a-2363f5ba9ee9.png';

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
      child: Image.network(
        urlImage,
        fit: BoxFit.cover,
      ),
    );
  }
}
