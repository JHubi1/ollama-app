import 'dart:async';
import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart' hide RouteSettings;
import 'package:ollama_dart/ollama_dart.dart' as llama;

import '../l10n/gen/app_localizations.dart';
import '../main.dart';
import '../main.gr.dart';
import '../services/services.dart';
import '../widgets/model_selector.dart';
import '../widgets/two_state_widget.dart';
import 'chat.dart';
import 'settings.dart';

// import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
// import 'package:flutter_chat_ui/flutter_chat_ui.dart' as chat_ui;
// import 'package:flutter_markdown/flutter_markdown.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:markdown/markdown.dart' as md;
// import 'package:pwa_install/pwa_install.dart' as pwa;
// import 'package:url_launcher/url_launcher.dart';
// import 'package:uuid/uuid.dart';
// import 'package:version/version.dart';
// import 'package:visibility_detector/visibility_detector.dart';

// import '../l10n/gen/app_localizations.dart';
// import '../main.dart';
// import '../services/model.dart';
// import '../services/preferences.dart';
// import '../worker/desktop.dart';
// import '../worker/haptic.dart';
// import '../worker/sender.dart';
// import '../worker/setter.dart';
// import '../worker/theme.dart';
// import '../worker/update.dart';
// import 'settings.dart';
// import 'voice.dart';
// import 'welcome.dart';

// class ScreenMain extends StatefulWidget {
//   const ScreenMain({super.key});

//   @override
//   State<ScreenMain> createState() => _ScreenMainState();
// }

// class _ScreenMainState extends State<ScreenMain> {
//   int tipId = Random().nextInt(5);

//   List<Widget> sidebar(BuildContext context, Function setState) {
//     var padding = EdgeInsets.only(
//       left: desktopLayoutRequired(context) ? 17 : 12,
//       right: desktopLayoutRequired(context) ? 17 : 12,
//     );
//     return List.from([
//       (desktopLayoutNotRequired(context) || kIsWeb)
//           ? const SizedBox(height: 8)
//           : const SizedBox.shrink(),
//       desktopLayoutNotRequired(context)
//           ? const SizedBox.shrink()
//           : (Padding(
//               padding: padding,
//               child: InkWell(
//                 enableFeedback: false,
//                 customBorder: const RoundedRectangleBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(50)),
//                 ),
//                 onTap: () async {
//                   // ester egg? gimmick? not sure if it should be kept
//                   return;
//                   // ignore: dead_code
//                   if (sidebarIconSize != 1) return;
//                   setState(() {
//                     sidebarIconSize = 0.8;
//                   });
//                   await Future.delayed(const Duration(milliseconds: 200));
//                   setState(() {
//                     sidebarIconSize = 1.2;
//                   });
//                   await Future.delayed(const Duration(milliseconds: 200));
//                   setState(() {
//                     sidebarIconSize = 1;
//                   });
//                 },
//                 child: Padding(
//                   padding: const EdgeInsets.only(top: 16, bottom: 16),
//                   child: Row(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(left: 16, right: 12),
//                         child: AnimatedScale(
//                           scale: sidebarIconSize,
//                           duration: const Duration(milliseconds: 400),
//                           child: const ImageIcon(
//                             AssetImage("assets/logo512.png"),
//                           ),
//                         ),
//                       ),
//                       Expanded(
//                         child: Text(
//                           AppLocalizations.of(context).appTitle,
//                           softWrap: false,
//                           overflow: TextOverflow.fade,
//                           style: const TextStyle(fontWeight: FontWeight.w500),
//                         ),
//                       ),
//                       const SizedBox(width: 16),
//                     ],
//                   ),
//                 ),
//               ),
//             )),
//       (desktopLayoutNotRequired(context) ||
//               (!allowMultipleChats && !allowSettings))
//           ? const SizedBox.shrink()
//           : Divider(
//               color: desktopLayout(context)
//                   ? Theme.of(context).colorScheme.onSurface.withAlpha(20)
//                   : null,
//             ),
//       allowMultipleChats
//           ? (Padding(
//               padding: padding,
//               child: InkWell(
//                 enableFeedback: false,
//                 customBorder: const RoundedRectangleBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(50)),
//                 ),
//                 onTap: () {
//                   selectionHaptic();
//                   if (!desktopLayout(context)) {
//                     Navigator.of(context).pop();
//                   }
//                   ChatManager.instance.currentChatId = null;
//                 },
//                 child: Padding(
//                   padding: const EdgeInsets.only(top: 16, bottom: 16),
//                   child: Row(
//                     children: [
//                       const Padding(
//                         padding: EdgeInsets.only(left: 16, right: 12),
//                         child: Icon(Icons.add_rounded),
//                       ),
//                       Expanded(
//                         child: Text(
//                           AppLocalizations.of(context).optionNewChat,
//                           softWrap: false,
//                           overflow: TextOverflow.fade,
//                           style: const TextStyle(fontWeight: FontWeight.w500),
//                         ),
//                       ),
//                       const SizedBox(width: 16),
//                     ],
//                   ),
//                 ),
//               ),
//             ))
//           : const SizedBox.shrink(),
//       allowSettings
//           ? (Padding(
//               padding: padding,
//               child: InkWell(
//                 enableFeedback: false,
//                 customBorder: const RoundedRectangleBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(50)),
//                 ),
//                 onTap: () {
//                   selectionHaptic();
//                   if (!desktopLayout(context)) {
//                     Navigator.of(context).pop();
//                   }
//                   setState(() {
//                     settingsOpen = true;
//                   });
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => const ScreenSettings(),
//                     ),
//                   );
//                 },
//                 child: Padding(
//                   padding: const EdgeInsets.only(top: 16, bottom: 16),
//                   child: Row(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(left: 16, right: 12),
//                         child:
//                             (updateStatus == "ok" &&
//                                 updateDetectedOnStart &&
//                                 (Version.parse(latestVersion ?? "1.0.0") >
//                                     Version.parse(currentVersion ?? "2.0.0")))
//                             ? const Badge(child: Icon(Icons.dns_rounded))
//                             : const Icon(Icons.dns_rounded),
//                       ),
//                       Expanded(
//                         child: Text(
//                           AppLocalizations.of(context).optionSettings,
//                           softWrap: false,
//                           overflow: TextOverflow.fade,
//                           style: const TextStyle(fontWeight: FontWeight.w500),
//                         ),
//                       ),
//                       const SizedBox(width: 16),
//                     ],
//                   ),
//                 ),
//               ),
//             ))
//           : const SizedBox.shrink(),
//       (pwa.PWAInstall().installPromptEnabled &&
//               pwa.PWAInstall().launchMode == pwa.LaunchMode.browser)
//           ? (Padding(
//               padding: padding,
//               child: InkWell(
//                 enableFeedback: false,
//                 customBorder: const RoundedRectangleBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(50)),
//                 ),
//                 onTap: () {
//                   selectionHaptic();
//                   if (!desktopLayout(context)) {
//                     Navigator.of(context).pop();
//                   }
//                   pwa.PWAInstall().onAppInstalled = () {
//                     WidgetsBinding.instance.addPostFrameCallback((_) {
//                       pwa.setLaunchModePWA();
//                       setMainAppState!(() {});
//                     });
//                   };
//                   pwa.PWAInstall().promptInstall_();
//                   setState(() {});
//                 },
//                 child: Padding(
//                   padding: const EdgeInsets.only(top: 16, bottom: 16),
//                   child: Row(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(left: 16, right: 12),
//                         child: desktopLayoutNotRequired(context)
//                             ? const Icon(Icons.install_desktop_rounded)
//                             : const Icon(Icons.install_mobile_rounded),
//                       ),
//                       Expanded(
//                         child: Text(
//                           AppLocalizations.of(context).optionInstallPwa,
//                           softWrap: false,
//                           overflow: TextOverflow.fade,
//                           style: const TextStyle(fontWeight: FontWeight.w500),
//                         ),
//                       ),
//                       const SizedBox(width: 16),
//                     ],
//                   ),
//                 ),
//               ),
//             ))
//           : const SizedBox.shrink(),
//       (desktopLayoutNotRequired(context) &&
//               (!allowMultipleChats && !allowSettings))
//           ? const SizedBox.shrink()
//           : Divider(
//               color: desktopLayout(context)
//                   ? Theme.of(context).colorScheme.onSurface.withAlpha(20)
//                   : null,
//             ),
//       ((prefs?.getStringList("chats") ?? []).isNotEmpty)
//           ? const SizedBox.shrink()
//           : (Padding(
//               padding: padding,
//               child: InkWell(
//                 enableFeedback: false,
//                 customBorder: const RoundedRectangleBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(50)),
//                 ),
//                 onTap: selectionHaptic,
//                 child: Padding(
//                   padding: const EdgeInsets.only(top: 16, bottom: 16),
//                   child: Row(
//                     children: [
//                       const Padding(
//                         padding: EdgeInsets.only(left: 16, right: 12),
//                         child: Icon(
//                           Icons.question_mark_rounded,
//                           color: Colors.grey,
//                         ),
//                       ),
//                       Expanded(
//                         child: Text(
//                           AppLocalizations.of(context).optionNoChatFound,
//                           softWrap: false,
//                           overflow: TextOverflow.fade,
//                           style: const TextStyle(
//                             fontWeight: FontWeight.w500,
//                             color: Colors.grey,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 16),
//                     ],
//                   ),
//                 ),
//               ),
//             )),
//       Builder(
//         builder: (context) {
//           var tip = (tipId == 0)
//               ? AppLocalizations.of(context).tip0
//               : (tipId == 1)
//               ? AppLocalizations.of(context).tip1
//               : (tipId == 2)
//               ? AppLocalizations.of(context).tip2
//               : (tipId == 3)
//               ? AppLocalizations.of(context).tip3
//               : AppLocalizations.of(context).tip4;
//           return (!(prefs?.getBool("tips") ?? true) ||
//                   (prefs?.getStringList("chats") ?? []).isNotEmpty ||
//                   !allowSettings)
//               ? const SizedBox.shrink()
//               : (Padding(
//                   padding: padding,
//                   child: InkWell(
//                     splashFactory: NoSplash.splashFactory,
//                     highlightColor: Colors.transparent,
//                     enableFeedback: false,
//                     hoverColor: Colors.transparent,
//                     onTap: () {
//                       selectionHaptic();
//                       var tmpTip = tipId;
//                       while (tmpTip == tipId) {
//                         tipId = Random().nextInt(5);
//                       }
//                       setState(() {});
//                     },
//                     child: Padding(
//                       padding: const EdgeInsets.only(top: 16, bottom: 16),
//                       child: Row(
//                         children: [
//                           const Padding(
//                             padding: EdgeInsets.only(left: 16, right: 12),
//                             child: Icon(
//                               Icons.tips_and_updates_rounded,
//                               color: Colors.grey,
//                             ),
//                           ),
//                           Expanded(
//                             child: Text(
//                               AppLocalizations.of(context).tipPrefix + tip,
//                               softWrap: true,
//                               maxLines: 3,
//                               overflow: TextOverflow.fade,
//                               style: const TextStyle(
//                                 fontWeight: FontWeight.w500,
//                                 color: Colors.grey,
//                               ),
//                             ),
//                           ),
//                           const SizedBox(width: 16),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ));
//         },
//       ),
//     ])..addAll(
//       (prefs?.getStringList("chats") ?? []).map((item) {
//         var child = Padding(
//           padding: padding,
//           child: InkWell(
//             enableFeedback: false,
//             customBorder: const RoundedRectangleBorder(
//               borderRadius: BorderRadius.all(Radius.circular(50)),
//             ),
//             onTap: () {
//               selectionHaptic();
//               if (!desktopLayoutRequired(context)) {
//                 Navigator.of(context).pop();
//               }
//               if (!chatAllowed) return;
//               if (chatUuid == jsonDecode(item)["uuid"]) return;
//               loadChat(jsonDecode(item)["uuid"], setState);
//               chatUuid = jsonDecode(item)["uuid"];
//             },
//             onHover: (value) {
//               setState(() {
//                 if (value) {
//                   hoveredChat = jsonDecode(item)["uuid"];
//                 } else {
//                   hoveredChat = "";
//                 }
//               });
//             },
//             onLongPress:
//                 (desktopFeature() ||
//                     (kIsWeb && desktopLayoutNotRequired(context)))
//                 ? null
//                 : () async {
//                     selectionHaptic();
//                     if (!chatAllowed && chatUuid == jsonDecode(item)["uuid"]) {
//                       return;
//                     }
//                     if (!allowSettings) return;
//                     String oldTitle = jsonDecode(item)["title"];
//                     var newTitle = await prompt(
//                       context,
//                       title: AppLocalizations.of(context).dialogEnterNewTitle,
//                       value: oldTitle,
//                       uuid: jsonDecode(item)["uuid"],
//                     );
//                     var tmp = prefs!.getStringList("chats") ?? [];
//                     for (var i = 0; i < tmp.length; i++) {
//                       if (jsonDecode(
//                             (prefs!.getStringList("chats") ?? [])[i],
//                           )["uuid"] ==
//                           jsonDecode(item)["uuid"]) {
//                         var tmp2 = jsonDecode(tmp[i]);
//                         tmp2["title"] = newTitle;
//                         tmp[i] = jsonEncode(tmp2);
//                         break;
//                       }
//                     }
//                     prefs!.setStringList("chats", tmp);
//                     setState(() {});
//                   },
//             child: Padding(
//               padding: const EdgeInsets.only(top: 16, bottom: 16),
//               child: Row(
//                 children: [
//                   allowMultipleChats
//                       ? Padding(
//                           padding: const EdgeInsets.only(left: 16, right: 16),
//                           child: Icon(
//                             (chatUuid == jsonDecode(item)["uuid"])
//                                 ? Icons.location_on_rounded
//                                 : Icons.restore_rounded,
//                           ),
//                         )
//                       : const SizedBox(width: 16),
//                   Expanded(
//                     child: Text(
//                       jsonDecode(item)["title"],
//                       softWrap: false,
//                       maxLines: 1,
//                       overflow: TextOverflow.fade,
//                       style: const TextStyle(fontWeight: FontWeight.w500),
//                     ),
//                   ),
//                   AnimatedSwitcher(
//                     duration: const Duration(milliseconds: 100),
//                     child:
//                         (((desktopFeature() ||
//                                     (kIsWeb &&
//                                         desktopLayoutNotRequired(context))) &&
//                                 (hoveredChat == jsonDecode(item)["uuid"])) ||
//                             !allowMultipleChats)
//                         ? Padding(
//                             padding: const EdgeInsets.only(left: 16, right: 16),
//                             child: SizedBox(
//                               height: 24,
//                               width: 24,
//                               child: IconButton(
//                                 tooltip: allowMultipleChats
//                                     ? allowSettings
//                                           ? AppLocalizations.of(
//                                               context,
//                                             ).tooltipOptions
//                                           : AppLocalizations.of(
//                                               context,
//                                             ).deleteChat
//                                     : AppLocalizations.of(context).tooltipReset,
//                                 onPressed: () {
//                                   if (!chatAllowed &&
//                                       chatUuid == jsonDecode(item)["uuid"]) {
//                                     return;
//                                   }
//                                   if (!allowMultipleChats) {
//                                     for (
//                                       var i = 0;
//                                       i <
//                                           (prefs!.getStringList("chats") ?? [])
//                                               .length;
//                                       i++
//                                     ) {
//                                       if (jsonDecode(
//                                             (prefs!.getStringList("chats") ??
//                                                 [])[i],
//                                           )["uuid"] ==
//                                           jsonDecode(item)["uuid"]) {
//                                         var tmp = prefs!.getStringList("chats")!
//                                           ..removeAt(i);
//                                         prefs!.setStringList("chats", tmp);
//                                         break;
//                                       }
//                                     }
//                                     messages = [];
//                                     chatUuid = null;
//                                     if (!desktopLayoutRequired(context)) {
//                                       Navigator.of(context).pop();
//                                     }
//                                     setState(() {});
//                                     return;
//                                   }
//                                   if (!allowSettings) {
//                                     showDeleteChatDialog(
//                                       context,
//                                       uuid: jsonDecode(item)["uuid"],
//                                     );
//                                     return;
//                                   }
//                                   if (!desktopLayoutRequired(context)) {
//                                     Navigator.of(context).pop();
//                                   }
//                                   showModalBottomSheet(
//                                     context: context,
//                                     builder: (context) {
//                                       return Container(
//                                         padding: const EdgeInsets.only(
//                                           left: 16,
//                                           right: 16,
//                                           top: 16,
//                                         ),
//                                         child: Column(
//                                           mainAxisSize: MainAxisSize.min,
//                                           children: [
//                                             SizedBox(
//                                               width: double.infinity,
//                                               child: OutlinedButton.icon(
//                                                 onPressed: () {
//                                                   Navigator.of(context).pop();
//                                                   showDeleteChatDialog(
//                                                     context,
//                                                     uuid: jsonDecode(
//                                                       item,
//                                                     )["uuid"],
//                                                     onDelete: () {
//                                                       if (!desktopLayoutRequired(
//                                                         context,
//                                                       )) {
//                                                         Navigator.of(
//                                                           context,
//                                                         ).pop();
//                                                       }
//                                                     },
//                                                   );
//                                                 },
//                                                 icon: const Icon(
//                                                   Icons.delete_forever_rounded,
//                                                 ),
//                                                 label: Text(
//                                                   AppLocalizations.of(
//                                                     context,
//                                                   ).deleteChat,
//                                                 ),
//                                               ),
//                                             ),
//                                             const SizedBox(height: 8),
//                                             SizedBox(
//                                               width: double.infinity,
//                                               child: OutlinedButton.icon(
//                                                 onPressed: () async {
//                                                   Navigator.of(context).pop();
//                                                   String oldTitle = jsonDecode(
//                                                     item,
//                                                   )["title"];
//                                                   var newTitle = await prompt(
//                                                     context,
//                                                     title: AppLocalizations.of(
//                                                       context,
//                                                     ).dialogEnterNewTitle,
//                                                     value: oldTitle,
//                                                     uuid: jsonDecode(
//                                                       item,
//                                                     )["uuid"],
//                                                   );
//                                                   var tmp =
//                                                       prefs!.getStringList(
//                                                         "chats",
//                                                       ) ??
//                                                       [];
//                                                   for (
//                                                     var i = 0;
//                                                     i < tmp.length;
//                                                     i++
//                                                   ) {
//                                                     if (jsonDecode(
//                                                           (prefs!.getStringList(
//                                                                 "chats",
//                                                               ) ??
//                                                               [])[i],
//                                                         )["uuid"] ==
//                                                         jsonDecode(
//                                                           item,
//                                                         )["uuid"]) {
//                                                       var tmp2 = jsonDecode(
//                                                         tmp[i],
//                                                       );
//                                                       tmp2["title"] = newTitle;
//                                                       tmp[i] = jsonEncode(tmp2);
//                                                       break;
//                                                     }
//                                                   }
//                                                   prefs!.setStringList(
//                                                     "chats",
//                                                     tmp,
//                                                   );
//                                                   setState(() {});
//                                                 },
//                                                 icon: const Icon(
//                                                   Icons.edit_rounded,
//                                                 ),
//                                                 label: Text(
//                                                   AppLocalizations.of(
//                                                     context,
//                                                   ).renameChat,
//                                                 ),
//                                               ),
//                                             ),
//                                             const SizedBox(height: 16),
//                                           ],
//                                         ),
//                                       );
//                                     },
//                                   );
//                                 },
//                                 hoverColor: Colors.transparent,
//                                 highlightColor: Colors.transparent,
//                                 icon: Transform.translate(
//                                   offset: const Offset(-8, -8),
//                                   // ignore const suggestion, because values could be not const
//                                   // ignore: prefer_const_constructors
//                                   child: Icon(
//                                     allowMultipleChats
//                                         ? allowSettings
//                                               ? Icons.more_horiz_rounded
//                                               : Icons.close_rounded
//                                         : Icons.restart_alt_rounded,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           )
//                         : const SizedBox(width: 16),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//         return (desktopFeature() ||
//                     (kIsWeb && desktopLayoutNotRequired(context))) ||
//                 !allowMultipleChats
//             ? child
//             : Dismissible(
//                 key: Key(jsonDecode(item)["uuid"]),
//                 direction: chatAllowed
//                     ? DismissDirection.startToEnd
//                     : DismissDirection.none,
//                 confirmDismiss: (direction) async {
//                   if (!chatAllowed && chatUuid == jsonDecode(item)["uuid"]) {
//                     return false;
//                   }
//                   return showDeleteChatDialog(
//                     context,
//                     uuid: jsonDecode(item)["uuid"],
//                   );
//                 },
//                 onDismissed: (direction) {
//                   selectionHaptic();
//                   for (
//                     var i = 0;
//                     i < (prefs!.getStringList("chats") ?? []).length;
//                     i++
//                   ) {
//                     if (jsonDecode(
//                           (prefs!.getStringList("chats") ?? [])[i],
//                         )["uuid"] ==
//                         jsonDecode(item)["uuid"]) {
//                       var tmp = prefs!.getStringList("chats")!..removeAt(i);
//                       prefs!.setStringList("chats", tmp);
//                       break;
//                     }
//                   }
//                   if (chatUuid == jsonDecode(item)["uuid"]) {
//                     messages = [];
//                     chatUuid = null;
//                     if (!desktopLayoutRequired(context)) {
//                       Navigator.of(context).pop();
//                     }
//                   }
//                   setState(() {});
//                 },
//                 child: child,
//               );
//       }).toList(),
//     );
//   }

//   @override
//   void initState() {
//     super.initState();
//     mainContext = context;

//     WidgetsBinding.instance.addPostFrameCallback((_) async {
//       if (prefs == null) {
//         await Future.doWhile(
//           () => Future.delayed(const Duration(milliseconds: 1)).then((_) {
//             return prefs == null;
//           }),
//         );
//       }

//       if (!mounted) return;

//       if (!(allowSettings || useHost)) {
//         showDialog(
//           context: context,
//           builder: (context) {
//             return const PopScope(
//               canPop: false,
//               child: Dialog.fullscreen(
//                 backgroundColor: Colors.black,
//                 child: Padding(
//                   padding: EdgeInsets.all(16),
//                   child: Text(
//                     "*Build Error:*\n\nuseHost: $useHost\nallowSettings: $allowSettings\n\nYou created this build? One of them must be set to true or the app is not functional!\n\nYou received this build by someone else? Please contact them and report the issue.",
//                     style: TextStyle(
//                       color: Colors.red,
//                       fontFamily: "monospace",
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           },
//         );
//       }

//       // prefs!.remove("welcomeFinished");
//       if (!Preferences.welcomeFinished && allowSettings) {
//         Navigator.of(context).pushReplacement(
//           MaterialPageRoute(builder: (context) => const ScreenWelcome()),
//         );
//         return;
//       }

//       if (!allowMultipleChats &&
//           (prefs!.getStringList("chats") ?? []).isNotEmpty) {
//         chatUuid = jsonDecode((prefs!.getStringList("chats") ?? [])[0])["uuid"];
//         loadChat(chatUuid!, setState);
//       }

//       setState(() {
//         model = useModel ? fixedModel : prefs!.getString("model");
//         chatAllowed = !(model == null);
//         multimodal = prefs?.getBool("multimodal") ?? false;
//         host = useHost ? fixedHost : prefs?.getString("host");
//       });

//       if (host == null) {
//         // ignore: use_build_context_synchronously
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             // ignore: use_build_context_synchronously
//             content: Text(AppLocalizations.of(context).noHostSelected),
//             showCloseIcon: true,
//           ),
//         );
//       }

//       setState(() {});
//       if (prefs!.getBool("checkUpdateOnSettingsOpen") ?? true) {
//         updateDetectedOnStart = await checkUpdate(setState);
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     Widget selector = InkWell(
//       onTap: !useModel
//           ? () {
//               if (host == null) {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(
//                     content: Text(AppLocalizations.of(context).noHostSelected),
//                     showCloseIcon: true,
//                   ),
//                 );
//                 return;
//               }
//               setModel(context, setState);
//             }
//           : null,
//       splashFactory: NoSplash.splashFactory,
//       highlightColor: Colors.transparent,
//       enableFeedback: false,
//       hoverColor: Colors.transparent,
//       child: SizedBox(
//         height: 200,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Flexible(
//               child: Text(
//                 (model ?? AppLocalizations.of(context).noSelectedModel).split(
//                   ":",
//                 )[0],
//                 overflow: TextOverflow.fade,
//                 style: const TextStyle(fontFamily: "monospace", fontSize: 16),
//               ),
//             ),
//             useModel
//                 ? const SizedBox.shrink()
//                 : const Icon(Icons.expand_more_rounded),
//           ],
//         ),
//       ),
//     );

//     return WindowBorder(
//       color: Theme.of(context).colorScheme.surface,
//       child: Scaffold(
//         appBar: AppBar(
//           titleSpacing: 0,
//           title: Row(
//             children: desktopFeature()
//                 ? desktopLayoutRequired(context)
//                       ? [
//                           SizedBox(
//                             width: 304,
//                             height: 200,
//                             child: MoveWindow(),
//                           ),
//                           SizedBox(
//                             height: 200,
//                             child: AnimatedOpacity(
//                               opacity: menuVisible ? 1.0 : 0.0,
//                               duration: const Duration(milliseconds: 300),
//                               child: VerticalDivider(
//                                 width: 2,
//                                 color: Theme.of(
//                                   context,
//                                 ).colorScheme.onSurface.withAlpha(20),
//                               ),
//                             ),
//                           ),
//                           AnimatedOpacity(
//                             opacity: desktopTitleVisible ? 1.0 : 0.0,
//                             duration: desktopTitleVisible
//                                 ? const Duration(milliseconds: 300)
//                                 : Duration.zero,
//                             child: Padding(
//                               padding: const EdgeInsets.all(16),
//                               child: selector,
//                             ),
//                           ),
//                           Expanded(
//                             child: SizedBox(height: 200, child: MoveWindow()),
//                           ),
//                         ]
//                       : [
//                           SizedBox(width: 90, height: 200, child: MoveWindow()),
//                           Expanded(
//                             child: SizedBox(height: 200, child: MoveWindow()),
//                           ),
//                           selector,
//                           Expanded(
//                             child: SizedBox(height: 200, child: MoveWindow()),
//                           ),
//                         ]
//                 : desktopLayoutRequired(context)
//                 ? [
//                     // bottom left tile
//                     const SizedBox(width: 304, height: 200),
//                     SizedBox(
//                       height: 200,
//                       child: AnimatedOpacity(
//                         opacity: menuVisible ? 1.0 : 0.0,
//                         duration: const Duration(milliseconds: 300),
//                         child: VerticalDivider(
//                           width: 2,
//                           color: Theme.of(
//                             context,
//                           ).colorScheme.onSurface.withAlpha(20),
//                         ),
//                       ),
//                     ),
//                     AnimatedOpacity(
//                       opacity: desktopTitleVisible ? 1.0 : 0.0,
//                       duration: desktopTitleVisible
//                           ? const Duration(milliseconds: 300)
//                           : Duration.zero,
//                       child: Padding(
//                         padding: const EdgeInsets.all(16),
//                         child: selector,
//                       ),
//                     ),
//                     const Expanded(child: SizedBox(height: 200)),
//                   ]
//                 : [Expanded(child: selector)],
//           ),
//           actions: desktopControlsActions(context, [
//             const SizedBox(width: 4),
//             allowMultipleChats
//                 ? IconButton(
//                     enableFeedback: false,
//                     onPressed: () {
//                       selectionHaptic();
//                       if (!chatAllowed) return;
//                       if (messages.isNotEmpty) showDeleteChatDialog(context);
//                     },
//                     icon: const Icon(Icons.restart_alt_rounded),
//                   )
//                 : const SizedBox.shrink(),
//           ]),
//           bottom: PreferredSize(
//             preferredSize: const Size.fromHeight(1),
//             child: (!chatAllowed && model != null)
//                 ? const LinearProgressIndicator()
//                 : desktopLayout(context)
//                 ? AnimatedOpacity(
//                     opacity: menuVisible ? 1.0 : 0.0,
//                     duration: const Duration(milliseconds: 300),
//                     child: Divider(
//                       height: 2,
//                       color: Theme.of(
//                         context,
//                       ).colorScheme.onSurface.withAlpha(20),
//                     ),
//                   )
//                 : const SizedBox.shrink(),
//           ),
//           automaticallyImplyLeading: !desktopLayoutRequired(context),
//         ),
//         body: Row(
//           children: [
//             desktopLayoutRequired(context)
//                 ? SizedBox(
//                     width: 304,
//                     height: double.infinity,
//                     child: VisibilityDetector(
//                       key: const Key("menuVisible"),
//                       onVisibilityChanged: (VisibilityInfo info) {
//                         if (settingsOpen) return;
//                         menuVisible = info.visibleFraction > 0;
//                         try {
//                           setState(() {});
//                         } catch (_) {}
//                       },
//                       child: AnimatedOpacity(
//                         opacity: menuVisible ? 1.0 : 0.0,
//                         duration: const Duration(milliseconds: 300),
//                         child: ListView(children: sidebar(context, setState)),
//                       ),
//                     ),
//                   )
//                 : const SizedBox.shrink(),
//             desktopLayout(context)
//                 ? AnimatedOpacity(
//                     opacity: menuVisible ? 1.0 : 0.0,
//                     duration: const Duration(milliseconds: 300),
//                     child: VerticalDivider(
//                       width: 2,
//                       color: Theme.of(
//                         context,
//                       ).colorScheme.onSurface.withAlpha(20),
//                     ),
//                   )
//                 : const SizedBox.shrink(),
//             Expanded(
//               child: Center(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisSize: MainAxisSize.max,
//                   children: [
//                     Flexible(
//                       child: Container(
//                         constraints: const BoxConstraints(maxWidth: 1000),
//                         child: chat_ui.Chat(
//                           messages: messages,
//                           key: chatKey,
//                           textMessageBuilder:
//                               (p0, {required messageWidth, required showName}) {
//                                 var white = const TextStyle(
//                                   color: Colors.white,
//                                 );
//                                 var greyed = false;
//                                 var text = p0.text;
//                                 if (text.trim() == "") {
//                                   text =
//                                       "_Empty AI response, try restarting conversation_";
//                                   greyed = true;
//                                 }
//                                 return Padding(
//                                   padding: const EdgeInsets.only(
//                                     left: 20,
//                                     right: 23,
//                                     top: 17,
//                                     bottom: 17,
//                                   ),
//                                   child: Theme(
//                                     data: Theme.of(context).copyWith(
//                                       scrollbarTheme: const ScrollbarThemeData(
//                                         thumbColor: WidgetStatePropertyAll(
//                                           Colors.grey,
//                                         ),
//                                       ),
//                                     ),
//                                     child: MarkdownBody(
//                                       data: text,
//                                       onTapLink: (text, href, title) async {
//                                         selectionHaptic();
//                                         try {
//                                           var url = Uri.parse(href!);
//                                           if (await canLaunchUrl(url)) {
//                                             launchUrl(
//                                               mode: LaunchMode.inAppBrowserView,
//                                               url,
//                                             );
//                                           } else {
//                                             throw Exception();
//                                           }
//                                         } catch (_) {
//                                           // ignore: use_build_context_synchronously
//                                           ScaffoldMessenger.of(
//                                             context,
//                                           ).showSnackBar(
//                                             SnackBar(
//                                               content: Text(
//                                                 AppLocalizations.of(
//                                                   // ignore: use_build_context_synchronously
//                                                   context,
//                                                 ).settingsHostInvalid("url"),
//                                               ),
//                                               showCloseIcon: true,
//                                             ),
//                                           );
//                                         }
//                                       },
//                                       extensionSet: md.ExtensionSet(
//                                         md
//                                             .ExtensionSet
//                                             .gitHubFlavored
//                                             .blockSyntaxes,
//                                         <md.InlineSyntax>[
//                                           md.EmojiSyntax(),
//                                           ...md
//                                               .ExtensionSet
//                                               .gitHubFlavored
//                                               .inlineSyntaxes,
//                                         ],
//                                       ),
//                                       imageBuilder: (uri, title, alt) {
//                                         Widget errorImage = InkWell(
//                                           onTap: () {
//                                             selectionHaptic();
//                                             ScaffoldMessenger.of(
//                                               context,
//                                             ).showSnackBar(
//                                               SnackBar(
//                                                 content: Text(
//                                                   AppLocalizations.of(
//                                                     context,
//                                                   ).notAValidImage,
//                                                 ),
//                                                 showCloseIcon: true,
//                                               ),
//                                             );
//                                           },
//                                           child: Container(
//                                             decoration: BoxDecoration(
//                                               borderRadius:
//                                                   BorderRadius.circular(8),
//                                               color:
//                                                   Theme.of(
//                                                         context,
//                                                       ).brightness ==
//                                                       Brightness.light
//                                                   ? Colors.white
//                                                   : Colors.black,
//                                             ),
//                                             padding: const EdgeInsets.only(
//                                               left: 100,
//                                               right: 100,
//                                               top: 32,
//                                             ),
//                                             child: const Image(
//                                               image: AssetImage(
//                                                 "assets/logo512error.png",
//                                               ),
//                                             ),
//                                           ),
//                                         );
//                                         if (uri.isAbsolute) {
//                                           return Image.network(
//                                             uri.toString(),
//                                             errorBuilder:
//                                                 (context, error, stackTrace) {
//                                                   return errorImage;
//                                                 },
//                                           );
//                                         } else {
//                                           return errorImage;
//                                         }
//                                       },
//                                       styleSheet: (p0.author == user)
//                                           ? MarkdownStyleSheet(
//                                               p: const TextStyle(
//                                                 color: Colors.white,
//                                                 fontSize: 16,
//                                                 fontWeight: FontWeight.w500,
//                                               ),
//                                               blockquoteDecoration:
//                                                   BoxDecoration(
//                                                     color: Colors.grey[800],
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                           8,
//                                                         ),
//                                                   ),
//                                               code: const TextStyle(
//                                                 color: Colors.black,
//                                                 backgroundColor: Colors.white,
//                                               ),
//                                               codeblockDecoration:
//                                                   BoxDecoration(
//                                                     color: Colors.white,
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                           8,
//                                                         ),
//                                                   ),
//                                               h1: white,
//                                               h2: white,
//                                               h3: white,
//                                               h4: white,
//                                               h5: white,
//                                               h6: white,
//                                               listBullet: white,
//                                               horizontalRuleDecoration:
//                                                   BoxDecoration(
//                                                     border: Border(
//                                                       top: BorderSide(
//                                                         color:
//                                                             Colors.grey[800]!,
//                                                         width: 1,
//                                                       ),
//                                                     ),
//                                                   ),
//                                               tableBorder: TableBorder.all(
//                                                 color: Colors.white,
//                                               ),
//                                               tableBody: white,
//                                             )
//                                           : (Theme.of(context).brightness ==
//                                                 Brightness.light)
//                                           ? MarkdownStyleSheet(
//                                               p: TextStyle(
//                                                 color: greyed
//                                                     ? Colors.grey
//                                                     : Colors.black,
//                                                 fontSize: 16,
//                                                 fontWeight: FontWeight.w500,
//                                               ),
//                                               blockquoteDecoration:
//                                                   BoxDecoration(
//                                                     color: Colors.grey[200],
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                           8,
//                                                         ),
//                                                   ),
//                                               code: const TextStyle(
//                                                 color: Colors.white,
//                                                 backgroundColor: Colors.black,
//                                               ),
//                                               codeblockDecoration:
//                                                   BoxDecoration(
//                                                     color: Colors.black,
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                           8,
//                                                         ),
//                                                   ),
//                                               horizontalRuleDecoration:
//                                                   BoxDecoration(
//                                                     border: Border(
//                                                       top: BorderSide(
//                                                         color:
//                                                             Colors.grey[200]!,
//                                                         width: 1,
//                                                       ),
//                                                     ),
//                                                   ),
//                                             )
//                                           : MarkdownStyleSheet(
//                                               p: const TextStyle(
//                                                 color: Colors.white,
//                                                 fontSize: 16,
//                                                 fontWeight: FontWeight.w500,
//                                               ),
//                                               blockquoteDecoration:
//                                                   BoxDecoration(
//                                                     color: Colors.grey[800]!,
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                           8,
//                                                         ),
//                                                   ),
//                                               code: const TextStyle(
//                                                 color: Colors.black,
//                                                 backgroundColor: Colors.white,
//                                               ),
//                                               codeblockDecoration:
//                                                   BoxDecoration(
//                                                     color: Colors.white,
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                           8,
//                                                         ),
//                                                   ),
//                                               horizontalRuleDecoration:
//                                                   BoxDecoration(
//                                                     border: Border(
//                                                       top: BorderSide(
//                                                         color:
//                                                             Colors.grey[200]!,
//                                                         width: 1,
//                                                       ),
//                                                     ),
//                                                   ),
//                                             ),
//                                     ),
//                                   ),
//                                 );
//                               },
//                           imageMessageBuilder: (p0, {required messageWidth}) {
//                             return SizedBox(
//                               width: desktopLayout(context) ? 360.0 : 160.0,
//                               child: MarkdownBody(
//                                 data: "![${p0.name}](${p0.uri})",
//                               ),
//                             );
//                           },
//                           disableImageGallery: true,
//                           emptyState: Center(
//                             child: VisibilityDetector(
//                               key: const Key("logoVisible"),
//                               onVisibilityChanged: (VisibilityInfo info) {
//                                 if (settingsOpen) return;
//                                 logoVisible = info.visibleFraction > 0;
//                                 try {
//                                   setState(() {});
//                                 } catch (_) {}
//                               },
//                               child: AnimatedOpacity(
//                                 opacity: logoVisible ? 1.0 : 0.0,
//                                 duration: const Duration(milliseconds: 500),
//                                 child: const ImageIcon(
//                                   AssetImage("assets/logo512.png"),
//                                   size: 44,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           onSendPressed: (p0) {
//                             send(p0.text, context, setState);
//                           },
//                           onMessageDoubleTap: (context, p1) {
//                             selectionHaptic();
//                             if (!chatAllowed) return;
//                             if (p1.author == assistant) return;
//                             for (var i = 0; i < messages.length; i++) {
//                               if (messages[i].id == p1.id) {
//                                 var messageList =
//                                     (jsonDecode(jsonEncode(messages)) as List)
//                                         .reversed
//                                         .toList();
//                                 var found = false;
//                                 var index = [];
//                                 for (var j = 0; j < messageList.length; j++) {
//                                   if (messageList[j]["id"] == p1.id) {
//                                     found = true;
//                                   }
//                                   if (found) {
//                                     index.add(messageList[j]["id"]);
//                                   }
//                                 }
//                                 for (var j = 0; j < index.length; j++) {
//                                   for (var k = 0; k < messages.length; k++) {
//                                     if (messages[k].id == index[j]) {
//                                       messages.removeAt(k);
//                                     }
//                                   }
//                                 }
//                                 break;
//                               }
//                             }
//                             saveChat(chatUuid!, setState);
//                             setState(() {});
//                           },
//                           onMessageLongPress: (context, p1) async {
//                             selectionHaptic();

//                             if (!(prefs!.getBool("enableEditing") ?? true)) {
//                               return;
//                             }

//                             var index = -1;
//                             if (!chatAllowed) return;
//                             for (var i = 0; i < messages.length; i++) {
//                               if (messages[i].id == p1.id) {
//                                 index = i;
//                                 break;
//                               }
//                             }

//                             var text =
//                                 (messages[index] as types.TextMessage).text;
//                             var input = await prompt(
//                               context,
//                               title: AppLocalizations.of(
//                                 context,
//                               ).dialogEditMessageTitle,
//                               value: text,
//                               keyboard: TextInputType.multiline,
//                               maxLines: (text.length >= 100)
//                                   ? 10
//                                   : ((text.length >= 50) ? 5 : 3),
//                             );
//                             if (input == "") return;

//                             messages[index] = types.TextMessage(
//                               author: p1.author,
//                               createdAt: p1.createdAt,
//                               id: p1.id,
//                               text: input,
//                             );
//                             setState(() {});
//                           },
//                           onAttachmentPressed: (!multimodal)
//                               ? (prefs?.getBool("voiceModeEnabled") ?? false)
//                                     ? (model != null)
//                                           ? () {
//                                               selectionHaptic();
//                                               setGlobalState = setState;
//                                               settingsOpen = true;
//                                               logoVisible = false;
//                                               Navigator.of(context).push(
//                                                 MaterialPageRoute(
//                                                   builder: (context) =>
//                                                       const ScreenVoice(),
//                                                 ),
//                                               );
//                                             }
//                                           : null
//                                     : null
//                               : () {
//                                   selectionHaptic();
//                                   if (!chatAllowed || model == null) {
//                                     return;
//                                   }
//                                   if (desktopFeature()) {
//                                     FilePicker.platform
//                                         .pickFiles(type: FileType.image)
//                                         .then((value) async {
//                                           if (value == null) return;
//                                           if (!multimodal) return;

//                                           var encoded = base64.encode(
//                                             await File(
//                                               value.files.first.path!,
//                                             ).readAsBytes(),
//                                           );
//                                           messages.insert(
//                                             0,
//                                             types.ImageMessage(
//                                               author: user,
//                                               id: const Uuid().v4(),
//                                               name: value.files.first.name,
//                                               size: value.files.first.size,
//                                               uri:
//                                                   "data:image/png;base64,$encoded",
//                                             ),
//                                           );

//                                           setState(() {});
//                                         });

//                                     return;
//                                   }
//                                   showModalBottomSheet(
//                                     context: context,
//                                     builder: (context) {
//                                       return Container(
//                                         width: double.infinity,
//                                         padding: const EdgeInsets.only(
//                                           left: 16,
//                                           right: 16,
//                                           top: 16,
//                                         ),
//                                         child: Column(
//                                           mainAxisSize: MainAxisSize.min,
//                                           children: [
//                                             (prefs?.getBool(
//                                                       "voiceModeEnabled",
//                                                     ) ??
//                                                     false)
//                                                 ? SizedBox(
//                                                     width: double.infinity,
//                                                     child: OutlinedButton.icon(
//                                                       onPressed: () async {
//                                                         selectionHaptic();
//                                                         Navigator.of(
//                                                           context,
//                                                         ).pop();
//                                                         setGlobalState =
//                                                             setState;
//                                                         settingsOpen = true;
//                                                         logoVisible = false;
//                                                         Navigator.of(
//                                                           context,
//                                                         ).push(
//                                                           MaterialPageRoute(
//                                                             builder: (context) =>
//                                                                 const ScreenVoice(),
//                                                           ),
//                                                         );
//                                                       },
//                                                       icon: const Icon(
//                                                         Icons
//                                                             .headphones_rounded,
//                                                       ),
//                                                       label: Text(
//                                                         AppLocalizations.of(
//                                                           context,
//                                                         ).settingsTitleVoice,
//                                                       ),
//                                                     ),
//                                                   )
//                                                 : const SizedBox.shrink(),
//                                             (prefs?.getBool(
//                                                       "voiceModeEnabled",
//                                                     ) ??
//                                                     false)
//                                                 ? const SizedBox(height: 8)
//                                                 : const SizedBox.shrink(),
//                                             SizedBox(
//                                               width: double.infinity,
//                                               child: OutlinedButton.icon(
//                                                 onPressed: () async {
//                                                   selectionHaptic();

//                                                   Navigator.of(context).pop();
//                                                   var result =
//                                                       await ImagePicker()
//                                                           .pickImage(
//                                                             source: ImageSource
//                                                                 .camera,
//                                                           );
//                                                   if (result == null) {
//                                                     return;
//                                                   }

//                                                   var bytes = await result
//                                                       .readAsBytes();
//                                                   var image =
//                                                       await decodeImageFromList(
//                                                         bytes,
//                                                       );

//                                                   var message = types.ImageMessage(
//                                                     author: user,
//                                                     createdAt: DateTime.now()
//                                                         .millisecondsSinceEpoch,
//                                                     height: image.height
//                                                         .toDouble(),
//                                                     id: const Uuid().v4(),
//                                                     name: result.name,
//                                                     size: bytes.length,
//                                                     uri: result.path,
//                                                     width: image.width
//                                                         .toDouble(),
//                                                   );

//                                                   messages.insert(0, message);
//                                                   setState(() {});
//                                                   selectionHaptic();
//                                                 },
//                                                 icon: const Icon(
//                                                   Icons.photo_camera_rounded,
//                                                 ),
//                                                 label: Text(
//                                                   AppLocalizations.of(
//                                                     context,
//                                                   ).takeImage,
//                                                 ),
//                                               ),
//                                             ),
//                                             const SizedBox(height: 8),
//                                             SizedBox(
//                                               width: double.infinity,
//                                               child: OutlinedButton.icon(
//                                                 onPressed: () async {
//                                                   selectionHaptic();

//                                                   Navigator.of(context).pop();
//                                                   var result =
//                                                       await ImagePicker()
//                                                           .pickImage(
//                                                             source: ImageSource
//                                                                 .gallery,
//                                                           );
//                                                   if (result == null) {
//                                                     return;
//                                                   }

//                                                   var bytes = await result
//                                                       .readAsBytes();
//                                                   var image =
//                                                       await decodeImageFromList(
//                                                         bytes,
//                                                       );

//                                                   var message = types.ImageMessage(
//                                                     author: user,
//                                                     createdAt: DateTime.now()
//                                                         .millisecondsSinceEpoch,
//                                                     height: image.height
//                                                         .toDouble(),
//                                                     id: const Uuid().v4(),
//                                                     name: result.name,
//                                                     size: bytes.length,
//                                                     uri: result.path,
//                                                     width: image.width
//                                                         .toDouble(),
//                                                   );

//                                                   messages.insert(0, message);
//                                                   setState(() {});
//                                                   selectionHaptic();
//                                                 },
//                                                 icon: const Icon(
//                                                   Icons.image_rounded,
//                                                 ),
//                                                 label: Text(
//                                                   AppLocalizations.of(
//                                                     context,
//                                                   ).uploadImage,
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       );
//                                     },
//                                   );
//                                 },
//                           l10n: chat_ui.ChatL10nEn(
//                             inputPlaceholder: AppLocalizations.of(
//                               context,
//                             ).messageInputPlaceholder,
//                             attachmentButtonAccessibilityLabel:
//                                 AppLocalizations.of(context).tooltipAttachment,
//                             sendButtonAccessibilityLabel: AppLocalizations.of(
//                               context,
//                             ).tooltipSend,
//                           ),
//                           inputOptions: chat_ui.InputOptions(
//                             keyboardType: TextInputType.multiline,
//                             onTextChanged: (p0) {
//                               setState(() {
//                                 sendable = p0.trim().isNotEmpty;
//                               });
//                             },
//                             sendButtonVisibilityMode: desktopFeature()
//                                 ? chat_ui.SendButtonVisibilityMode.always
//                                 : sendable
//                                 ? chat_ui.SendButtonVisibilityMode.always
//                                 : chat_ui.SendButtonVisibilityMode.hidden,
//                           ),
//                           user: user,
//                           hideBackgroundOnEmojiMessages: false,
//                           theme:
//                               (Theme.of(context).brightness == Brightness.light)
//                               ? chat_ui.DefaultChatTheme(
//                                   backgroundColor:
//                                       themeLight().colorScheme.surface,
//                                   primaryColor:
//                                       themeLight().colorScheme.primary,
//                                   attachmentButtonIcon: !multimodal
//                                       ? (prefs?.getBool("voiceModeEnabled") ??
//                                                 false)
//                                             ? Icon(
//                                                 Icons.headphones_rounded,
//                                                 color: Theme.of(
//                                                   context,
//                                                 ).iconTheme.color,
//                                               )
//                                             : null
//                                       : Icon(
//                                           Icons.add_a_photo_rounded,
//                                           color: Theme.of(
//                                             context,
//                                           ).iconTheme.color,
//                                         ),
//                                   sendButtonIcon: SizedBox(
//                                     height: 24,
//                                     child: CircleAvatar(
//                                       backgroundColor: Theme.of(
//                                         context,
//                                       ).iconTheme.color,
//                                       radius: 12,
//                                       child: Icon(
//                                         Icons.arrow_upward_rounded,
//                                         color:
//                                             (prefs?.getBool("useDeviceTheme") ??
//                                                 false)
//                                             ? Theme.of(
//                                                 context,
//                                               ).colorScheme.surface
//                                             : null,
//                                       ),
//                                     ),
//                                   ),
//                                   sendButtonMargin: EdgeInsets.zero,
//                                   attachmentButtonMargin: EdgeInsets.zero,
//                                   inputBackgroundColor: themeLight()
//                                       .colorScheme
//                                       .onSurface
//                                       .withAlpha(10),
//                                   inputTextColor:
//                                       themeLight().colorScheme.onSurface,
//                                   inputBorderRadius: BorderRadius.circular(32),
//                                   inputPadding: const EdgeInsets.all(16),
//                                   inputMargin: EdgeInsets.only(
//                                     left: !desktopFeature(web: true) ? 8 : 6,
//                                     right: !desktopFeature(web: true) ? 8 : 6,
//                                     bottom:
//                                         (MediaQuery.of(
//                                                   context,
//                                                 ).viewInsets.bottom ==
//                                                 0.0 &&
//                                             !desktopFeature(web: true))
//                                         ? 0
//                                         : 8,
//                                   ),
//                                   messageMaxWidth:
//                                       (MediaQuery.of(context).size.width >=
//                                           1000)
//                                       ? (MediaQuery.of(context).size.width >=
//                                                 1600)
//                                             ? (MediaQuery.of(
//                                                         context,
//                                                       ).size.width >=
//                                                       2200)
//                                                   ? 1900
//                                                   : 1300
//                                             : 700
//                                       : 440,
//                                 )
//                               : chat_ui.DarkChatTheme(
//                                   backgroundColor:
//                                       themeDark().colorScheme.surface,
//                                   primaryColor: themeDark().colorScheme.primary
//                                       .withAlpha(40),
//                                   secondaryColor: themeDark()
//                                       .colorScheme
//                                       .primary
//                                       .withAlpha(20),
//                                   attachmentButtonIcon: !multimodal
//                                       ? (prefs?.getBool("voiceModeEnabled") ??
//                                                 false)
//                                             ? Icon(
//                                                 Icons.headphones_rounded,
//                                                 color: Theme.of(
//                                                   context,
//                                                 ).iconTheme.color,
//                                               )
//                                             : null
//                                       : Icon(
//                                           Icons.add_a_photo_rounded,
//                                           color: Theme.of(
//                                             context,
//                                           ).iconTheme.color,
//                                         ),
//                                   sendButtonIcon: SizedBox(
//                                     height: 24,
//                                     child: CircleAvatar(
//                                       backgroundColor: Theme.of(
//                                         context,
//                                       ).iconTheme.color,
//                                       radius: 12,
//                                       child: Icon(
//                                         Icons.arrow_upward_rounded,
//                                         color:
//                                             (prefs?.getBool("useDeviceTheme") ??
//                                                 false)
//                                             ? Theme.of(
//                                                 context,
//                                               ).colorScheme.surface
//                                             : null,
//                                       ),
//                                     ),
//                                   ),
//                                   sendButtonMargin: EdgeInsets.zero,
//                                   attachmentButtonMargin: EdgeInsets.zero,
//                                   inputBackgroundColor: themeDark()
//                                       .colorScheme
//                                       .onSurface
//                                       .withAlpha(40),
//                                   inputTextColor:
//                                       themeDark().colorScheme.onSurface,
//                                   inputBorderRadius: BorderRadius.circular(32),
//                                   inputPadding: const EdgeInsets.all(16),
//                                   inputMargin: EdgeInsets.only(
//                                     left: !desktopFeature(web: true) ? 8 : 6,
//                                     right: !desktopFeature(web: true) ? 8 : 6,
//                                     bottom:
//                                         (MediaQuery.of(
//                                                   context,
//                                                 ).viewInsets.bottom ==
//                                                 0.0 &&
//                                             !desktopFeature(web: true))
//                                         ? 0
//                                         : 8,
//                                   ),
//                                   messageMaxWidth:
//                                       (MediaQuery.of(context).size.width >=
//                                           1000)
//                                       ? (MediaQuery.of(context).size.width >=
//                                                 1600)
//                                             ? (MediaQuery.of(
//                                                         context,
//                                                       ).size.width >=
//                                                       2200)
//                                                   ? 1900
//                                                   : 1300
//                                             : 700
//                                       : 440,
//                                 ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//         drawer: Builder(
//           builder: (context) {
//             if (desktopLayoutRequired(context) && !settingsOpen) {
//               WidgetsBinding.instance.addPostFrameCallback((_) {
//                 if (Navigator.of(context).canPop()) {
//                   Navigator.of(context).pop();
//                 }
//               });
//             }
//             return NavigationDrawer(
//               onDestinationSelected: (value) {
//                 if (value == 1) {
//                 } else if (value == 2) {}
//               },
//               selectedIndex: 1,
//               children: sidebar(context, setState),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

@RoutePage()
class ScreenMain extends StatefulWidget {
  const ScreenMain({super.key});

  @override
  State<ScreenMain> createState() => _ScreenMainState();
}

class _ScreenMainState extends State<ScreenMain>
    with SingleTickerProviderStateMixin {
  bool _thirdPaneOpen = false;

  bool isSettingsRoute = false;
  late final bool startedAtSettingsRoute;
  PageController? _sidebarController;

  final FocusNode _searchBarFocusNode = FocusNode();
  final TextEditingController _searchBarController = TextEditingController();

  late final AnimationController _searchBarFocusController;
  late final CurvedAnimation _searchBarFocusCurved;

  final _modelSelectorKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    setIsSettingsRoute();
    startedAtSettingsRoute = isSettingsRoute;

    ChatManager.instance.addListener(onUpdate);
    ModelManager.instance.addListener(onUpdate);
    HostManager.instance.addListener(onUpdate);

    if (HostManager.instance.host != null) {
      errorGuard(
        context,
        "Q3L4Z1X6",
        () async => ModelManager.instance.loadModels(),
        errorMessage: errorGuardErrorMessageWithFallbackSingle(
          llama.OllamaException,
          "Unable to load models",
        ),
        enableReporting: false,
      );
    }

    _searchBarFocusController = AnimationController(
      vsync: this,
      duration: ExpressiveCurves.expressiveSpatial.fastDuration,
      reverseDuration: ExpressiveCurves.expressiveSpatial.fastDuration,
    );
    _searchBarFocusCurved = CurvedAnimation(
      parent: _searchBarFocusController,
      curve: ExpressiveCurves.expressiveSpatial.fast,
      reverseCurve: ExpressiveCurves.expressiveSpatial.fast.flipped,
    );

    _searchBarFocusNode.addListener(() {
      if (!mounted) return;
      if (_searchBarFocusNode.hasFocus) {
        _searchBarFocusController.forward();
      } else {
        _searchBarFocusController.reverse();
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    ChatManager.instance.removeListener(onUpdate);
    ModelManager.instance.removeListener(onUpdate);
    HostManager.instance.removeListener(onUpdate);

    _searchBarFocusNode.dispose();
    _searchBarController.dispose();
    _searchBarFocusCurved.dispose();
    _searchBarFocusController.dispose();
    _sidebarController?.dispose();

    super.dispose();
  }

  void onUpdate() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) setState(() {});
    });
  }

  void setIsSettingsRoute() {
    isSettingsRoute = context.router.currentPath.contains("/settings");

    var page = isSettingsRoute ? 1 : 0;
    if (_sidebarController != null && _sidebarController!.hasClients) {
      if (startedAtSettingsRoute) page = page == 0 ? 1 : 0;
      _sidebarController!.animateToPage(
        page,
        duration: ExpressiveCurves.expressiveEffects.slowDuration,
        curve: ExpressiveCurves.expressiveEffects.slow,
      );
    } else {
      _sidebarController = PageController(initialPage: 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final appLocalizations = AppLocalizations.of(context);

    final adaptedSurface = adaptedSurfaceFromColorScheme(colorScheme);
    final adaptedOnSurface = adaptedOnSurfaceFromColorScheme(colorScheme);
    final breakpoint = Breakpoint.of(context);

    final chatsSearched = ChatManager.instance.chats.where((chat) {
      final searchTerm = _searchBarController.text.toLowerCase();
      return chat.title.toLowerCase().contains(searchTerm) ||
          chat.messages.any(
            (message) =>
                message is TextMessage &&
                message.content.toLowerCase().contains(searchTerm),
          );
    }).toList();

    if (breakpoint != Breakpoint.extraLarge) _thirdPaneOpen = false;
    final embeddedNavigation = breakpoint.panesRecommended >= 2;

    final navigationRail = Transform.translate(
      offset: const Offset(0, -8),
      child: _ScreenMainNavigationBarWide(
        adaptedSurface: adaptedSurface,
        isSettingsRoute: isSettingsRoute,
        onDestinationSelected: () {
          setIsSettingsRoute();
          if (mounted) setState(() {});
        },
      ),
    );

    final children = [
      AnimatedSwitcher(
        duration: ExpressiveCurves.expressiveSpatial.normalDuration,
        switchInCurve: ExpressiveCurves.expressiveSpatial.normal,
        switchOutCurve: ExpressiveCurves.expressiveSpatial.normal.flipped,
        transitionBuilder: (child, animation) => SizeTransition(
          sizeFactor: animation,
          axis: Axis.horizontal,
          alignment: const AlignmentDirectional(0.75, 0.5),
          child: child,
        ),
        child: embeddedNavigation
            ? navigationRail
            : SizedBox(width: breakpoint.spacing),
      ),
      AnimatedContainer(
        duration: ExpressiveCurves.standardSpatial.fastDuration,
        curve: ExpressiveCurves.standardEffects.fast,
        padding: breakpoint.panesRecommended >= 2
            ? EdgeInsetsDirectional.only(end: breakpoint.spacing)
            : EdgeInsetsDirectional.zero,
        child: AnimatedSwitcher(
          duration: ExpressiveCurves.expressiveSpatial.normalDuration,
          switchInCurve: ExpressiveCurves.expressiveSpatial.normal,
          switchOutCurve: ExpressiveCurves.expressiveSpatial.normal.flipped,
          transitionBuilder: (child, animation) => SizeTransition(
            sizeFactor: animation,
            axis: Axis.horizontal,
            alignment: const AlignmentDirectional(0.25, 0.5),
            child: child,
          ),
          child: breakpoint.panesRecommended >= 2
              ? Builder(
                  builder: (context) {
                    final children = [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(56 * (2 / 3)),
                        ),
                        child: chatsSearched.isEmpty
                            ? Padding(
                                padding: EdgeInsetsGeometry.only(
                                  top: 64,
                                  bottom: breakpoint.spacing,
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(24),
                                    child: Text(
                                      _searchBarController.text.isEmpty
                                          ? appLocalizations.optionNoChatFound
                                          : appLocalizations
                                                .optionNoChatFoundSearch(
                                                  _searchBarController.text,
                                                ),
                                      style: textTheme.labelLarge!.copyWith(
                                        color: colorScheme.outline,
                                      ),
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              )
                            : ListView.builder(
                                padding: EdgeInsetsGeometry.only(
                                  top: 64,
                                  bottom: breakpoint.spacing,
                                ),
                                itemBuilder: (context, index) {
                                  final chat = chatsSearched.elementAtOrNull(
                                    index,
                                  );
                                  if (chat == null) return null;
                                  return ListTile(
                                    title: Text(chat.title),
                                    trailing: IconButton(
                                      onPressed: () =>
                                          ChatManager.instance.deleteChat(chat),
                                      icon: const Icon(Icons.delete_outline),
                                    ),
                                  );
                                },
                              ),
                      ),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              adaptedSurface,
                              adaptedSurface.withAlpha(0),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: const [0.25, 1.0],
                          ),
                        ),
                        child: const SizedBox(
                          width: double.infinity,
                          height: 56,
                        ),
                      ),
                      AnimatedBuilder(
                        animation: _searchBarFocusCurved,
                        builder: (context, child) => LayoutBuilder(
                          builder: (context, constraints) {
                            final padding = lerpDouble(
                              12.0,
                              0.0,
                              _searchBarFocusCurved.value,
                            )!;
                            return OverflowBox(
                              maxWidth: double.infinity,
                              alignment: AlignmentGeometry.topCenter,
                              child: SizedBox(
                                width: constraints.maxWidth - padding * 2,
                                child: child,
                              ),
                            );
                          },
                        ),
                        child: SearchBar(
                          hintText: appLocalizations.optionSearchChats,
                          leading: TwoStateWidget(
                            animation: _searchBarFocusCurved,
                            from: IconButton(
                              onPressed: null,
                              disabledColor: IconTheme.of(context).color,
                              icon: const Icon(Icons.search),
                            ),
                            to: IconButton(
                              onPressed: () {
                                _searchBarFocusNode.unfocus();
                                onUpdate();
                              },
                              icon: const Icon(Icons.chevron_left),
                            ),
                          ),
                          elevation: WidgetStateProperty.all(0),
                          focusNode: _searchBarFocusNode,
                          controller: _searchBarController,
                          onChanged: (value) => onUpdate(),
                        ),
                      ),
                    ];

                    var pageViewChildren = [
                      Stack(children: children),
                      const SettingsOptions(embeddedNavigation: true),
                    ];
                    if (startedAtSettingsRoute) {
                      pageViewChildren = pageViewChildren.reversed.toList();
                    }

                    return SizedBox(
                      width: breakpoint.panesFixedWidth,
                      child: PageView(
                        controller: _sidebarController,
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        children: pageViewChildren,
                      ),
                    );
                  },
                )
              : null,
        ),
      ),
      Expanded(
        child: Builder(
          builder: (context) {
            const radius = BorderRadius.vertical(top: Radius.circular(12));
            final border = BorderSide(
              width: 2,
              color: colorScheme.surfaceContainerHigh,
            );

            return AnimatedContainer(
              duration: ExpressiveCurves.standardSpatial.fastDuration,
              curve: ExpressiveCurves.standardEffects.fast,
              decoration: breakpoint.panesRecommended >= 2
                  ? BoxDecoration(
                      borderRadius: radius,
                      border: Border(top: border, left: border, right: border),
                    )
                  : const BoxDecoration(),
              child: const ClipRRect(borderRadius: radius, child: AutoRouter()),
            );
          },
        ),
      ),
      AnimatedContainer(
        duration: ExpressiveCurves.standardSpatial.fastDuration,
        curve: ExpressiveCurves.standardEffects.fast,
        padding: breakpoint.panes.contains(3) && _thirdPaneOpen
            ? EdgeInsetsDirectional.only(start: breakpoint.spacing)
            : EdgeInsetsDirectional.zero,
        child: Card.filled(
          margin: EdgeInsets.zero,
          color: adaptedOnSurface,
          child: AnimatedSwitcher(
            duration: ExpressiveCurves.expressiveSpatial.normalDuration,
            switchInCurve: ExpressiveCurves.expressiveSpatial.normal,
            switchOutCurve: ExpressiveCurves.expressiveSpatial.normal.flipped,
            transitionBuilder: (child, animation) => SizeTransition(
              sizeFactor: animation,
              axis: Axis.horizontal,
              alignment: const AlignmentDirectional(0.25, 0.5),
              child: child,
            ),
            child: breakpoint.panes.contains(3) && _thirdPaneOpen
                ? SizedBox(
                    width: breakpoint.panesThirdFixedWidth,
                    child: ChatDetails(
                      onClose: () {
                        _thirdPaneOpen = false;
                        if (mounted) setState(() {});
                      },
                    ),
                  )
                : null,
          ),
        ),
      ),
      SizedBox(width: breakpoint.spacing),
    ];

    final modelSelectorAnimationDuration =
        ExpressiveCurves.standardEffects.fastDuration;
    final modelSelectorAnimationCurve = ExpressiveCurves.standardEffects.fast;

    final modelHostSelected = HostManager.instance.host != null;
    final modelSelector = GestureDetector(
      key: _modelSelectorKey,
      onTap: !modelHostSelected
          ? null
          : () {
              showModelSelector(context: context, anchorKey: _modelSelectorKey);
            },
      child: Opacity(
        opacity: !modelHostSelected ? kDisabledOpacity : 1.0,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text.rich(
              TextSpan(
                children:
                    Model.nameColoredStatic(
                      name: ModelManager.instance.currentModelName,
                      context: context,
                    ) ??
                    [TextSpan(text: appLocalizations.noSelectedModel)],
              ),
              style: textTheme.titleMedium!.copyWith(
                fontFamily: "GoogleSansCode",
              ),
            ),
            SizedBox(width: breakpoint.spacing / 8),
            const Icon(Icons.keyboard_arrow_down),
          ],
        ),
      ),
    );
    final modelSelectorShowSubtitle = breakpoint.panesRecommended >= 2;
    final modelSelectorOffset = modelSelectorShowSubtitle
        ? 80.0 +
              (breakpoint.panesFixedWidth ?? 0) +
              breakpoint.spacing -
              NavigationToolbar.kMiddleSpacing -
              kToolbarHeight
        : 0.0;

    return Scaffold(
      backgroundColor: adaptedSurface,
      endDrawer: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerLow,
            borderRadius: const BorderRadiusDirectional.only(
              topStart: Radius.circular(16),
              bottomStart: Radius.circular(16),
            ),
          ),
          child: ChatDetails(
            onClose: () {
              if (Navigator.of(context).canPop()) {
                Navigator.of(context).pop();
              }
            },
          ),
        ),
      ),
      appBar: AppBar(
        clipBehavior: Clip.none,
        leading: TwoStateWidgetManaged(
          state: breakpoint.panesRecommended >= 2,
          dimension: kToolbarHeight,
          from: const DrawerBackButton(),
          to: Transform.translate(
            offset: const Offset(12, 2),
            child: const Padding(
              padding: EdgeInsetsGeometry.only(top: 8),
              child: ImageIcon(kImageLogo),
            ),
          ),
        ),
        actions: [
          TwoStateWidgetManaged(
            state: isSettingsRoute,
            from: SizedBox.square(
              dimension: kToolbarHeight,
              child: Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.info_outline),
                  tooltip: appLocalizations.optionChatDetails,
                  onPressed: () {
                    if (breakpoint.panes.contains(3)) {
                      _thirdPaneOpen = !_thirdPaneOpen;
                      if (mounted) setState(() {});
                    } else {
                      Scaffold.of(context).openEndDrawer();
                    }
                  },
                ),
              ),
            ),
          ),
        ],
        title: SizedBox(
          width: double.infinity,
          height: theme.appBarTheme.toolbarHeight ?? kToolbarHeight,
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              AnimatedPositionedDirectional(
                key: const ValueKey("modelSelectorSubtitle"),
                duration: modelSelectorAnimationDuration,
                curve: modelSelectorAnimationCurve,
                start: modelSelectorShowSubtitle ? modelSelectorOffset : 64,
                child: AnimatedSlide(
                  offset: Offset(
                    0,
                    modelHostSelected || !modelSelectorShowSubtitle ? 0 : 0.7,
                  ),
                  duration: modelSelectorAnimationDuration,
                  curve: modelSelectorAnimationCurve,
                  child: IgnorePointer(
                    child: AnimatedOpacity(
                      opacity: modelHostSelected || !modelSelectorShowSubtitle
                          ? 0
                          : 1,
                      duration: modelSelectorAnimationDuration,
                      curve: modelSelectorAnimationCurve,
                      child: Text(
                        appLocalizations.noHostSelected,
                        style: textTheme.labelSmall,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        softWrap: false,
                      ),
                    ),
                  ),
                ),
              ),
              AnimatedPositionedDirectional(
                key: const ValueKey("modelSelectorButton"),
                duration: modelSelectorAnimationDuration,
                curve: modelSelectorAnimationCurve,
                start: modelSelectorShowSubtitle ? modelSelectorOffset : null,
                child: AnimatedSlide(
                  offset: Offset(
                    0,
                    modelHostSelected || !modelSelectorShowSubtitle ? 0 : -0.2,
                  ),
                  duration: modelSelectorAnimationDuration,
                  curve: modelSelectorAnimationCurve,
                  child: modelSelector,
                ),
              ),
            ],
          ),
        ),
        centerTitle: breakpoint.panesRecommended < 2,
        backgroundColor: adaptedSurface,
        scrolledUnderElevation: 0,
      ),
      body: Builder(
        builder: (context) {
          if (breakpoint == Breakpoint.extraLarge &&
              Scaffold.of(context).isEndDrawerOpen) {
            _thirdPaneOpen = true;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (!mounted) return;
              setState(() {});
              Navigator.of(context).pop();
            });
          }

          return Row(mainAxisSize: MainAxisSize.max, children: children);
        },
      ),
    );

    // return Scaffold(
    //   body: ListView(
    //     children: [
    //       Padding(
    //         padding: const EdgeInsetsGeometry.only(
    //           top: 16,
    //           left: 16,
    //           right: 16,
    //           bottom: 8,
    //         ),
    //         child: Card.filled(
    //           margin: EdgeInsets.zero,
    //           clipBehavior: Clip.antiAlias,
    //           child: Column(
    //             mainAxisSize: MainAxisSize.min,
    //             children: [
    //               ListTile(
    //                 title: Text(
    //                   HostManager.instance.host?.toString() ?? "<no host?>",
    //                 ),
    //                 onTap: loadingModels
    //                     ? null
    //                     : () async {
    //                         loadingModels = true;
    //                         HostManager.instance.host = Uri.parse(
    //                           HostManager.instance.host.toString() ==
    //                                   "https://ollama.tunler.net"
    //                               ? "https://raspimainollama.tunler.net"
    //                               : "https://ollama.tunler.net",
    //                         );
    //                         setState(() {});

    //                         await loadModels();
    //                       },
    //                 dense: true,
    //               ),
    //               const Divider(height: 1),
    //               AnimatedSize(
    //                 duration: Durations.medium1,
    //                 curve: Curves.easeInOutCubic,
    //                 child: ListTile(
    //                   title: ModelManager.instance.models.isEmpty
    //                       ? const Text("No models available")
    //                       : Text.rich(
    //                           TextSpan(
    //                             children: [
    //                               const TextSpan(
    //                                 text: "Models: ",
    //                                 style: TextStyle(
    //                                   fontStyle: FontStyle.italic,
    //                                 ),
    //                               ),
    //                               for (
    //                                 var i = 0;
    //                                 i <
    //                                     ModelManager.instance.models.length *
    //                                             2 -
    //                                         1;
    //                                 i++
    //                               )
    //                                 if (i.isEven)
    //                                   TextSpan(
    //                                     text: ModelManager.instance.models
    //                                         .elementAt(i ~/ 2)
    //                                         .name,
    //                                     style: i ~/ 2 == modelIndex
    //                                         ? const TextStyle(
    //                                             fontWeight: FontWeight.bold,
    //                                           )
    //                                         : null,
    //                                   )
    //                                 else
    //                                   const TextSpan(text: ", "),
    //                             ],
    //                           ),
    //                         ),
    //                   onTap:
    //                       loadingModels || ModelManager.instance.models.isEmpty
    //                       ? null
    //                       : () async {
    //                           final currentIndex = modelIndex;
    //                           if (currentIndex == null) return;

    //                           final nextIndex =
    //                               (currentIndex + 1) %
    //                               ModelManager.instance.models.length;
    //                           modelIndex = nextIndex;
    //                           ModelManager.instance.currentModel = ModelManager
    //                               .instance
    //                               .models
    //                               .elementAt(nextIndex);
    //                           setState(() {});
    //                         },
    //                   dense: true,
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),

    //       ...ChatManager.instance.chats.map(
    //         (chat) => ScreenMainChatTile(chat: chat, chatsLoaded: chatsLoaded),
    //       ),
    //       MenuAnchor(
    //         animated: true,
    //         menuChildren:
    //             <(String, String)>[
    //               (
    //                 "GFM demo",
    //                 "Write a long demo message for all GitHub Flavored Markdown features.",
    //               ),
    //               (
    //                 "Lorem Ipsum",
    //                 "Write a middle long lorem ipsum stand in body text.",
    //               ),
    //               (
    //                 "Best emoji",
    //                 "Think very hard about the objectively best emoji.",
    //               ),
    //               (
    //                 "Math test",
    //                 "Calculate the normalized Shannon entropy for the following values: [0.1, 0.1, 0.2, 0.3, 0.3]",
    //               ),
    //             ].map((prompt) {
    //               return MenuItemButton(
    //                 child: Text(
    //                   prompt.$1,
    //                   maxLines: 1,
    //                   overflow: TextOverflow.ellipsis,
    //                 ),
    //                 onPressed: () async {
    //                   final chat = ChatManager.instance.createChat(
    //                     context: context,
    //                     system:
    //                         "Write using GitHub Flavored Markdown messages. Your messages support all GitHub Flavored Markdown features, including tables, task lists, strikethrough, alert boxes, emojis and autolinks. You must format LaTeX math using the dollar sign syntax (`\$...\$`); bracket style does not work! Speak german to the user, even if he doesn't write you in that language!",
    //                   );

    //                   await errorGuard(
    //                     context,
    //                     "M49WC9CW",
    //                     () async {
    //                       final msg = TextMessage(
    //                         prompt.$2,
    //                         sender: MessageSender.user,
    //                       );
    //                       return chat.send(msg);
    //                     },
    //                     errorMessage: errorGuardErrorMessageWithFallbackSingle(
    //                       llama.OllamaException,
    //                       "Unable to send message",
    //                     ),
    //                     enableReporting: false,
    //                   );

    //                   if (!context.mounted || !chat.alive) return;
    //                   await errorGuard(
    //                     context,
    //                     "W97BM0DJ",
    //                     () async => chat.generateTitle(context: context),
    //                     errorMessage: errorGuardErrorMessageWithFallbackSingle(
    //                       llama.OllamaException,
    //                       "Unable to generate chat title",
    //                     ),
    //                   );
    //                 },
    //               );
    //             }).toList(),
    //         builder: (_, controller, _) => ListTile(
    //           leading: const Icon(Icons.add_rounded),
    //           title: const Text("Add chat"),
    //           onTap: loadingModels || ModelManager.instance.currentModel == null
    //               ? null
    //               : controller.open,
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}

class _ScreenMainNavigationBarWide extends StatelessWidget {
  final Color adaptedSurface;
  final bool isSettingsRoute;
  final void Function()? onDestinationSelected;
  const _ScreenMainNavigationBarWide({
    required this.adaptedSurface,
    required this.isSettingsRoute,
    this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    final breakpoint = Breakpoint.of(context);
    final isEmbeddedNavigation = breakpoint.panesRecommended >= 2;

    return NavigationRail(
      leadingAtTop: true,
      trailingAtBottom: true,
      backgroundColor: adaptedSurface,
      leading: FloatingActionButton(
        onPressed: () async {
          ChatManager.instance.currentChat = null;
          if (isSettingsRoute) {
            await context.router.navigate(const RouteNewChat());
            onDestinationSelected?.call();
          }
        },
        elevation: 0,
        heroTag: null,
        child: const Icon(Icons.add),
      ),
      destinations: const [
        NavigationRailDestination(
          icon: Icon(Icons.near_me),
          label: Text("Chats"),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.settings),
          label: Text("Settings"),
        ),
      ],
      selectedIndex: isSettingsRoute ? 1 : 0,
      onDestinationSelected: (value) async {
        switch (value) {
          case 0 when isSettingsRoute:
            await context.router.navigate(
              ChatManager.instance.currentChatId != null
                  ? RouteChat(chatId: ChatManager.instance.currentChatId)
                  : const RouteNewChat(),
            );
            onDestinationSelected?.call();
          case 1 when !isSettingsRoute:
            await context.router.navigate(
              isEmbeddedNavigation
                  ? const RouteSettingsOverview()
                  : const RouteSettings(),
            );
            onDestinationSelected?.call();
          default:
        }
      },
    );
  }
}

class DrawerBackButton extends StatefulWidget {
  const DrawerBackButton({super.key});

  @override
  State<DrawerBackButton> createState() => _DrawerBackButtonState();
}

class _DrawerBackButtonState extends State<DrawerBackButton> {
  StreamSubscription<void>? _routerStream;
  String? path;

  @override
  void initState() {
    super.initState();
    path = GlobalNavigationObserver.path;
    _routerStream = GlobalNavigationObserver.routerStream.listen(onUpdate);
  }

  @override
  void dispose() {
    _routerStream?.cancel();
    super.dispose();
  }

  void onUpdate(_) {
    if (GlobalNavigationObserver.path != null) {
      path = GlobalNavigationObserver.path;
      if (mounted) setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final isSettingsRoute = path?.contains("/settings") ?? false;
    final state = isSettingsRoute && path != "/settings";
    return TwoStateWidgetManaged(
      state: state,
      from: const SizedBox.expand(child: DrawerButton()),
      to: SizedBox.expand(
        child: BackButton(
          onPressed: () async {
            if (!state) return;
            if (context.router.canPop()) {
              context.router.popTop();
            } else {
              await context.router.navigate(const RouteSettings());
            }
            if (mounted) setState(() {});
          },
        ),
      ),
    );
  }
}
