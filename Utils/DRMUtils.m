#import "DRMUtils.h"

@implementation DRMUtils

// Uses GMmoran.me's middle-man API to securely utilize Packix's DRM API
// For Developer's tweaks.

// Will return device's model identifier
// i.e : @"iPhone1,1" for iPhone 2G
-(NSString*)deviceModelIdentifier {
	struct utsname systemInfo;
    uname(&systemInfo);

    return [NSString stringWithCString:systemInfo.machine
                              encoding:NSUTF8StringEncoding];
}

// Return Device UDID
// Computed with formula: UDID = SHA1(SerialNumber + IMEI + WiFiAddress + BluetoothAddress)
// But link to MobileGestalt instead.
-(NSString*)deviceUDID {
	CFStringRef UDNumber = MGCopyAnswer(CFSTR("UniqueDeviceID"));
	NSString* UDID = (NSString*)UDNumber;
	return UDID;
}

-(int)packageWasPurchased {
	// Don't judge the semaphore
	// Dustin, Max, Ryan, and everyone else who's helped me learn obj-c
	// Would murder me.

	// Return types:
	// 0 = Purchased
	// 1 = Not Authorized
	// -1 = Error

	dispatch_semaphore_t mySemaphore = dispatch_semaphore_create(0);

	NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://gmoran.me/api/middleman.php"]];

	NSString* UDID = [self deviceUDID];
	NSString* modelID = [self deviceModelIdentifier];
	NSString* packageID = @"me.gmoran.eclipse12";

	NSString *userUpdate =[NSString stringWithFormat:@"UDID=%@&modelID=%@&packageID=%@", UDID, modelID, packageID];

	//create the Method "GET" or "POST"
	[urlRequest setHTTPMethod:@"POST"];

	//Convert the String to Data
	NSData *data1 = [userUpdate dataUsingEncoding:NSUTF8StringEncoding];

	//Apply the data to the body
	[urlRequest setHTTPBody:data1];

	__block int statusCode;

	NSURLSession *session = [NSURLSession sharedSession];
	NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
		NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
	    if(httpResponse.statusCode == 200)
	    {
	   	 NSError *parseError = nil;
	   	 NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
	   	 NSLog(@"The response is - %@",responseDictionary);
	   	 NSString* status = [responseDictionary objectForKey:@"status"];

	   	 if([status isEqualToString: @"completed"]) {
	   		 statusCode = 0; // Device is authorized to use this package
	   	 }
	   	 else if ([status isEqualToString: @"failed"]) {
	   		 statusCode = 1; // Device is not authorized to use this package
	   	 }
	   	 else {
	   		 statusCode = -1; // An error occurred
	   	 }
	    }
	    else {
	   	 NSString* errorMessage = @"Did not receive 200 from API";
	   	 [NSException raise:@"API Error" format:@"%@", errorMessage];
	   	 statusCode = -1;
	    }
		dispatch_semaphore_signal(mySemaphore);
	}];
	[dataTask resume];
	dispatch_semaphore_wait(mySemaphore, DISPATCH_TIME_FOREVER);
	return statusCode;
}

@end
