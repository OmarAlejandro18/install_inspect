import 'package:flutter/material.dart';

class CampoTimePicker extends StatefulWidget {
  final TextEditingController controlador;
  final String hinText;

  const CampoTimePicker(
      {super.key, required this.controlador, required this.hinText});
  @override
  State<CampoTimePicker> createState() => _CampoTimePickerState();
}

class _CampoTimePickerState extends State<CampoTimePicker> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              offset: Offset(4, -4),
              blurRadius: 6,
              color: Colors.black26,
            ),
          ],
        ),
        height: 60,
        child: TextFormField(
          controller: widget.controlador,
          style: const TextStyle(
            color: Colors.black87,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: const EdgeInsets.only(top: 14),
            prefixIcon: const Icon(
              Icons.email,
              color: Colors.white,
            ),
            hintText: widget.hinText,
            hintStyle: const TextStyle(color: Colors.black38),
          ),
          onTap: () => {
            FocusScope.of(context).requestFocus(FocusNode()),
            selectTime(context),
          },
        ),
      ),
    );
  }

  selectTime(BuildContext context) {
    String hora;
    return showTimePicker(context: context, initialTime: TimeOfDay.now())
        .then((value) => setState(() {
              hora = value.toString();
              widget.controlador.text = hora.substring(10, 15);
            }));
  }
}
