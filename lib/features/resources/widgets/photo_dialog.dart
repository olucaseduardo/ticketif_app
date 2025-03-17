import 'package:flutter/material.dart';
import 'package:ticket_ifma/core/utils/loader.dart';

Future<String?> photoRequestDialog(BuildContext context, String imageUrl) =>
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close)),
              ),
              Center(
                child: Image.network(
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return Loader.refreshLoader();
                  },
                  errorBuilder: (context, error, stackTrace) => const Text(
                    "Erro ao carregar a foto do estudante, confira sua conexão com a internet e tente novamente",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                  imageUrl,
                  height: 300,
                  width: 300,
                  fit: BoxFit.cover,
                ),
              )
            ],
          ),
        ),
      ),
    );
