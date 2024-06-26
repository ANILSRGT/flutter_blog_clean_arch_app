import 'package:flutter/material.dart';
import 'package:flutter_blog_clean_arch_app/core/common/widgets/toast/custom_toast.dart';

class BaseCustomToastOverlay extends OverlayEntry {
  BaseCustomToastOverlay({
    required BaseCustomToastOverlayParams params,
    Color bgColor = const Color(0xFF1D1D1D),
    Color textColor = const Color(0xFFFBFBFB),
    Widget? leadingIcon,
    Widget? trailingIcon,
  }) : super(
          builder: (_) {
            return Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: params.alignment == CustomToastAlignment.top
                      ? kToolbarHeight
                      : null,
                  bottom: params.alignment == CustomToastAlignment.bottom
                      ? kToolbarHeight
                      : null,
                  child: Material(
                    color: bgColor,
                    borderRadius: BorderRadius.circular(5),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth:
                            MediaQuery.of(params.context).size.width * 0.9,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (params.title != null) ...[
                              Flexible(
                                child: Text(
                                  params.title!,
                                  textAlign: TextAlign.end,
                                  style: Theme.of(params.context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        color: textColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ),
                              const SizedBox(height: 4),
                            ],
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (leadingIcon != null) ...[
                                  leadingIcon,
                                  const SizedBox(width: 8),
                                ],
                                Flexible(
                                  child: Text(
                                    params.message,
                                    style: Theme.of(params.context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          color: textColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ),
                                if (trailingIcon != null) ...[
                                  const SizedBox(width: 8),
                                  trailingIcon,
                                ],
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
}

final class BaseCustomToastOverlayParams {
  BaseCustomToastOverlayParams({
    required this.context,
    required this.message,
    required this.alignment,
    this.title,
  });
  final BuildContext context;
  final String message;
  final CustomToastAlignment alignment;
  final String? title;
}
