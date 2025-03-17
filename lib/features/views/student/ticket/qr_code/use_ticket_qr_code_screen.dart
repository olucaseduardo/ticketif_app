
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ticket_ifma/core/services/providers.dart';
import 'package:ticket_ifma/core/utils/loader.dart';
import 'package:ticket_ifma/features/models/ticket.dart';
import 'package:ticket_ifma/features/resources/theme/app_colors.dart';
import 'package:ticket_ifma/features/resources/widgets/qr_code_dialog.dart';

class UseTicketQrCodeScreen extends ConsumerStatefulWidget {
  final Ticket ticket;

  const UseTicketQrCodeScreen({
    super.key,
    required this.ticket
  });

  @override
  ConsumerState<UseTicketQrCodeScreen> createState() => _UseTicketQrCodeScreenState();
}

class _UseTicketQrCodeScreenState extends ConsumerState<UseTicketQrCodeScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(useTicketQrCodeProvider);
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          backgroundColor: AppColors.white,
          foregroundColor: AppColors.black,
          centerTitle: false,
          title: const Text(
            'Voltar',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_rounded,
                color: AppColors.black,
              )),
        ),
        body: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular((size.width * 0.7)/2),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    // maxHeightDiskCache: 250,
                    // maxWidthDiskCache: 250,
                    width: size.width * 0.7,
                    height: size.width * 0.7,
                    cacheKey: "student_photo_${widget.ticket.student}",
                    imageUrl: controller.getImageUrlStudent(widget.ticket.student),
                    placeholder: (context, url) => Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: AppColors.gray[200]
                          ),
                          width: size.width * 0.7,
                          height: size.width * 0.7,
                          child: Loader.refreshLoader(),
                        ),
                      ],
                    ),
                    errorWidget: (context, url, error)
                    {
                      return Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: AppColors.gray[200]
                        ),
                        width: size.width * 0.7,
                        height: size.width * 0.7,
                        child: const Icon(
                          Icons.person,
                          size: 125,
                          color: AppColors.gray,
                        ),
                      );

                      },
                  ),
                ),
              ),
              const SizedBox(height: 15,),
              Text(
                  widget.ticket.studentName,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18
                ),
              ),
              const SizedBox(height: 8,),
              Text(
                  "${widget.ticket.student} - ${widget.ticket.type.toUpperCase()}",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal
                ),
              ),
              const SizedBox(height: 15,),
              Text(
                widget.ticket.meal.toUpperCase(),
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900
                ),
              ),
              showQrCode(widget.ticket.qrCodeInfo(),size: size.width * 0.75)
            ],
          ),
        ));
  }
}

