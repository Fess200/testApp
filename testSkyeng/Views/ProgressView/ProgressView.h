//
//  ProgressView.h
//  testSkyeng
//
//  Created by Andrew on 15.04.16.
//  Copyright © 2016 Andrew. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgressView : UIView

@property (strong, nonatomic) IBInspectable UIColor *colorProgress;
@property (readwrite, nonatomic) double progressValue;

@end
