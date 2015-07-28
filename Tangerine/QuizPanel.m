//
//  QuizPanel.m
//  Tangerine
//
//  Created by Matthew Ao on 7/27/15.
//  Copyright (c) 2015 LethoLogic. All rights reserved.
//

//  Thanks to shpakovski for code to open panel off of StatusBarItem
//  https://github.com/shpakovski/Popup

#define OPEN_DURATION .15
#define CLOSE_DURATION .1

#define POPUP_HEIGHT 296
#define PANEL_WIDTH 303
#define MENU_ANIMATION_DURATION .1

#import "QuizPanel.h"
#include <stdlib.h>

@interface QuizPanel ()

@property BOOL isActive;
@property int rotation;

@property IBOutlet NSTextField *quizNumber;
@property IBOutlet NSTextField *englishPhrase;
@property IBOutlet NSTextField *answerOne;
@property IBOutlet NSTextField *answerTwo;
@property IBOutlet NSTextField *answerThree;
@property IBOutlet NSTextField *answerFour;

@end

@implementation QuizPanel

- (void)windowDidLoad {
    [super windowDidLoad];
   self.rotation = 0;
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

- (IBAction)submitPressed:(id)sender {
   [self toggleActive];
}

-(void)toggleActive
{
   self.isActive = !self.isActive;
   if(self.isActive)
   {
      NSString *randomIntAsString = [NSString stringWithFormat:@"%d",arc4random_uniform(100)];
      [self.quizNumber setStringValue:randomIntAsString];
      if(self.rotation == 1)
      {
         [self.englishPhrase setStringValue:@"Invest"];
         [self.answerOne setStringValue:@"Jackie Chan"];
         [self.answerTwo setStringValue:@"Gan Shen Ma"];
         [self.answerThree setStringValue:@"Tee Pee Goo"];
         [self.answerFour setStringValue:@"Toe Zi"];
      }
      [self openPanel];
   }
   else
   {
      self.rotation = 1;
      [self closePanel];
   }
}

- (void)openPanel
{
   NSWindow *panel = [self window];
   
   NSRect screenRect = [[[NSScreen screens] objectAtIndex:0] frame];
   NSRect statusRect = [self statusRectForWindow:panel];
   
   NSRect panelRect = [panel frame];
   panelRect.size.width = PANEL_WIDTH;
   panelRect.size.height = POPUP_HEIGHT;
   panelRect.origin.x = roundf(NSMidX(statusRect) - NSWidth(panelRect) / 2);
   panelRect.origin.y = NSMaxY(statusRect) - NSHeight(panelRect);
   
   [NSApp activateIgnoringOtherApps:NO];
   [panel setAlphaValue:0];
   [panel setFrame:statusRect display:YES];
   [panel makeKeyAndOrderFront:nil];
   [panel orderFront:nil];
   
   NSTimeInterval openDuration = OPEN_DURATION;
   
   NSEvent *currentEvent = [NSApp currentEvent];
   if ([currentEvent type] == NSLeftMouseDown)
   {
      NSUInteger clearFlags = ([currentEvent modifierFlags] & NSDeviceIndependentModifierFlagsMask);
      BOOL shiftPressed = (clearFlags == NSShiftKeyMask);
      BOOL shiftOptionPressed = (clearFlags == (NSShiftKeyMask | NSAlternateKeyMask));
      if (shiftPressed || shiftOptionPressed)
      {
         openDuration *= 10;
         
         if (shiftOptionPressed)
            NSLog(@"Icon is at %@\n\tMenu is on screen %@\n\tWill be animated to %@",
                  NSStringFromRect(statusRect), NSStringFromRect(screenRect), NSStringFromRect(panelRect));
      }
   }
   
   [NSAnimationContext beginGrouping];
   [[NSAnimationContext currentContext] setDuration:openDuration];
   [[panel animator] setFrame:panelRect display:YES];
   [[panel animator] setAlphaValue:1];
   [NSAnimationContext endGrouping];
}



- (void)closePanel
{
   [NSAnimationContext beginGrouping];
   [[NSAnimationContext currentContext] setDuration:CLOSE_DURATION];
   [[[self window] animator] setAlphaValue:0];
   [NSAnimationContext endGrouping];
   
   dispatch_after(dispatch_walltime(NULL, NSEC_PER_SEC * CLOSE_DURATION * 2), dispatch_get_main_queue(), ^{
      
      [self.window orderOut:nil];
   });
}

- (NSRect)statusRectForWindow:(NSWindow *)window
{
   NSRect statusRect = NSZeroRect;
   
   if ([self.delegate respondsToSelector:@selector(getStatusItemRect)])
   {
      statusRect = [self.delegate getStatusItemRect];
      statusRect.origin.y = NSMinY(statusRect) - NSHeight(statusRect);
   }
   
   return statusRect;
}
@end
