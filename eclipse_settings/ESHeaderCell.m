#import "ESHeaderCell.h"
#import <UIKit/UIImage+Private.h>
#import <version.h>

static CGFloat const qHeaderCellFontSize = 30.f;

@implementation ESHeaderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier specifier:(PSSpecifier *)specifier {
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier specifier:specifier];

	if (self) {
		UIView *containerView = [[[UIView alloc] init] autorelease];
		containerView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
		[self.contentView addSubview:containerView];
        self.contentView.backgroundColor = [UIColor clearColor];

		UIImageView *imageView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"eclipse_header" inBundle:[NSBundle bundleForClass:self.class]]] autorelease];
		
        
		UILabel *typeLabel = [[[UILabel alloc] init] autorelease];
        typeLabel.backgroundColor = [UIColor clearColor];
        typeLabel.font = [UIFont systemFontOfSize:qHeaderCellFontSize];
        
        typeLabel.text = @"Eclipse";
       
		
		UILabel *statusLabel = [[[UILabel alloc] init] autorelease];
        
        statusLabel.text = @" Dark Mode";
       
        
		statusLabel.backgroundColor = [UIColor clearColor];
		statusLabel.font = [UIFont boldSystemFontOfSize:qHeaderCellFontSize];

	    [self setBackgroundColor: [UIColor clearColor]];


		typeLabel.frame = CGRectMake(imageView.image.size.width + 10.f, -1.f, [typeLabel.text sizeWithFont:typeLabel.font].width, imageView.image.size.height);
        
		statusLabel.frame = CGRectMake(typeLabel.frame.origin.x + typeLabel.frame.size.width, typeLabel.frame.origin.y, [statusLabel.text sizeWithFont:statusLabel.font].width, imageView.image.size.height);
        
		containerView.frame = CGRectMake(0, 0, statusLabel.frame.origin.x + statusLabel.frame.size.width, imageView.image.size.height);
        
		containerView.center = CGPointMake(self.contentView.frame.size.width / 2.f, containerView.center.y);
        
		imageView.center = CGPointMake(imageView.center.x, containerView.frame.size.height / 3.f);
        
        
        //BOOL listFileExists = YES;
        BOOL listFileExists = [[NSFileManager defaultManager] fileExistsAtPath:@"/var/lib/dpkg/info/me.gmoran.eclipse13.list"];

        if (!listFileExists) {
            typeLabel.text = @"Eclipse";
            statusLabel.text = @"(Pirated)";   
        }
        
        [containerView addSubview:imageView];
        [containerView addSubview:typeLabel];
        [containerView addSubview:statusLabel];
        
	}

	return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    self.backgroundColor = [UIColor clearColor];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        [[UIApplication sharedApplication] openURL:request.URL];
        return false;
    }
    return true;
}

@end
