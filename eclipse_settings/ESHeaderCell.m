#import "ESHeaderCell.h"
#import <UIKit/UIImage+Private.h>
#import <version.h>

static CGFloat const qHeaderCellFontSize = 30.f;

@implementation ESHeaderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier specifier:(PSSpecifier *)specifier {
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier specifier:specifier];

	if (self) {
		self.backgroundColor = [UIColor clearColor];
		self.backgroundView = IS_IOS_OR_NEWER(iOS_7_0) ? nil : [[[UIView alloc] init] autorelease];

		UIView *containerView = [[[UIView alloc] init] autorelease];
		containerView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
		[self.contentView addSubview:containerView];

		UIImageView *imageView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"eclipse_header" inBundle:[NSBundle bundleForClass:self.class]]] autorelease];
		

        
		UILabel *typeLabel = [[[UILabel alloc] init] autorelease];
        typeLabel.backgroundColor = [UIColor clearColor];
        typeLabel.font = [UIFont systemFontOfSize:qHeaderCellFontSize];
        
        typeLabel.text = @"Eclipse";
       
		
		UILabel *statusLabel = [[[UILabel alloc] init] autorelease];
        
        statusLabel.text = @"X";
       
        
		statusLabel.backgroundColor = [UIColor clearColor];
		statusLabel.font = [UIFont boldSystemFontOfSize:qHeaderCellFontSize];
		

		typeLabel.frame = CGRectMake(imageView.image.size.width + 10.f, -1.f, [typeLabel.text sizeWithFont:typeLabel.font].width, imageView.image.size.height);
        
		statusLabel.frame = CGRectMake(typeLabel.frame.origin.x + typeLabel.frame.size.width, typeLabel.frame.origin.y, [statusLabel.text sizeWithFont:statusLabel.font].width, imageView.image.size.height);
        
		containerView.frame = CGRectMake(0, 0, statusLabel.frame.origin.x + statusLabel.frame.size.width, imageView.image.size.height);
        
		containerView.center = CGPointMake(self.contentView.frame.size.width / 2.f, containerView.center.y);
        
		imageView.center = CGPointMake(imageView.center.x, containerView.frame.size.height / 3.f);
        
        
        
        //BOOL listFileExists = YES;
        BOOL listFileExists = [[NSFileManager defaultManager] fileExistsAtPath:@"/var/lib/dpkg/info/me.gmoran.eclipsex.list"];

        
        //if ([result isEqualToString:@"Not Licensed"] || !listFileExists) {
        if (!listFileExists) {

            /*
            UIWebView *webview = [[UIWebView alloc]initWithFrame:CGRectMake(self.contentView.frame.size.width / 8, 0, 330, 65)];
            
            webview.delegate = self;
            
            //webview.center = self.contentView.center;
            
            webview.scrollView.scrollEnabled = NO;
            
            NSString *url = @"http://gmoran.me/repo/depictions/EclipseAd.html";
            NSURL *nsurl = [NSURL URLWithString:url];
            NSURLRequest *nsrequest = [NSURLRequest requestWithURL:nsurl];
            [webview loadRequest:nsrequest];
            
            [self.contentView addSubview:webview];
            
            [webview release];
             */
            
            typeLabel.text = @"Pirated";
            statusLabel.text = @":(";


            [containerView addSubview:imageView];
            [containerView addSubview:typeLabel];
            [containerView addSubview:statusLabel];
            
        }
        else {
            
            [containerView addSubview:imageView];
            [containerView addSubview:typeLabel];
            [containerView addSubview:statusLabel];
            
        }
        
	}

	return self;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        [[UIApplication sharedApplication] openURL:request.URL];
        return false;
    }
    return true;
}

@end
