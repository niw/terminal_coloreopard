#import <Cocoa/Cocoa.h>
#import "TCLANSIColors.h"

#define USER_DEFAULTS_KEY @"ANSI Colors"

@interface TCLPreferences : NSObject {
	IBOutlet NSMenu *terminalMenuAdditions;
	TCLANSIColors *ansiColors;
}
+(TCLPreferences*) sharedInstance;
-(id) init;
-(TCLANSIColors*) ansiColors;
-(IBAction) apply:(id)sender;
@end