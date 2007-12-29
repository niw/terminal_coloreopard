#import "TerminalColoreopard.h"
#import "NSUserDefaults.h"
#import "TCLPreferences.h"

@implementation TTView (TerminalColoreopard)
- (NSColor *)colorForANSIColor:(unsigned int)code
{
	return [[[TCLPreferences sharedInstance] ansiColors] colorFor:code];
}
@end

@implementation TerminalColoreopard
+(void) load
{
	// allocate and initialize the preferences which load the user defaults
	[TCLPreferences sharedInstance];
	NSLog(@"TerminalColoreopard installed");
}
@end