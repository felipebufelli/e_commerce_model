import 'dart:io';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:e_commerce_model/common/custom_colors.dart';
import 'package:e_commerce_model/models/product.dart';
import 'package:e_commerce_model/screens/edit_product/components/image_source_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImagesForm extends StatelessWidget {

  const ImagesForm(this.product);

  final Product product;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return FormField<List<dynamic>>(
      initialValue: product.images,
      validator: (images){
        if(images.isEmpty){
          return 'Insira ao menos uma imagem';
        } 
        return null;
      },
      builder: (state){

        void onImageSelected(File file){
          state.value.add(file);
          state.didChange(state.value);
          Navigator.of(context).pop();
        }

        return Column(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Carousel(
                images: state.value.map<Widget>((image) {
                  return Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      // ignore: prefer_if_elements_to_conditional_expressions
                      image is String
                        ? Image.network(image, fit: BoxFit.cover,)
                        : Image.file(image as File, fit: BoxFit.cover,),
                      
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: const Icon(Icons.delete),
                          color: Colors.red, 
                          onPressed: (){
                            state.value.remove(image);
                            state.didChange(state.value);
                          },
                        ),
                      )
                    ],
                  );
                }).toList()..add(
                  Material(
                    color: Colors.grey[100],
                    child: IconButton(
                      icon: const Icon(Icons.add_a_photo),
                      color: CustomColors.primaryColor,
                      iconSize: 50,
                      onPressed: () {
                        if(Platform.isAndroid){
                          showModalBottomSheet(
                            context: context, 
                            builder: (_) => ImageSourceSheet(
                              onImageSelected: onImageSelected,
                            ),
                          );
                        } else {
                          showCupertinoModalPopup(
                            context: context, 
                            builder: (_) => ImageSourceSheet(
                              onImageSelected: onImageSelected,
                            ),
                          );
                        }
                      }
                    ),
                  )
                ),
                dotSize: 4,
                dotBgColor: Colors.transparent,
                dotColor: primaryColor,
                autoplay: false,
                dotSpacing: 15,
              ),
            ),
            // ignore: prefer_if_elements_to_conditional_expressions
            state.hasError
              ? Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(top: 16, left: 16),
                child: Text(
                  state.errorText,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                  ),
                ),
              )
              : Container(),

          ],
        );
      },
    );
  }
}