//
//  NetworkUrlImage.m
//  testSkyeng
//
//  Created by Andrew on 14.04.16.
//  Copyright © 2016 Andrew. All rights reserved.
//

#import "NetworkUrlImage.h"

@implementation NetworkUrlImage
{
    NSString *string;
}

-(id)initWithString:(NSString*)_string {
    
    if(self = [super init]) {
        string = _string;
    }
    
    return self;
}

-(NSUInteger)length {
    
    return [string length];
}

-(unichar)characterAtIndex:(NSUInteger)index {
    
    return [string characterAtIndex:index];
}

@end
