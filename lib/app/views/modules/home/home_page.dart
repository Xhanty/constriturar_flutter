import 'package:constriturar/app/widgets/carousel_home.dart';
import 'package:flutter/material.dart';
import 'package:constriturar/app/widgets/bar_chart.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<ChartColumnData> chartData = <ChartColumnData>[
    ChartColumnData('Lunes', 2, 1),
    ChartColumnData('Martes', 2, 0.5),
    ChartColumnData('Miércoles', 2, 1.5),
    ChartColumnData('Jueves', 2, 0.8),
    ChartColumnData('Viernes', 2, 1.3),
    ChartColumnData('Sábado', 2, 1.8),
    ChartColumnData('Domingo', 2, 0.9),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Inicio")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(height: 10),
            CarouselHome(),
            SizedBox(height: 10),
            BarChart(
              countText: '854',
              incrementText: '25 vales',
              chartData: chartData,
              title: 'Órdenes de servicio',
              description: 'Gráfico de órdenes de servicio en la semana',
            ),
          ],
        ),
      ),
    );
  }
}
