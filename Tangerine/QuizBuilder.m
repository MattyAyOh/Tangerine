//
//  QuizBuilder.m
//  Tangerine
//
//  Created by Matthew Ao on 8/8/15.
//  Copyright (c) 2015 LethoLogic. All rights reserved.
//

#import "QuizBuilder.h"
#import "Quiz.h"

@implementation QuizBuilder

- (instancetype)init
{
   self = [super init];
   if (self) {
      _questions = [self setupQuestions];
   }
   return self;
}

- (NSArray*)setupQuestions
{
   Quiz *quizOne = [Quiz new];
   quizOne.questionID = 1;
   quizOne.question = @"Hello";
   quizOne.answerOne = @"Zhai Jeean";
   quizOne.answerTwo = @"Knee How";
   quizOne.answerThree = @"Deeanne Now";
   quizOne.answerFour = @"She-ye She-ye";
   
   Quiz *quizTwo = [Quiz new];
   quizTwo.questionID = 2;
   quizTwo.question = @"Invest";
   quizTwo.answerOne = @"Jackie Chan";
   quizTwo.answerTwo = @"Gan Shen Me";
   quizTwo.answerThree = @"Tee Pee Goo";
   quizTwo.answerFour = @"Toe Zi";
   
   return @[quizOne, quizTwo];
}

@end