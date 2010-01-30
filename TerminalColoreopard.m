#import "TerminalColoreopard.h"
#import "NSUserDefaults.h"
#import "TCLPreferences.h"
#import <objc/objc-class.h>

// Original code is from http://github.com/rentzsch/jrswizzle
// Copyright (c) 2007 Jonathan 'Wolf' Rentzsch: <http://rentzsch.com>
BOOL jr_swizzleMethod(Class klass, SEL origSel, SEL altSel) {
	Method origMethod = class_getInstanceMethod(klass, origSel);
	if (!origMethod) {
		return NO;
	}
	Method altMethod = class_getInstanceMethod(klass, altSel);
	if (!altMethod) {
		return NO;
	}

	class_addMethod(klass, origSel, class_getMethodImplementation(klass, origSel), method_getTypeEncoding(origMethod));
	class_addMethod(klass, altSel, class_getMethodImplementation(klass, altSel), method_getTypeEncoding(altMethod));

	method_exchangeImplementations(class_getInstanceMethod(klass, origSel), class_getInstanceMethod(klass, altSel));
	return YES;
}

@implementation NSObject (TerminalColoreopard)
- (NSColor *)colorForANSIColor_swizzled:(unsigned int)code adjustedRelativeToColor:(NSColor *)color
{
	return [[[TCLPreferences sharedInstance] ansiColors] colorFor:code];
}
@end

@implementation TerminalColoreopard
+(void) load
{
	// allocate and initialize the preferences which load the user defaults
	[TCLPreferences sharedInstance];

	if(jr_swizzleMethod(NSClassFromString(@"TTView"), @selector(colorForANSIColor:adjustedRelativeToColor:), @selector(colorForANSIColor_swizzled:adjustedRelativeToColor:))) {
		NSLog(@"TerminalColoreopard installed");
	} else {
		NSLog(@"TerminalColoreopard failed");
	}
}
@end