//
//  VCFinish.m
//  testSkyeng
//
//  Created by Andrew on 14.04.16.
//  Copyright © 2016 Andrew. All rights reserved.
//

#import "VCFinish.h"
#import <Objection/Objection.h>
#import "DIProtocols.h"
#import "VCTasks.h"
#import "Task.h"
#import "UIStoryboard+Additional.h"

@interface VCFinish ()

@property (weak, nonatomic) IBOutlet UILabel *labelNumberRightTask;
@property (weak, nonatomic) IBOutlet UIButton *buttonAgain;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutHeightButtonAgain;

@property (strong, nonatomic) id<AppDataStoreProtocol> appDataStore;
@property (strong, nonatomic) id<RouterProtocol> router;

@end

@implementation VCFinish

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.appDataStore = [[JSObjection defaultInjector] getObject:@protocol(AppDataStoreProtocol)];
        self.router = [[JSObjection defaultInjector] getObject:@protocol(RouterProtocol)];
    }
    return self;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.buttonAgain.layer.cornerRadius = self.layoutHeightButtonAgain.constant/2.0;
    self.labelNumberRightTask.text = [NSString stringWithFormat:@"%lu/%lu", (unsigned long)self.numberRightAnswer, (unsigned long)self.countQuestions];
}

- (IBAction)onAgain:(id)sender {
    
    if ([self.appDataStore respondsToSelector:@selector(getTasks)]) {
        NSArray *tasks = [self.appDataStore getTasks];
        if (tasks) {
            [self startSessionTask:tasks];
        }
    }

}

- (void)startSessionTask:(NSArray *)tasks {
    VCTasks *tasksController = [[UIStoryboard mainStoryboard] instantiateViewControllerWithIdentifier:@"VCTasks"];
    tasksController.tasks = tasks;
    [self.router pushNextController:tasksController inNaviController:self.navigationController];
}

@end
