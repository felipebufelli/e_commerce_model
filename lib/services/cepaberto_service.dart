import 'dart:io';
import 'package:dio/dio.dart';
import 'package:e_commerce_model/common/tokens.dart';
import 'package:e_commerce_model/models/cepaberto_address.dart';

class CepAbertoService {

  Future<CepAbertoAddress> getAddressFromCep(String cep) async {
    final cleanCep = cep.replaceAll('.', '').replaceAll('-', '');
    final endPoint = "https://www.cepaberto.com/api/v3/cep?cep=$cleanCep";

    final Dio dio = Dio();

    dio.options.headers[HttpHeaders.authorizationHeader] = 'Token token = $cep_Token';

    try {
      final response = await dio.get<Map<String, dynamic>>(endPoint);

      if(response.data.isEmpty) {
        return Future.error('CEP Inválido');
      }

      final CepAbertoAddress adress = CepAbertoAddress.fromJson(response.data);

      return adress;
    } on DioError {
      //! TRATAR ERRO
      return Future.error('Erro ao buscar CEP');
    }

  }  

}