//
//  AppModule.m
//  testSkyeng
//
//  Created by Andrew on 14.04.16.
//  Copyright © 2016 Andrew. All rights reserved.
//

#import "AppModule.h"
#import "DIProtocols.h"
#import "NetworkManager.h"
#import "AppDataStore.h"
#import "Router.h"

@implementation AppModule

- (void)configure {
    [self bind:[NetworkManager new] toProtocol:@protocol(NetworkProtocol)];
    [self bind:[AppDataStore sharedObject] toProtocol:@protocol(AppDataStoreProtocol)];
    [self bind:[Router new] toProtocol:@protocol(RouterProtocol)];
}

@end
