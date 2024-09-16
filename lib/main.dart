import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:nasa_apod/features/presentation/blocs/apod/apod_bloc.dart';
import 'package:nasa_apod/features/presentation/pages/apod/apod_page.dart';
import 'core/di/injection_container.dart' as di;
import 'generated/l10n.dart';

void main() {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      supportedLocales: S.delegate.supportedLocales,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: BlocProvider(
        create: (_) => di.sl<ApodBloc>(),
        child: const ApodPage(),
      ),
    );
  }
}
