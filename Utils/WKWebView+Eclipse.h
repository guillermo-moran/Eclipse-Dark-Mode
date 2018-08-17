@interface WKWebView : UIView {}
@end

@interface WKWebView(Eclipse)
- (NSString *)stringByEvaluatingJavaScriptFromString:(NSString *)script;
@end
