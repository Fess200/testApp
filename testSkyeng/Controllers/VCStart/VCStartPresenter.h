//
//  VCStartPresenter.h
//  testSkyeng
//
//  Created by Andrew on 14.04.16.
//  Copyright © 2016 Andrew. All rights reserved.
//

#import "DIProtocols.h"

@protocol VCStartPresenterDelegate <NSObject>

@optional
- (void)startNetworkActivity;
- (void)endNetworkActivity;

@end

@interface VCStartPresenter : NSObject

- (instancetype)initWithView:(UIViewController<VCStartPresenterDelegate> *)view network:(id<NetworkProtocol>)network dataStore:(id<AppDataStoreProtocol>)appDataStore router:(id<RouterProtocol>)router;
- (void)startTest;

@end
