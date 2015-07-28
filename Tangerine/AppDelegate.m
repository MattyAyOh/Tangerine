//
//  AppDelegate.m
//  Tangerine
//
//  Created by Matthew Ao on 7/27/15.
//  Copyright (c) 2015 LethoLogic. All rights reserved.
//

#import "AppDelegate.h"

void *kContextQuizPanelOpening = &kContextQuizPanelOpening;

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@property (readwrite) NSStatusItem *statusBarItem;
@property NSRect statusItemRect;
@property QuizPanel *quizPanel;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
   NSStatusBar *bar = [NSStatusBar systemStatusBar];
   
   self.statusBarItem = [NSStatusItem new];
   self.statusBarItem = [bar statusItemWithLength:NSVariableStatusItemLength];
   NSImage* icon = [NSImage imageNamed:@"tangerine"];
   [self.statusBarItem setImage:icon];
   [self.statusBarItem setHighlightMode:YES];
   [self.statusBarItem setAction:@selector(togglePanel)];
   [self.statusBarItem setEnabled:YES];
   
   self.quizPanel = [[QuizPanel alloc] initWithWindowNibName:@"QuizPanel"];
   [self.quizPanel setDelegate:self];
}

- (void)togglePanel
{
   self.statusItemRect = [[[NSApp currentEvent] window] frame];
   NSLog(@"%@", NSStringFromRect(self.statusItemRect));
   [self.quizPanel toggleActive];
}

-(NSRect)getStatusItemRect
{
   return self.statusItemRect;
}

@end
