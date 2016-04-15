//
//  VCTaskAnswer.h
//  testSkyeng
//
//  Created by Andrew on 15.04.16.
//  Copyright © 2016 Andrew. All rights reserved.
//

@protocol VCTaskAnswerDelegate <NSObject>

- (void)nextTask;

@end

@class Task;

@interface VCTaskAnswer : UIViewController

@property (weak, nonatomic) id<VCTaskAnswerDelegate> delegate;
@property (strong, nonatomic) Task *task;

@end
