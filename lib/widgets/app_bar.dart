import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const kAppBarHeight = 42.0;

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final bool automaticallyImplyLeading;
  final Widget? title;
  final List<Widget>? actions;
  final Widget? flexibleSpace;
  final PreferredSizeWidget? bottom;
  final double elevation;
  final Color? shadowColor;
  final ShapeBorder? shape;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final SystemUiOverlayStyle? systemOverlayStyle;
  final IconThemeData? iconTheme;
  final IconThemeData? actionsIconTheme;
  final bool primary;
  final bool? centerTitle;
  final bool excludeHeaderSemantics;
  final double? titleSpacing;
  final double toolbarOpacity;
  final double bottomOpacity;
  final double? leadingWidth;
  final bool? backwardsCompatibility;
  final TextStyle? toolbarTextStyle;
  final TextStyle? titleTextStyle;
  final bool showRouteName;

  const CustomAppBar({
    super.key,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.showRouteName = true,
    this.title,
    this.actions,
    this.flexibleSpace,
    this.bottom,
    this.elevation = 0,
    this.shadowColor,
    this.shape,
    this.backgroundColor,
    this.foregroundColor,
    this.iconTheme,
    this.actionsIconTheme,
    this.primary = true,
    this.centerTitle,
    this.systemOverlayStyle,
    this.excludeHeaderSemantics = false,
    this.titleSpacing,
    this.toolbarOpacity = 1.0,
    this.bottomOpacity = 1.0,
    this.leadingWidth,
    this.backwardsCompatibility,
    this.toolbarTextStyle,
    this.titleTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    final ModalRoute<dynamic>? parentRoute = ModalRoute.of(context);
    final bool canPopParent = parentRoute?.canPop ?? false;
    final bool canPop = ModalRoute.canPopOf(context) ?? false;
    // List<Widget>? newActions;

    // if ((actions?.length ?? 0) > 0) {
    //   newActions = List.generate(actions!.length, (index) {
    //     // if (index == actions!.length - 1) {
    //     //   return actions![index];
    //     // } else {
    //     return Padding(
    //       padding: const EdgeInsets.only(
    //         right: kPaddingMedium,
    //         top: kPaddingXXSmall,
    //         bottom: kPaddingXXSmall,
    //       ),
    //       child: actions![index],
    //     );
    //     // }
    //   });
    // }

    return AppBar(
      leading: leading ??
          ((canPop || canPopParent) ? const CustomBackButton() : null),
      automaticallyImplyLeading: automaticallyImplyLeading,
      title: title,
      actions: actions,
      flexibleSpace: flexibleSpace,
      bottom: bottom,
      elevation: elevation,
      shadowColor: shadowColor,
      shape: shape,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      systemOverlayStyle: systemOverlayStyle,
      iconTheme: iconTheme,
      actionsIconTheme: actionsIconTheme,
      primary: primary,
      centerTitle: centerTitle,
      excludeHeaderSemantics: excludeHeaderSemantics,
      titleSpacing: titleSpacing,
      toolbarOpacity: toolbarOpacity,
      bottomOpacity: bottomOpacity,
      leadingWidth: leadingWidth,
      toolbarTextStyle: toolbarTextStyle,
      titleTextStyle: titleTextStyle,
      toolbarHeight: kAppBarHeight,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kAppBarHeight);
}

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios_rounded),
      onPressed: () {
        if (Navigator.canPop(context)) {
          Navigator.maybePop(context);
        }
      },
    );
  }
}
