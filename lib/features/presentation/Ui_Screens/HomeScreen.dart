import 'package:country_flag/features/presentation/Controller/cubit/country_flag_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "🌍 Country Flags",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      body: SafeArea(
        child: BlocProvider(
          create: (context) => CountryFlagCubit()..get_Flags(),
          child: BlocConsumer<CountryFlagCubit, CountryFlagState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is CountryFlagLoading) {
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        'Loading countries...',
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                      ),
                      const SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          minHeight: 6,
                          backgroundColor: Colors.grey.shade300,
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            Colors.lightBlue,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }

              if (state is CountryFlagSuccess) {
                var data = state.data;

                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GridView.builder(
                    itemCount: data.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // two cards per row
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 1, // square shape like your image
                        ),
                    itemBuilder: (context, index) {
                      final country = data[index];

                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // 🇲🇽 Flag image
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                country.flags?.png ?? '',
                                height: 100,
                                width: 140,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(
                                      Icons.flag,
                                      size: 50,
                                      color: Colors.grey,
                                    ),
                              ),
                            ),
                            const SizedBox(height: 12),

                            // 🌍 Country name
                            Text(
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              country.name?.common ?? 'Unknown',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            // 🌎 Region
                            Text(
                              country.region ?? '',
                              style: const TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              }

              if (state is CountryFlagFailure) {
                return const Center(
                  child: Text(
                    "Failed to load countries 😞",
                    style: TextStyle(fontSize: 16),
                  ),
                );
              }

              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
