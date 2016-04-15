//
//  VCStartPresenter.m
//  testSkyeng
//
//  Created by Andrew on 14.04.16.
//  Copyright © 2016 Andrew. All rights reserved.
//

#import "VCStartPresenter.h"
#import "VCTasks.h"
#import "Task.h"
#import "UIStoryboard+Additional.h"

@interface VCStartPresenter ()

@property (weak, nonatomic) UIViewController<VCStartPresenterDelegate> *view;
@property (strong, nonatomic) id<NetworkProtocol> network;
@property (strong, nonatomic) id<AppDataStoreProtocol> appDataStore;
@property (strong, nonatomic) id<RouterProtocol> router;

@property (strong, nonatomic) NSURLSessionDataTask *task;

@end

@implementation VCStartPresenter

- (instancetype)initWithView:(UIViewController<VCStartPresenterDelegate> *)view network:(id<NetworkProtocol>)network dataStore:(id<AppDataStoreProtocol>)appDataStore router:(id<RouterProtocol>)router
{
    self = [super init];
    if (self) {
        self.view = view;
        self.network = network;
        self.appDataStore = appDataStore;
        self.router = router;
    }
    return self;
}

- (void)startTest {
    
    if ([self.appDataStore respondsToSelector:@selector(getTasks)]) {
        NSArray *tasks = [self.appDataStore getTasks];
        if (tasks) {
            [self startSessionTask:tasks];
            return;
        }
    }
    
    if ([self.network respondsToSelector:@selector(requestDataApp:)]) {
        
        if ([self.view respondsToSelector:@selector(startNetworkActivity)]) {
            [self.view startNetworkActivity];
        }

        [self.task cancel];
        
        self.task = [self.network requestDataApp:^(NSArray *tasks, BOOL success) {
            if ([self.view respondsToSelector:@selector(endNetworkActivity)]) {
                [self.view endNetworkActivity];
            }
            
            if (success) {
                if ([self.appDataStore respondsToSelector:@selector(saveTasks:)]) {
                    [self.appDataStore saveTasks:tasks];
                }
                
                [self startSessionTask:tasks];
            } else {
                [self showAlertTryAgain];
            }
        }];
    }
}

- (void)startSessionTask:(NSArray *)tasks {
    VCTasks *tasksController = [[UIStoryboard mainStoryboard] instantiateViewControllerWithIdentifier:@"VCTasks"];
    tasksController.tasks = tasks;
    [self.router pushNextController:tasksController inNaviController:self.view.navigationController];
}

- (void)showAlertTryAgain {
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Извините. Попробуйте еще раз." message:nil preferredStyle:UIAlertControllerStyleAlert];
    [controller addAction:[UIAlertAction actionWithTitle:@"Хорошо" style:UIAlertActionStyleCancel handler:nil]];
    [self.router presentModalController:controller];
}

@end
