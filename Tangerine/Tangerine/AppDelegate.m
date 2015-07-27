//
//  AppDelegate.m
//  Tangerine
//
//  Created by Matthew Ao on 7/27/15.
//  Copyright (c) 2015 LethoLogic. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;

@property NSStatusItem *statusBarItem;
@property NSMenu *statusMenu;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
   self.statusMenu = [NSMenu new];
   [self.statusMenu addItemWithTitle:@"An Item" action:nil keyEquivalent:@""];
   [self.statusMenu addItemWithTitle:@"Another Item" action:nil keyEquivalent:@""];
   
   NSStatusBar *bar = [NSStatusBar systemStatusBar];
   
   self.statusBarItem = [NSStatusItem new];
   self.statusBarItem = [bar statusItemWithLength:NSVariableStatusItemLength];
   NSImage* icon = [NSImage imageNamed:@"tangerine"];
   [self.statusBarItem setImage:icon];
   [self.statusBarItem setHighlightMode:YES];
   [self.statusBarItem setMenu:self.statusMenu];
   [self.statusBarItem setEnabled:YES];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
   // Insert code here to tear down your application
}

@end
