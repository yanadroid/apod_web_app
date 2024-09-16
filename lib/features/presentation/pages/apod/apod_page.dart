import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasa_apod/core/extension/quotation_extension.dart';
import 'package:nasa_apod/features/presentation/blocs/apod/apod_bloc.dart';
import 'package:nasa_apod/features/presentation/blocs/apod/apod_event.dart';
import 'package:nasa_apod/features/presentation/blocs/apod/apod_state.dart';
import 'package:nasa_apod/features/presentation/pages/apod/full_screen_apod_page.dart';
import 'package:nasa_apod/generated/l10n.dart';

class ApodPage extends StatelessWidget {
  const ApodPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.current.title_app,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder<ApodBloc, ApodState>(
        builder: (context, state) {
          if (state is ApodInitial) {
            BlocProvider.of<ApodBloc>(context).add(GetApodEvent());
            return const Center(child: CircularProgressIndicator());
          } else if (state is ApodLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ApodLoaded) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, __, ___) => FullScreenApodPage(apod: state.apod),
                    transitionsBuilder: (_, animation, __, child) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                    transitionDuration: const Duration(milliseconds: 350),
                  ),
                );
              },
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      state.apod.url,
                      height: MediaQuery.of(context).size.height * 0.5,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      state.apod.title.addQuotationMarks(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is ApodError) {
            return Center(child: Text(state.message));
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}


