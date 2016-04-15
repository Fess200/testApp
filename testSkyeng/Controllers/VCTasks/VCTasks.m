//
//  VCTasks.m
//  testSkyeng
//
//  Created by Andrew on 15.04.16.
//  Copyright © 2016 Andrew. All rights reserved.
//

#import "VCTasks.h"
#import "ProgressView.h"
#import "DIProtocols.h"
#import <Objection/Objection.h>
#import "UIStoryboard+Additional.h"

#import "VCTaskAnswer.h"
#import "VCTaskQuestion.h"
#import "VCFinish.h"

@interface VCTasks () <VCTaskAnswerDelegate, VCTaskQuestionDelegate>

@property (weak, nonatomic) IBOutlet ProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIView *viewContainer;

@property (readwrite, nonatomic) int currentTask;
@property (readwrite, nonatomic) NSUInteger numberRightTasks;

@property (strong, nonatomic) id<RouterProtocol> router;

@property (strong, nonatomic) UINavigationController *naviContainerController;

@end

@implementation VCTasks

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.router = [[JSObjection defaultInjector] getObject:@protocol(RouterProtocol)];
    }
    return self;
}

-(void)setTasks:(NSArray *)tasks {
    NSMutableArray *arrayMutableTasks = tasks.mutableCopy;
    
    NSMutableArray *tasksSession = [NSMutableArray new];
    
    for (int i=0;i<10 && i<arrayMutableTasks.count;i++) {
        Task *task = [arrayMutableTasks objectAtIndex:(arc4random()%arrayMutableTasks.count)];
        [tasksSession addObject:task];
        [arrayMutableTasks removeObject:task];
    }
    
    _tasks = tasksSession;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.progressView setProgressValue:0];
    
    self.naviContainerController = [self.router pushWrapNaviController:[self createNextQuestionController] toView:self.viewContainer];
}

- (VCTaskQuestion *)createNextQuestionController {
    VCTaskQuestion *controller = [[UIStoryboard mainStoryboard] instantiateViewControllerWithIdentifier:@"VCTaskQuestion"];
    controller.delegate = self;
    controller.task = self.tasks[self.currentTask];
    return controller;
}

- (VCTaskAnswer *)createAnswerController {
    VCTaskAnswer *controller = [[UIStoryboard mainStoryboard] instantiateViewControllerWithIdentifier:@"VCTaskAnswer"];
    controller.task = self.tasks[self.currentTask];
    controller.delegate = self;
    return controller;
}

#pragma mark - VCTaskQuestionDelegate

- (void)answerTask:(BOOL)right {
    
    if (right) {
        self.numberRightTasks++;
    }
    
    [self openAnswerQuestionAfterDelay:YES];
}

- (void)skipTask {
    [self openAnswerQuestionAfterDelay:NO];
}

- (void)openAnswerQuestionAfterDelay:(BOOL)delay {
    VCTaskAnswer *controller = [self createAnswerController];
    
    [self.progressView setProgressValue:(double)(self.currentTask+1)/(double)self.tasks.count];
    
    if (delay) {
        
        self.navigationController.view.userInteractionEnabled = NO;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.router pushNextController:controller inNaviController:self.naviContainerController];
            self.navigationController.view.userInteractionEnabled = YES;
        });
    } else {
        [self.router pushNextController:controller inNaviController:self.naviContainerController];
    }
}

#pragma mark - VCTaskAnswerDelegate

- (void)nextTask {
    
    if (self.currentTask == self.tasks.count-1) {
        VCFinish *controller = [[UIStoryboard mainStoryboard] instantiateViewControllerWithIdentifier:@"VCFinish"];
        controller.countQuestions = self.tasks.count;
        controller.numberRightAnswer = self.numberRightTasks;
        [self.router pushNextController:controller inNaviController:self.navigationController];
    } else {
        self.currentTask++;
        VCTaskQuestion *controller = [self createNextQuestionController];
        [self.router pushNextController:controller inNaviController:self.naviContainerController];
    }
}

@end
