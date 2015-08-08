//
//  AppDelegate.m
//  Tangerine
//
//  Created by Matthew Ao on 7/27/15.
//  Copyright (c) 2015 LethoLogic. All rights reserved.
//

#import "AppDelegate.h"
#import "QuizBuilder.h"

void *kContextQuizPanelOpening = &kContextQuizPanelOpening;

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@property (readwrite) NSStatusItem *statusBarItem;
@property NSRect statusItemRect;
@property QuizPanel *quizPanel;
@property QuizBuilder *quizBuilder;

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
   
   self.quizBuilder = [QuizBuilder new];
   Quiz *quiz = self.quizBuilder.questions.count == 0 ? nil : self.quizBuilder.questions[arc4random_uniform((uint32_t)self.quizBuilder.questions.count)];
   [self.quizPanel setQuiz:quiz];
   [NSTimer scheduledTimerWithTimeInterval:5.0
                                    target:self
                                  selector:@selector(timedOpenPanel)
                                  userInfo:nil
                                   repeats:NO];
}

- (void)timedOpenPanel
{
   Quiz *quiz = self.quizBuilder.questions.count == 0 ? nil : self.quizBuilder.questions[arc4random_uniform((uint32_t)self.quizBuilder.questions.count)];
   [self.quizPanel setQuiz:quiz];
   self.statusItemRect = [[self.statusBarItem valueForKey:@"window"] frame];
   NSLog(@"%@", NSStringFromRect(self.statusItemRect));
   [self.quizPanel openPanel];
   [NSTimer scheduledTimerWithTimeInterval:5.0
                                    target:self
                                  selector:@selector(timedOpenPanel)
                                  userInfo:nil
                                   repeats:NO];
}

- (void)togglePanel
{
//   self.statusItemRect = [[[NSApp currentEvent] window] frame];
   self.statusItemRect = [[self.statusBarItem valueForKey:@"window"] frame];
   NSLog(@"%@", NSStringFromRect(self.statusItemRect));
   [self.quizPanel togglePanel];
}

-(NSRect)getStatusItemRect
{
   return self.statusItemRect;
}

@end
