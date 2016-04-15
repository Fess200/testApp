//
//  NetworkManager.m
//  testSkyeng
//
//  Created by Andrew on 14.04.16.
//  Copyright © 2016 Andrew. All rights reserved.
//

#import "NetworkManager.h"
#import "AFHTTPSessionManager.h"
#import "Task.h"

@interface NetworkManager ()

@property(nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation NetworkManager

- (id)init {
    self = [super init];
    if(self) {
        self.manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[[NSURL alloc] initWithString:@"http://dictionary.skyeng.ru/api/v1"]];
        self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",nil];
        [self.manager.requestSerializer setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
        [self.manager.requestSerializer setTimeoutInterval:30];
    }
    return self;
}

-(NSURLSessionDataTask *)requestDataApp:(void (^)(NSArray *tasks, BOOL success))complete {
    
    double width = [UIScreen mainScreen].bounds.size.width;
    
    NSDictionary *parameters = @{@"meaningIds":@"211138,226138,177344,196957,224324,89785,79639,173148,136709,158582,92590,135793,68068,64441,46290,128173,51254,55112,222435", @"width":[NSString stringWithFormat:@"%f",width]};
    
    return [self.manager GET:@"wordtasks" parameters:parameters progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        if ([responseObject isKindOfClass:[NSArray class]]) {
            
            NSMutableArray *tasks = [NSMutableArray new];
            
            for (NSDictionary *dataTask in responseObject) {
                Task *task = [[Task alloc] initWithDictionary:dataTask error:nil];
                
                if (task) {
                    [tasks addObject:task];
                }
            }
            
            if (complete) {
                complete(tasks, YES);
            }
        } else {
            if (complete) {
                complete(nil, NO);
            }
        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        
        if (complete) {
            complete(nil, NO);
        }
        
    }];
}

@end
