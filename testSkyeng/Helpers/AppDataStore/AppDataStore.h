//
//  AppDataStore.h
//  testSkyeng
//
//  Created by Andrew on 14.04.16.
//  Copyright © 2016 Andrew. All rights reserved.
//

#import "DIProtocols.h"

@interface AppDataStore : NSObject<AppDataStoreProtocol>

+ (instancetype)sharedObject;

@end
