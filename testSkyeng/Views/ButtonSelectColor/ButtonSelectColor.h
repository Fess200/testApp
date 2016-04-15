//
//  ButtonSelectColor.h
//  testSkyeng
//
//  Created by Andrew on 15.04.16.
//  Copyright © 2016 Andrew. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ButtonSelectColor : UIButton

@property (strong, nonatomic) IBInspectable UIColor *colorBorder;

- (void)selectColor:(UIColor *)color;

@end
