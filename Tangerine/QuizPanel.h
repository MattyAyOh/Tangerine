//
//  QuizPanel.h
//  Tangerine
//
//  Created by Matthew Ao on 7/27/15.
//  Copyright (c) 2015 LethoLogic. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol QuizPanelDelegate <NSObject>

//@property (readwrite) NSStatusItem *statusBarItem;
- (NSRect)getStatusItemRect;

@end

@class Quiz;

@interface QuizPanel : NSWindowController

@property id<QuizPanelDelegate> delegate;
@property (nonatomic) Quiz *quiz;

- (void)togglePanel;
- (void)openPanel;

@end
