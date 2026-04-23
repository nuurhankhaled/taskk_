 
//  import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart'; 

// class LoginBlocListener extends StatelessWidget {
//   const LoginBlocListener({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<LoginCubit, LoginState>(
//       listenWhen: (previous, current) =>
//           current is Loading || current is Error || current is Success,
//       listener: (context, state) {
//         state.whenOrNull(
//           loading: () {
//             EasyLoading.show();
//           },
//           error: (message) {
//             EasyLoading.dismiss();
//             failureSnackBar(msg: message[0], context: context);
//           },
//           success: (loginResponse) {
//             TextInput.finishAutofillContext();
//             Future.delayed(const Duration(seconds: 1), () async {
//               EasyLoading.dismiss();
//               successSnackBar(
//                   msg: "signin.loginSuccess".tr(), context: context);
//               mainLayoutIntitalScreenIndex = 0;
//               context.pushNamedAndRemoveUntil(
//                 Routes.mainlayoutScreen,
//                 (route) => false,
//                 predicate: (Route<dynamic> route) {
//                   return false;
//                 },
//               );
//             });
//           },
//         );
//       },
//       child: const SizedBox.shrink(),
//     );
//   }
// }
