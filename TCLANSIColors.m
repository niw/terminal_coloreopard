#import "TCLANSIColors.h"

// This method category is compatible with Snow Leopard implmentation.
// On the Snow Leopard, we don't need next methonds.
#define DARK_BRIGHTNESS 0.5
@implementation NSColor (TerminalColoreopard)
+ (NSColor *)vtBlackColor
{
	return [NSColor blackColor];
}

+ (NSColor *)vtRedColor
{
	return [NSColor colorWithCalibratedRed:DARK_BRIGHTNESS green:0.0 blue:0.0 alpha:1.0];
}

+ (NSColor *)vtGreenColor
{
	return [NSColor colorWithCalibratedRed:0.0 green:DARK_BRIGHTNESS blue:0.0 alpha:1.0];
}

+ (NSColor *)vtYellowColor
{
	return [NSColor colorWithCalibratedRed:DARK_BRIGHTNESS green:DARK_BRIGHTNESS blue:0.0 alpha:1.0];
}

+ (NSColor *)vtBlueColor
{
	return [NSColor colorWithCalibratedRed:0.0 green:0.0 blue:DARK_BRIGHTNESS alpha:1.0];
}

+ (NSColor *)vtMagentaColor
{
	return [NSColor colorWithCalibratedRed:DARK_BRIGHTNESS green:0.0 blue:DARK_BRIGHTNESS alpha:1.0];
}

+ (NSColor *)vtCyanColor
{
	return [NSColor colorWithCalibratedRed:0.0 green:DARK_BRIGHTNESS blue:DARK_BRIGHTNESS alpha:1.0];
}

+ (NSColor *)vtWhiteColor
{
	return [NSColor lightGrayColor];
}

+ (NSColor *)vtBrightBlackColor
{
	return [NSColor darkGrayColor];
}

+ (NSColor *)vtBrightRedColor
{
	return [NSColor redColor];
}

+ (NSColor *)vtBrightGreenColor
{
	return [NSColor greenColor];
}

+ (NSColor *)vtBrightYellowColor
{
	return [NSColor yellowColor];
}

+ (NSColor *)vtBrightBlueColor
{
	return [NSColor blueColor];
}

+ (NSColor *)vtBrightMagentaColor
{
	return [NSColor magentaColor];
}

+ (NSColor *)vtBrightCyanColor
{
	return [NSColor cyanColor];
}

+ (NSColor *)vtBrightWhiteColor
{
	return [NSColor whiteColor];
}
@end

@implementation TCLANSIColors
+(TCLANSIColors *)defaultANSIColors
{
	TCLANSIColors *colors = [[TCLANSIColors alloc] init];
	return [colors autorelease];
}

+(TCLANSIColors *)fromDictionary:(NSDictionary *)aDictionary
{
	TCLANSIColors *colors = [TCLANSIColors defaultANSIColors];
	for(NSString *name in [TCLANSIColors ansiColorNames]) {
		NSColor *color = [aDictionary objectForKey:name];
		if(color) {
			[colors setValue:color forKey:[name stringByAppendingString:@"Color"]];
		}
	}
	return colors;
}

+(NSArray *)ansiColorNames
{
	static NSArray *colorNames;
	if(colorNames == nil) {
		colorNames = [[NSArray arrayWithObjects:@"black", @"red", @"green", @"yellow", @"blue", @"magenta", @"cyan", @"white",
			@"brightBlack", @"brightRed", @"brightGreen", @"brightYellow", @"brightBlue", @"brightMagenta", @"brightCyan", @"brightWhite", nil] retain];
	}
	return colorNames;
}

-(void)dealloc
{
	[super dealloc];
}

-(id)init
{
	self = [super init];
	for(NSString *name in [TCLANSIColors ansiColorNames]) {
		// TCLANSIColors still uses "...Color" style key name so far.
		NSString *key = [name stringByAppendingString:@"Color"];
		// build Snow Leopard "vt...Color" style key name for NSColor
		NSString *vtColorKey = [NSString stringWithFormat:@"vt%@Color", [name stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:[[name substringToIndex:1] uppercaseString]]];
		[self setValue:[NSColor valueForKey:vtColorKey] forKey:key];
	}
	return self;
}

-(NSDictionary *)ansiColorsAsDictionary
{
	NSMutableDictionary *dict = [NSMutableDictionary dictionary];
	for(NSString *name in [TCLANSIColors ansiColorNames]) {
		[dict setValue:[self valueForKey:[name stringByAppendingString:@"Color"]] forKey:name];
	}
	return dict;
}

-(NSColor *)colorFor:(unsigned int)code
{
	NSColor *color = nil;
	if(code > 0 && code <= [[TCLANSIColors ansiColorNames] count]) {
		NSString *name = [[TCLANSIColors ansiColorNames] objectAtIndex:code-1];
		if(name) {
			color = [self valueForKey:[name stringByAppendingString:@"Color"]];
		}
	}
	return color;
}

@end