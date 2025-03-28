import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ticket_ifma/core/services/providers.dart';
import 'package:ticket_ifma/core/utils/loader.dart';
import 'package:ticket_ifma/features/resources/widgets/app_message.dart';
import 'package:ticket_ifma/features/views/student/profile/new_solicitation/new_solitication_photo_student_controller.dart';

class NewSolicitationPhotoStudentScreen extends ConsumerStatefulWidget {
  const NewSolicitationPhotoStudentScreen({super.key});

  @override
  ConsumerState<NewSolicitationPhotoStudentScreen> createState() =>
      _NewSolicitationPhotoStudent();
}

class _NewSolicitationPhotoStudent
    extends ConsumerState<NewSolicitationPhotoStudentScreen> {
  List<CameraDescription> _cameras = [];
  CameraController? controllerCamera;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    _loadData();
  }

  @override
  void dispose() {
    controllerCamera?.dispose();
    super.dispose();
  }

  void _loadData() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        await ref.read(newSolicitationPhotoStudentProvider).loadData();
      } catch (e) {
        // Handle data loading errors
      }
    });
  }

  Future<void> _initializeCamera() async {
    WidgetsFlutterBinding.ensureInitialized();
    PermissionStatus status = await Permission.camera.request();

    if (status.isGranted) {
    } else if (status.isDenied) {
      AppMessage.i.showInfo("A permissão para usar a câmera é necessária.");
      if (mounted) {
        Navigator.pop(context);
      }
    } else if (status.isPermanentlyDenied) {
      AppMessage.i.showInfo(
        "Você será redirecionado as configurações do aplicativo, habilite o uso da câmera",
      );
      await Future.delayed(const Duration(seconds: 3));
      await openAppSettings();
      await Future.delayed(const Duration(seconds: 2));
      if (mounted) {
        Navigator.pop(context);
      }
    }
    try {
      _cameras = await availableCameras();
      if (_cameras.isEmpty) {
        return;
      }

      if (!mounted) return;
      setState(() {});
    } catch (e) {
      _handleCameraError(e);
    }

    CameraDescription? frontCamera;
    for (var camera in _cameras) {
      if (camera.lensDirection == CameraLensDirection.front) {
        frontCamera = camera;
        break;
      }
    }

    frontCamera ??= _cameras.first;

    controllerCamera = CameraController(
      frontCamera,
      ResolutionPreset.medium,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );
    controllerCamera?.lockCaptureOrientation();
    await controllerCamera?.setFocusMode(FocusMode.auto);
    try {
      await controllerCamera!.initialize();
    } on CameraException catch (e) {
      log(e.description!);
    }

    if (!mounted) return;
    setState(() {});
  }

  void _handleCameraError(Object e) {
    if (e is CameraException) {
      switch (e.code) {
        case 'CameraAccessDenied':
          AppMessage.i.showInfo(
            "É necessário permissão a câmera para continuar",
          );
          Navigator.pop(context);
          break;
        default:
          break;
      }
    } else {}
  }

  _takePicture(NewSolicitationPhotoStudentController controller) async {
    try {
      XFile picture = await controllerCamera!.takePicture();
      await controller.updatePicture(picture);
    } on CameraException catch (e) {
      log("Erro ao tirar a foto: ", error: e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(newSolicitationPhotoStudentProvider);
    return Scaffold(
      // appBar: _buildAppBar(),
      backgroundColor: Colors.black,
      body: SafeArea(child: _buildCamera(controller)),
    );
  }

  Widget _buildCamera(NewSolicitationPhotoStudentController controller) {
    if (controllerCamera == null || !controllerCamera!.value.isInitialized) {
      return Container(
        decoration: const BoxDecoration(color: Colors.black),
        child: Center(child: Loader.refreshLoader(size: 75)),
      );
    }
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              // margin: EdgeInsets.only(bottom: 100,top:statusBarHeight),
              child: _buildCamPicture(controller),
            ),
          ],
        ),
        Positioned(
          bottom: 75,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              controller.picture != null
                  ? IconButton(
                    iconSize: 25.0,
                    onPressed: () {
                      controller.updatePicture(null);
                    },
                    icon: const Icon(Icons.close, color: Colors.white),
                  )
                  : const SizedBox(),
              controller.picture == null
                  ? IconButton(
                    iconSize: 50.0,
                    autofocus: true,
                    onPressed: () => _takePicture(controller),
                    icon: const Icon(Icons.camera_alt, color: Colors.white),
                  )
                  : const SizedBox(),
              if (controller.picture != null)
                IconButton(
                  iconSize: 25.0,
                  onPressed: () async {
                    controller.sendSolicitation().whenComplete(
                      () => Navigator.pop(context),
                    );
                  },
                  icon: const Icon(Icons.check, color: Colors.white),
                )
              else
                const SizedBox(),
            ],
          ),
        ),
      ],
    );
  }

  Future<ImageInfo> _getImageInfo(File file) async {
    final image = Image.file(file);
    final completer = Completer<ImageInfo>();
    image.image
        .resolve(const ImageConfiguration())
        .addListener(
          ImageStreamListener((ImageInfo info, bool _) {
            completer.complete(info);
          }),
        );
    return completer.future;
  }

  Widget _buildCamPicture(NewSolicitationPhotoStudentController controller) {
    final size = MediaQuery.of(context).size;
    if (controller.picture != null) {
      return Padding(
        padding: const EdgeInsets.only(top: 100),
        child: FutureBuilder<ImageInfo>(
          future: _getImageInfo(File(controller.picture!.path)),
          builder: (context, snapshot) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: SizedBox(
                    width: size.width,
                    height: size.width,
                    child: Image.file(
                      File(controller.picture!.path),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(5),
                  margin: EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                    color: Colors.white70.withValues(alpha: .5),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Text(
                    "Certifique-se de que seu rosto esteja devidamente centralizado na câmera."
                    " Esta foto será avaliada, e somente com ela em mãos será autorizada a refeição para o estudante.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 13, color: Colors.white),
                  ),
                ),
              ],
            );
          },
        ),
      );
    }
    return Stack(
      alignment: Alignment.center,
      children: [
        Transform(
          alignment: Alignment.center,
          transform:
              Matrix4.identity()..scale(-1.0, 1.0, 1.0), // Flip horizontally
          child: CameraPreview(controllerCamera!),
        ),
        Positioned(
          top: 20,
          width: size.width - 20,
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.black12.withValues(alpha: .5),
              borderRadius: BorderRadius.circular(5),
            ),
            child: const Text(
              "Evite acessórios. Posicione o rosto no centro da câmera",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: Colors.white70),
            ),
          ),
        ),
      ],
    );
  }
}
