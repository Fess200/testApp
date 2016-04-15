//
//  AppDataStore.m
//  testSkyeng
//
//  Created by Andrew on 14.04.16.
//  Copyright © 2016 Andrew. All rights reserved.
//

#import "AppDataStore.h"

@interface AppDataStore ()

@property (strong, nonatomic) NSArray *tasks;

@end

@implementation AppDataStore

+ (instancetype)sharedObject {
    static dispatch_once_t onceToken;
    static id sharedObject;
    dispatch_once(&onceToken, ^{
        sharedObject = [self new];
    });
    return sharedObject;
}

-(void)saveTasks:(NSArray *)tasks {
    self.tasks = tasks.copy;
}

-(NSArray *)getTasks {
    return self.tasks.copy;
}

@end
