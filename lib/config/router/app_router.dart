import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:teslo_shop/features/auth/auth.dart';
import 'package:teslo_shop/features/auth/presentation/providers/auth_provider.dart';
import 'package:teslo_shop/features/products/products.dart';

import 'app_router_notifier.dart';

final gotRouterProvider = Provider((ref) {

  final goRouterNotifier = ref.read(goRouterNotifierProvider);


  return GoRouter(
    initialLocation: '/splash',
    refreshListenable: goRouterNotifier,
    routes: [
      ///* Primera pantalla
      GoRoute(
        path: '/splash',
        builder: (context, state) => const CheckAuthStatusScreen(),
      ),

      ///* Auth Routes
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),

      ///* Product Routes
      GoRoute(
        path: '/',
        builder: (context, state) => const ProductsScreen(),
      ),

      GoRoute(
        path: '/product/:id', // /product/new
        builder: (context, state) =>  ProductScreen(
          productId: state.pathParameters['id'] ?? 'no-id',
        ),
      ),
    ],

    redirect: (context, state) {
      
      final isGoingTo = state.matchedLocation; // A que pagina va la persona..
      final authStatus = goRouterNotifier.authStatus;// Si esta autenticado o no...

      if ( isGoingTo == '/splash' && authStatus == AuthStatus.checking ) return null; // si va a una pagina y si se está autenticado no hace nada...

      if ( authStatus == AuthStatus.notAuthenticated ) {
        if ( isGoingTo == '/login' || isGoingTo == 'register' ) return null; // Aqui se deja pasar a cualquier ruta de las dos...

        return '/login';
      }

      if ( authStatus == AuthStatus.authenticated ) {
        if ( isGoingTo == '/login' || isGoingTo == 'register' || isGoingTo == '/splash' ) {
          return '/';
        } // si esta autenticado lo mando a la pantalla de splash y no puede ir a esas rutas...
      }

      return null;
    },
  );
});
