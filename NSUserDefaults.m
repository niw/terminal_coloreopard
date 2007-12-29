#import "NSUserDefaults.h"

@implementation NSUserDefaults (ColorSupport)
- (void)setColor:(NSColor *)aColor forKey:(NSString *)aKey
{
    NSData *theData=[NSArchiver archivedDataWithRootObject:aColor];
    [self setObject:theData forKey:aKey];
}

- (NSColor *)colorForKey:(NSString *)aKey
{
    NSColor *theColor=nil;
    NSData *theData=[self dataForKey:aKey];
    if (theData != nil)
        theColor=(NSColor *)[NSUnarchiver unarchiveObjectWithData:theData];
    return theColor;
}

- (void)setColorsWithDictionary:(NSDictionary *)colors forKey:(NSString *)aKey
{
	NSMutableDictionary *data = [NSMutableDictionary dictionary];
	for(NSString *key in colors) {
		[data setObject:[NSArchiver archivedDataWithRootObject:[colors objectForKey:key]] forKey: key];
	}
	[self setObject:data forKey:aKey];
}

- (NSDictionary *)colorsDictionaryForKey:(NSString *)aKey
{
	NSDictionary *data = [self dictionaryForKey:aKey];
	if(data != nil) {
		NSMutableDictionary *colors = [NSMutableDictionary dictionary];
		for(NSString *key in data) {
			[colors setObject:(NSColor *)[NSUnarchiver unarchiveObjectWithData:[data objectForKey:key]] forKey: key];
		}
		return colors;
	} else {
		return nil;
	}
}
@end