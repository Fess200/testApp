//
//  DIProtocols.h
//  testSkyeng
//
//  Created by Andrew on 14.04.16.
//  Copyright © 2016 Andrew. All rights reserved.
//

@protocol NetworkProtocol <NSObject>

-(NSURLSessionDataTask *)requestDataApp:(void (^)(NSArray *tasks, BOOL success))complete;

@end

@protocol AppDataStoreProtocol <NSObject>

-(void)saveTasks:(NSArray *)tasks;
-(NSArray *)getTasks;

@end

@protocol RouterProtocol <NSObject>

-(UIWindow *)createWindowWith:(NSString *)controllerIdeintifier from:(UIStoryboard *)storyBoard;
-(void)pushNextController:(UIViewController *)controller inNaviController:(UINavigationController *)naviController;
-(UINavigationController *)pushWrapNaviController:(UIViewController *)controller toView:(UIView *)view;
-(void)presentModalController:(UIViewController *)controller;

@end
