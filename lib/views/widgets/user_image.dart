import 'hex_text.dart';

class UserImage extends StatelessWidget {
  const UserImage({
    super.key,
    this.file,
    this.imageUrl,
    required this.size,
    required this.radius,
  });

  final File? file;
  final String? imageUrl;
  final double size;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: file == null
          ? CachedNetworkImage(
              imageUrl: imageUrl ?? 'm',
              height: size,
              width: size,
              fit: BoxFit.fill,
              placeholder: (_, __) => Image.asset(
                'user'.png,
                height: size,
                width: size,
                fit: BoxFit.fill,
              ),
              errorWidget: (_, __, ___) => Image.asset(
                'user'.png,
                height: size,
                width: size,
                fit: BoxFit.fill,
              ),
            )
          : Image.file(
              file!,
              height: size,
              width: size,
              fit: BoxFit.fill,
            ),
    );
  }
}
