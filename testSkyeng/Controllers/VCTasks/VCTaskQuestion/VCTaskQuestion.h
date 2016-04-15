//
//  VCTaskQuestion.h
//  testSkyeng
//
//  Created by Andrew on 15.04.16.
//  Copyright © 2016 Andrew. All rights reserved.
//

@protocol VCTaskQuestionDelegate <NSObject>

- (void)answerTask:(BOOL)right;
- (void)skipTask;

@end

@class Task;

@interface VCTaskQuestion : UIViewController

@property (weak, nonatomic) id<VCTaskQuestionDelegate> delegate;
@property (strong, nonatomic) Task *task;

@end
