# h2o_admin_app

# Documentación del Proyecto de Software
Este documento proporciona una visión general de la estructura y los componentes principales de la aplicación.

### Estructura del Proyecto dentro de (`lib`)
La carpeta `lib` contiene el corazón de la aplicación. 
A continuación, se detalla la función de cada subcarpeta y archivo principal:

#### `api/`
* **Descripción:** Este directorio contiene un archivo necesaria para tener una comunicación con la API del backend, esto facilita la gestión de diferentes entornos del desarrollo, para ser más especificos, en los services.

#### `config/`

* **Descripción:** Contiene archivos de configuración general de la aplicación.
* **`router/`:** Define la navegación de la aplicación utilizando el paquete `go_router`. Aquí se encuentran las rutas, las transiciones y la lógica para dirigir al usuario a las diferentes pantallas (`screens`) de la aplicación.
* **`themes/`:** Agrupa la configuración visual de la aplicación. Esto incluye:
Definiciones de paletas de colores, estilos de texto personalizados o cualquier otro recurso visual reutilizable para mantener la consistencia en toda la interfaz de usuario.
* **`utils/`:** Contiene clases y métodos utilitarios que se utilizan en diversas partes de la aplicación. 
    * Funciones para formatear fechas y horas de manera legible y agradable.


#### `controllers/`

* **Descripción:** Esta carpeta contiene los controladores, que representan una de las primeras formas de gestionar la lógica de presentación en la aplicación. Los controladores actúan como intermediarios entre las `screens` y la capa de datos (`models` y `service`).
* **Organización:** Generalmente, cada `screen` tiene su controlador asociado, el cual maneja el estado y los eventos de esa pantalla.
* **Nota:** Aunque se ha migrado parte de la lógica a `providers`, algunos componentes aún utilizan controladores.

#### `models/`

* **Descripción:** Define la estructura de los datos que se manejan en la aplicación, estos modelos suelen corresponder a las respuestas JSON recibidas desde la API.
* **Organización:** Los modelos se organizan en subcarpetas, donde cada subcarpeta representa un módulo o una funcionalidad específica de la aplicación, cada archivo dentro de las subcarpetas define métodos para la serialización y deserialización de JSON que son muy importantes para ocuparlos en otras partes del proyecto.

#### `providers/`

* **Descripción:** Al igual que los `controllers`, esta carpeta contiene la lógica de presentación de la aplicación, utilizando un patrón de administración de estado Riverpod, gestionan el estado de la aplicación y permiten que las `screens` y los `widgets` accedan a este estado y reaccionen a sus cambios. 
Similares a los `controllers`, los `providers` pueden organizarse por funcionalidad o por `screen`.

#### `screens/`

* **Descripción:** Esta carpeta contiene la interfaz de usuario de la aplicación, cada archivo dentro de esta carpeta representa una pantalla o página que el usuario puede ver e interactuar.
* **Construcción:** Las `screens` se construyen utilizando los `widgets` personalizados y los `widgets` proporcionados por Flutter. Su lógica de presentación se obtiene  de los `controllers` o `providers` correspondientes.

#### `service/`

* **Descripción:** Contiene la lógica de comunicación con la API del backend. Los servicios son responsables de realizar las peticiones HTTP (GET, POST, PUT, DELETE) a los diferentes endpoints de la API.
* **Contenido:** Cada archivo de servicio contiene clases con métodos que encapsulan las llamadas a un endpoint específico, gestionando la construcción de la URL, los headers, el body de la petición y la deserialización de la respuesta en los `models` correspondientes.

#### `widgets/`

* **Descripción:** Contiene componentes de interfaz de usuario reutilizables, los cuales se utilizan en múltiples `screens` para mantener la consistencia visual y mejorar la experiencia del usuario.


#### `firebase_options.dart`

* **Descripción:** Contiene la configuración necesaria para inicializar y conectar la aplicación con los servicios de Firebase (autenticación, Firestore, Cloud Storage, etc.).

#### `main.dart`

* **Descripción:** Es el punto de entrada principal de la aplicación Flutter. Contiene la función `main()` que inicia la aplicación utilizando el `runApp()`.

#### `pubspec.yaml`

* **Descripción:** Este archivo es el manifiesto del proyecto Flutter, define las dependencias (librerías y paquetes externos utilizados en el proyecto), los assets (imágenes, fuentes), la versión de la aplicación y otra información relevante.



**Para detalles más específicos sobre la implementación de cada módulo, se recomienda revisar el código fuente dentro de cada directorio.**

--------------------------

##### Ejemplos y guías recopilados de:
[¿Qué es Clean Architecture?](https://www.youtube.com/watch?v=EI4nOsec2Ao)
[CLEAN ARCHITECTURE en Node con TypeScript](https://www.youtube.com/watch?v=497L4-LhvdM)
[Receta: Ejemplos útiles de Flutter](https://docs.flutter.dev/cookbook)
[Documentación oficial de flutter](https://docs.flutter.dev/) 


