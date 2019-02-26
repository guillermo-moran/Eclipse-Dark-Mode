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
		[containerView addSubview:imageView];

        
		UILabel *typeLabel = [[[UILabel alloc] init] autorelease];
        
        //Start DRM
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:@"/var/lib/dpkg/info/org.thebigboss.eclipse2.list"]) {
            typeLabel.text = @"Eclipse";
        }
        else {
            typeLabel.text = @"Pirated";
        }
        
        //End DRM
		
		typeLabel.backgroundColor = [UIColor clearColor];
		typeLabel.font = [UIFont systemFontOfSize:qHeaderCellFontSize];
		[containerView addSubview:typeLabel];

		UILabel *statusLabel = [[[UILabel alloc] init] autorelease];
        
        //Start DRM
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:@"/var/lib/dpkg/info/org.thebigboss.eclipse2.list"]) {
            statusLabel.text = @" 2";
        }
        else {
            statusLabel.text = @" :(";
        }
        
        //End DRM
		
		statusLabel.backgroundColor = [UIColor clearColor];
		statusLabel.font = [UIFont boldSystemFontOfSize:qHeaderCellFontSize];
		[containerView addSubview:statusLabel];

		typeLabel.frame = CGRectMake(imageView.image.size.width + 10.f, -1.f, [typeLabel.text sizeWithFont:typeLabel.font].width, imageView.image.size.height);
        
		statusLabel.frame = CGRectMake(typeLabel.frame.origin.x + typeLabel.frame.size.width, typeLabel.frame.origin.y, [statusLabel.text sizeWithFont:statusLabel.font].width, imageView.image.size.height);
        
		containerView.frame = CGRectMake(0, 0, statusLabel.frame.origin.x + statusLabel.frame.size.width, imageView.image.size.height);
        
		containerView.center = CGPointMake(self.contentView.frame.size.width / 2.f, containerView.center.y);
        
		imageView.center = CGPointMake(imageView.center.x, containerView.frame.size.height / 3.f);
        
	}

	return self;
}

@end
