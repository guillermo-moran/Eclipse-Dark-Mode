/*
 .d8888. d8b   db  .d8b.  d8888b.  .o88b. db   db  .d8b.  d888888b
 88'  YP 888o  88 d8' `8b 88  `8D d8P  Y8 88   88 d8' `8b `~~88~~'
 ` 8bo.   88V8o 88 88ooo88 88oodD' 8P      88ooo88 88ooo88    88
 `Y8b. 88 V8o88 88~~~88 88~~~   8b      88~~~88 88~~~88    88
 db   8D 88  V888 88   88 88      Y8b  d8 88   88 88   88    88
 `8888Y' VP   V8P YP   YP 88       `Y88P' YP   YP YP   YP    YP
 */

// %group SnapchatApp
//
// %hook SCTextChatViewModelV2
//
// //SCTextChatViewModelV2
// //_logos_method$_ungrouped$SCTextChatViewModelV2$colorForChatLabel(SCTextChatViewModelV2 *,objc_selector *)	__text	000097E8	00000052	00000018	FFFFFFF8	R	.	.	.	.	.	.
//
//
// -(UIColor*)colorForChatLabel {
// 	if (isEnabled) {
// 		return TEXT_COLOR;
// 	}
// 	return %orig;
// }
//
//
// %end
//
// //_logos_method$_ungrouped$SCChatHamburgerRoundedCornerCell$setBorderColor$(SCChatHamburgerRoundedCornerCell *,objc_selector *,UIColor *)	__text	00004230	00000072	0000001C	FFFFFFF8	R	.	.	.	.	.	.
// //Implement later
//
// %hook SCChatInputController
//
// //_logos_method$_ungrouped$SCChatInputController$inputTextColor(SCChatInputController *,objc_selector *)	__text	0000538E	00000072	0000001C	FFFFFFF8	R	.	.	.	.	.	.
//
//
// -(UIColor*)inputTextColor {
// 	if (isEnabled) {
// 		return TEXT_COLOR;
// 	}
// 	return %orig;
// }
//
// %end
//
//
// %end
