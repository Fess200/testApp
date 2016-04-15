//
//  ButtonSelectColor.m
//  testSkyeng
//
//  Created by Andrew on 15.04.16.
//  Copyright © 2016 Andrew. All rights reserved.
//

#import "ButtonSelectColor.h"

@implementation ButtonSelectColor

-(void)awakeFromNib {
    [super awakeFromNib];
    
    self.layer.cornerRadius = self.frame.size.height/2.0;
    self.layer.borderColor = self.colorBorder.CGColor;
    self.layer.borderWidth = 1.0;
    self.layer.masksToBounds = YES;
}

- (void)selectColor:(UIColor *)color {
    self.backgroundColor = color;
    self.layer.borderColor = color.CGColor;
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

@end
