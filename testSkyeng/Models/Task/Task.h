//
//  Task.h
//  testSkyeng
//
//  Created by Andrew on 14.04.16.
//  Copyright © 2016 Andrew. All rights reserved.
//

@protocol Alternative
@end

#import "CommonJSONModel.h"

@class NetworkUrlImage;

@interface Task : CommonJSONModel

@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSString *translation;
@property (strong, nonatomic) NetworkUrlImage *urlImage;
@property (strong, nonatomic) NSArray<Alternative> *alternatives;

@end
