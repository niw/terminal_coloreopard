#import "TCLPreferences.h"
#import "NSUserDefaults.h"

@implementation TCLPreferences
+(TCLPreferences*) sharedInstance
{
	static TCLPreferences* pref = nil;
	if (pref == nil) {
		pref = [[TCLPreferences alloc] init];
	}
	return pref;
}

-(void)dealloc
{
	[super dealloc];
}

-(id) init
{
	self = [super init];

	// We should create the ansiColors BEFORE load the NIB
	NSDictionary *dict = [[NSUserDefaults standardUserDefaults] colorsDictionaryForKey:USER_DEFAULTS_KEY];
	if(dict != nil) {
		ansiColors = [TCLANSIColors fromDictionary:dict];
	} else {
		ansiColors = [TCLANSIColors defaultANSIColors];
		[[NSUserDefaults standardUserDefaults] setColorsWithDictionary:[ansiColors ansiColorsAsDictionary] forKey:USER_DEFAULTS_KEY];
	}

	[NSBundle loadNibNamed:@"TCLPreferences.nib" owner:self];
	return self;
}

-(void) awakeFromNib
{
	NSMenu* applicationMenu = [[[[NSApplication sharedApplication] mainMenu] itemAtIndex: 0] submenu];
	for (NSMenuItem* menuItem in [terminalMenuAdditions itemArray]) {
		[terminalMenuAdditions removeItem:menuItem];
		[applicationMenu insertItem:menuItem atIndex:3];
	}
}

-(TCLANSIColors*) ansiColors
{
	return ansiColors;
}

-(IBAction) apply:(id)sender
{
	[[NSUserDefaults standardUserDefaults] setColorsWithDictionary:[ansiColors ansiColorsAsDictionary] forKey:USER_DEFAULTS_KEY];
}
@end