import '../../widgets.dart';

class Button extends StatelessWidget {
  String text;
  Color? backgroundColor;
  Function()? onPressed;
  Button({Key? key, required this.text, this.backgroundColor, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.resolveWith(
          (states) => RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        backgroundColor: MaterialStateProperty.resolveWith(
          (states) => backgroundColor ?? Theme.of(context).primaryColor,
        ),
        elevation: MaterialStateProperty.resolveWith((states) => 0),
        minimumSize: MaterialStateProperty.resolveWith(
          (states) => const Size(
            double.infinity,
            50,
          ),
        ),
      ),
      onPressed: () {
        if (onPressed != null) {
          onPressed!();
        }
      },
      child: Text(
        text,
        style: Theme.of(context).textTheme.button,
      ),
    );
  }
}
