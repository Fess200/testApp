//
//  VCStart.m
//  testSkyeng
//
//  Created by Andrew on 14.04.16.
//  Copyright © 2016 Andrew. All rights reserved.
//

#import "VCStart.h"
#import <Objection/Objection.h>
#import "DIProtocols.h"
#import "VCStartPresenter.h"

@interface VCStart() <VCStartPresenterDelegate>

@property (weak, nonatomic) IBOutlet UIButton *buttonStartTest;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutHeightButtonStartTest;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicatorAvtive;

@property (strong, nonatomic) VCStartPresenter *presenter;

@end

@implementation VCStart

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.presenter = [[VCStartPresenter alloc] initWithView:self
                                                        network:[[JSObjection defaultInjector] getObject:@protocol(NetworkProtocol)]
                                                      dataStore:[[JSObjection defaultInjector] getObject:@protocol(AppDataStoreProtocol)]
                                                         router:[[JSObjection defaultInjector] getObject:@protocol(RouterProtocol)]];
    }
    return self;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.buttonStartTest.layer.cornerRadius = self.layoutHeightButtonStartTest.constant/2.0;
}

- (IBAction)onStartTest:(id)sender {
    [self.presenter startTest];
}

- (void)startNetworkActivity {
    [self.indicatorAvtive startAnimating];
}

- (void)endNetworkActivity {
    [self.indicatorAvtive stopAnimating];
}

@end
