import 'package:flutter/material.dart';

class DetailesScreen extends StatefulWidget {
  const DetailesScreen({
    super.key,
    required this.countryName,
    required this.capital,
    required this.region,
    required this.population,
    this.flagPng,
  });
  final String? countryName;
  final String? capital;
  final String? region;
  final String? population;
  final String? flagPng;
  @override
  State<DetailesScreen> createState() => _DetailesScreenState();
}

class _DetailesScreenState extends State<DetailesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text("Country Details")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              child: Image.network(fit: BoxFit.cover, "${widget.flagPng}"),
            ),
            const SizedBox(height: 20),
            Text("Country Name: ${widget.countryName}"),
            const SizedBox(height: 10),
            Text("Capital: ${widget.capital}"),
            const SizedBox(height: 10),
            Text("Region: ${widget.region}"),
            const SizedBox(height: 10),
            Text("Population: ${widget.population}"),
          ],
        ),
      ),
    );
  }
}
