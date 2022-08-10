import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wolofbat/server/index.dart';

class MyImage extends StatefulWidget {
  final String token;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final AlignmentGeometry alignment;

  const MyImage({
    Key? key,
    required this.token,
    this.width,
    this.height,
    this.fit,
    this.alignment = Alignment.center,
  }) : super(key: key);

  @override
  State<MyImage> createState() => _MyImageState();
}

class _MyImageState extends State<MyImage> {
  Future<Image> load() async {
    var url = '${Server.root}/servile/get?token=${widget.token}';
    var file = await DefaultCacheManager().getSingleFile(url);

    return Image.file(
      file,
      fit: widget.fit,
      alignment: widget.alignment,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: FutureBuilder(
        future: load(),
        builder: (BuildContext context, AsyncSnapshot<Image> image) {
          if (image.hasData) {
            return image.data!;
          } else if (image.hasError) {
            return Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 32, maxHeight: 32),
                child: SvgPicture.asset('assets/svgs/alt.svg'),
              ),
            );
          } else {
            return Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 32, maxHeight: 32),
                child: const CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}
