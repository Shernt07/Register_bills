import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:h2o_admin_app/providers/profile_provider.dart';
import 'package:h2o_admin_app/providers/users_provider.dart';
import 'package:h2o_admin_app/service/profile_service.dart';
import 'package:h2o_admin_app/widgets/alertDialog/alertDialog_CategoryAdd_custom.dart';
import 'package:h2o_admin_app/widgets/alertDialog/alert_dialog_custom.dart';
import 'package:h2o_admin_app/widgets/alertDialog/alert_dialog_news_custom.dart';
import 'package:h2o_admin_app/widgets/appBar/app_bar_widget.dart';
import 'package:h2o_admin_app/widgets/bottomNavigatorBar/bottom_navigator_bar_widget.dart';
import 'package:h2o_admin_app/widgets/textFormField/text_form_field_custom.dart';
import 'package:h2o_admin_app/widgets/textFormField/text_visualize_custom.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';

class MyInformationScreen extends ConsumerStatefulWidget {
  static const String name = 'my_information_screen';

  const MyInformationScreen({super.key});

  @override
  ConsumerState<MyInformationScreen> createState() =>
      _MyInformationScreenState();
}

class _MyInformationScreenState extends ConsumerState<MyInformationScreen> {
  File? _imageFile;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedImage != null) {
      if (mounted) {
        // Lee la imagen seleccionada
        final imageBytes = await pickedImage.readAsBytes();
        final image = img.decodeImage(imageBytes);

        // Corrige la orientación de la imagen si es necesario
        img.bakeOrientation(image!);

        // Obtiene la extensión de la imagen
        final extension = pickedImage.path.split('.').last.toLowerCase();

        // Guarda la imagen con el formato adecuado
        if (extension == 'jpg' || extension == 'jpeg') {
        } else if (extension == 'png') {
        } else {
          // Si no es JPG ni PNG, puedes manejar el error o ignorarlo
          throw Exception('Formato de imagen no soportado');
        }

        setState(() {
          _imageFile = File(pickedImage.path);
        });
      }
    }
  }

  Future<void> _saveChanges() async {
    final userId = ref.read(usersProvider)!.idUser;
    final profileService = ProfileService();

    if (_imageFile != null) {
      final success = await profileService.updateProfileImage(
        userId,
        _imageFile!,
      );
      if (success) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Imagen de perfil actualizada')),
          );
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Error al actualizar la imagen')),
          );
        }
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No se seleccionó ninguna imagen')),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    //Future.delayed para esperar a que el widget esté completamente montado
    Future.delayed(Duration.zero, () {
      final userId = ref.read(usersProvider)!.idUser;
      final profileNotifier = ref.read(profileProvider.notifier);
      profileNotifier.loadProfile(userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final profileState = ref.watch(profileProvider);

    if (profileState.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (profileState.error.isNotEmpty) {
      return Center(child: Text(profileState.error));
    }

    final profile = profileState.profile;

    return Scaffold(
      appBar: const AppBarCustom(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage:
                      _imageFile != null
                          ? FileImage(_imageFile!)
                          : (profile?.urlImg != null &&
                                      profile!.urlImg!.isNotEmpty
                                  ? NetworkImage(profile.urlImg!)
                                  : const AssetImage(
                                    'assets/img/profile_image.png',
                                  ))
                              as ImageProvider,
                ),
                Positioned(
                  bottom: 4,
                  right: 4,
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: const Color(0xFF08A5C0),
                    child: IconButton(
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 16,
                      ),
                      onPressed: () {
                        _pickImage();
                        // showDialog(
                        //   context: context,
                        //   barrierDismissible: false,
                        //   builder:
                        //       (context) => CustomAlertDialogNews(
                        //         title: 'Cambiar foto',
                        //         onConfirm: () async {
                        //           // await notifier.loadCategories();
                        //         },
                        //       ),
                        // );
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            TextFormFieldCustom(
              labelText: profile?.name ?? 'Cargando...',
              icon: Icons.person,
              enabled: false,
            ),
            const SizedBox(height: 16),
            TextFormFieldCustom(
              labelText: profile?.email ?? 'Cargando...',
              icon: Icons.email,
              enabled: false,
            ),
            const SizedBox(height: 16),
            TextFormFieldCustom(
              labelText: profile?.telephone ?? 'Cargando...',
              icon: Icons.phone,
              enabled: false,
            ),
            const SizedBox(height: 16),
            // TextVisualizeCustom(
            //   labelText: "Dirreción",
            //   value:
            //       "Av. Las Palmeras 1234, Colonia El Mirador, Ciudad del Sol, CP 45678,     Av. Las Palmeras 1234, Colonia El Mirador, Ciudad del Sol, CP 45678",
            //   icon: Icons.accessibility,
            // ),
            SizedBox(
              width: 250,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  _saveChanges();
                },
                style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Color(0xFF08A5C0)),
                ),
                child: const Text(
                  'Guardar cambios',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigatorBarCustom(),
    );
  }
}
