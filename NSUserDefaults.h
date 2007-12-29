#import <Foundation/Foundation.h>

@interface NSUserDefaults (ColorSupport)
-(void) setColor:(NSColor *)aColor forKey:(NSString *)aKey;
-(NSColor *) colorForKey:(NSString *)aKey;
-(void) setColorsWithDictionary:(NSDictionary *)colors forKey:(NSString *)aKey;
-(NSDictionary *) colorsDictionaryForKey:(NSString *)aKey;
@end