//
//  Quiz.h
//  Tangerine
//
//  Created by Matthew Ao on 8/8/15.
//  Copyright (c) 2015 LethoLogic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Quiz : NSObject

@property int questionID;
@property NSString *question;
//TODO: Make `answers` an array so there can be a variable number of choices
@property NSString *answerOne;
@property NSString *answerTwo;
@property NSString *answerThree;
@property NSString *answerFour;
@end
