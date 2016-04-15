//
//  JSONValueTransformer+Custom.m
//  testSkyeng
//
//  Created by Andrew on 14.04.16.
//  Copyright © 2016 Andrew. All rights reserved.
//

#import "JSONValueTransformer+Custom.h"
#import "NetworkUrlImage.h"

@implementation JSONValueTransformer (Custom)

-(NetworkUrlImage *)NetworkUrlImageFromNSArray:(NSArray *)array
{
    NSString *firstImage = array.firstObject;
    
    if ([firstImage isKindOfClass:[NSString class]]) {
        return [[NetworkUrlImage alloc] initWithString:[NSString stringWithFormat:@"http:%@",firstImage]];
    }
    
    return nil;
}

@end
