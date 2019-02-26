extern NSString * const kCAFilterVibrantDark;

@interface CAFilter : NSObject <NSCopying, NSMutableCopying, NSCoding>
@property (readonly) NSString * type; 
@property (copy) NSString * name; 
@property (getter=isEnabled) BOOL enabled; 
@property (assign) BOOL cachesInputImage; 
+(void)CAMLParserStartElement:(id)arg1;
+(instancetype)filterWithName:(id)arg1;
+(instancetype)filterWithType:(id)arg1;
+(BOOL)automaticallyNotifiesObserversForKey:(id)arg1;
+(id)filterTypes;
-(void)CAMLParser:(id)arg1 setValue:(id)arg2 forKey:(id)arg3;
-(void)encodeWithCAMLWriter:(id)arg1;
-(id)CAMLTypeForKey:(id)arg1;
-(BOOL)cachesInputImage;
-(BOOL)enabled;
-(id)valueForKey:(id)arg1;
-(void)setValue:(id)arg1 forKey:(id)arg2;
-(id)initWithCoder:(id)arg1;
-(void)encodeWithCoder:(id)arg1;
-(void)setName:(NSString *)arg1;
-(NSString *)name;
-(NSString *)type;
-(void)setEnabled:(BOOL)arg1;
-(BOOL)isEnabled;
-(id)copyWithZone:(NSZone*)arg1;
-(id)initWithType:(id)arg1;
-(void)setCachesInputImage:(BOOL)arg1;
-(id)mutableCopyWithZone:(NSZone*)arg1;
-(id)initWithName:(id)arg1;
-(void)setDefaults;
@end