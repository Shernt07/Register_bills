import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:h2o_admin_app/models/customer/allCustomer_models.dart';
import 'package:h2o_admin_app/models/delivery/allDelivery_models.dart';
import 'package:h2o_admin_app/models/generateReports/generateReports_models.dart';
import 'package:h2o_admin_app/models/products/allProducts_models.dart';
import 'package:h2o_admin_app/screens/screens.dart';

final appRouter = GoRouter(
  initialLocation: "/intro",
  routes: [
    GoRoute(
      path: "/intro",
      name: "intro_screen",
      pageBuilder:
          (context, state) =>
              MaterialPage(key: state.pageKey, child: AnimatedIntroScreen()),
    ),
    GoRoute(
      path: "/login",
      name: "login_screen",
      pageBuilder:
          (context, state) =>
              MaterialPage(key: state.pageKey, child: LoginScreen()),
    ),
    GoRoute(
      path: '/register',
      name: 'register_screen',
      pageBuilder:
          (context, state) =>
              MaterialPage(key: state.pageKey, child: const RegisterScreen()),
    ),
    GoRoute(
      path: '/resetpassword',
      name: 'resetpassword_screen',
      pageBuilder:
          (context, state) => MaterialPage(
            key: state.pageKey,
            child: const ResetPasswordScreen(),
          ),
    ),
    GoRoute(
      path: '/confirmationemail',
      name: 'confirmationemail_screen',
      pageBuilder:
          (context, state) => MaterialPage(
            key: state.pageKey,
            child: const ConfirmationEmailPassword(),
          ),
    ),
    GoRoute(
      path: '/listOrders',
      name: 'list_orders_screen',
      pageBuilder:
          (context, state) =>
              MaterialPage(key: state.pageKey, child: ListOrdersScreen()),
    ),
    GoRoute(
      path: '/detailsOrders',
      name: 'details_order_screen',
      pageBuilder: (context, state) {
        final order = state.extra as Map<String, dynamic>;
        return MaterialPage(
          key: state.pageKey,
          child: DetailOrderScreen(order: order),
        );
      },
    ),
    GoRoute(
      path: '/cancelOrders',
      name: 'cancel_order_screen',
      pageBuilder:
          (context, state) =>
              MaterialPage(key: state.pageKey, child: CancelOrderScreen()),
    ),
    GoRoute(
      path: '/myprofile',
      name: 'my_profile_screen',
      pageBuilder:
          (context, state) =>
              MaterialPage(key: state.pageKey, child: const ProfileScreen()),
    ),
    GoRoute(
      path: '/dashboard',
      name: 'dashboard_screen',
      pageBuilder:
          (context, state) =>
              MaterialPage(key: state.pageKey, child: DashboardScreen()),
    ),
    // GENERATE REPORTS
    GoRoute(
      path: '/reportes',
      name: 'reportes_screen',
      pageBuilder:
          (context, state) => MaterialPage(
            key: state.pageKey,
            child: const ReportGenerationScreen(),
          ),
    ),
    GoRoute(
      path: '/reportesPDF',
      name: 'reportesPDF_screen',
      pageBuilder: (context, state) {
        final reportsJson = state.extra as String; // Recibir el JSON string
        final reports = generateReportsModelsFromJson(
          reportsJson,
        ); // Convertir el JSON a lista de objetos

        return MaterialPage(
          key: state.pageKey,
          child: ReportPreviewScreen(
            reporte: reports,
          ), // Pasar la lista de objetos a la pantalla
        );
      },
    ),
    //HJKL;
    GoRoute(
      path: '/myinformation',
      name: 'my_information_screen',
      pageBuilder:
          (context, state) => MaterialPage(
            key: state.pageKey,
            child: const MyInformationScreen(),
          ),
    ),
    GoRoute(
      path: '/managementDistributors',
      name: 'management_distributors_screen',
      pageBuilder:
          (context, state) => MaterialPage(
            key: state.pageKey,
            child: const ManagementDistributorsScreen(),
          ),
    ),
    GoRoute(
      path: '/managementDistributorsAdd',
      name: 'management_distributorsAdd_screen',
      pageBuilder:
          (context, state) => MaterialPage(
            key: state.pageKey,
            child: ManagementDistributorsAddScreen(),
          ),
    ),
    GoRoute(
      path: '/managementDistributorsEdit',
      name: 'management_distributorsEdit_screen',
      pageBuilder: (context, state) {
        final delivery = AllDeliveryModels.fromJson(
          state.extra as Map<String, dynamic>,
        );

        return MaterialPage(
          key: state.pageKey,
          child: ManagementDistributorsEditScreen(delivery: delivery),
        );
      },
    ),
    //MANAGEMENT CUSTOMER
    GoRoute(
      path: '/managementCustomer',
      name: 'management_customer_screen',
      pageBuilder:
          (context, state) => MaterialPage(
            key: state.pageKey,
            child: const ManagementCustomerScreen(),
          ),
    ),
    GoRoute(
      path: '/managementCustomerAdd',
      name: 'management_customerAdd_screen',
      pageBuilder:
          (context, state) => MaterialPage(
            key: state.pageKey,
            child: const ManagementCustomerAddScreen(),
          ),
    ),
    GoRoute(
      path: '/managementCustomerEdit',
      name: 'management_customerEdit_screen',
      pageBuilder: (context, state) {
        final customer = AllCustomerModels.fromJson(
          state.extra as Map<String, dynamic>,
        );

        return MaterialPage(
          key: state.pageKey,
          child: ManagementCustomerEditScreen(customer: customer),
        );
      },
    ),
    //Categories
    GoRoute(
      path: '/managementCategories',
      name: 'management_categories_screen',
      pageBuilder:
          (context, state) => MaterialPage(
            key: state.pageKey,
            child: ManagementCategoriesScreen(),
          ),
    ),
    //MANAGEMET PRODUCTS
    GoRoute(
      path: '/managementProducts',
      name: 'management_products_screen',
      pageBuilder:
          (context, state) => MaterialPage(
            key: state.pageKey,
            child: ManagementProductsScreen(),
          ),
    ),
    GoRoute(
      path: '/managementProductsAdd',
      name: 'management_productsAdd_screen',
      pageBuilder:
          (context, state) => MaterialPage(
            key: state.pageKey,
            child: ManagementProductsAddScreen(),
          ),
    ),
    GoRoute(
      path: '/managementProductsEdit',
      name: 'management_productsEdit_screen',
      pageBuilder: (context, state) {
        final extraProduct = AllProductsModels.fromJson(
          state.extra as Map<String, dynamic>,
        );

        return MaterialPage(
          key: state.pageKey,
          child: ManagementProductsEditScreen(extraProduct: extraProduct),
        );
      },
    ),
    //NEWS
    GoRoute(
      path: '/managementNews',
      name: 'management_news_screen',
      pageBuilder:
          (context, state) =>
              MaterialPage(key: state.pageKey, child: ManagementNewsScreen()),
    ),
    // SUGGESTIONS
    GoRoute(
      path: '/managementSuggestions',
      name: 'management_suggestions_screen',
      pageBuilder:
          (context, state) => MaterialPage(
            key: state.pageKey,
            child: const ListSuggestionsScreen(),
          ),
    ),
  ],
);
