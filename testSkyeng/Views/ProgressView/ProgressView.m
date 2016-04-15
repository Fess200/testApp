//
//  ProgressView.m
//  testSkyeng
//
//  Created by Andrew on 15.04.16.
//  Copyright © 2016 Andrew. All rights reserved.
//

#import "ProgressView.h"

@interface ProgressView ()

@property (strong, nonatomic) UIView *progress;

@end

@implementation ProgressView

-(void)awakeFromNib {
    [super awakeFromNib];
    
    self.layer.cornerRadius = self.frame.size.height/2.0;
    self.layer.borderColor = self.colorProgress.CGColor;
    self.layer.borderWidth = 1.0;
    self.layer.masksToBounds = YES;
    
    self.progress = [UIView new];
    [self.progress setBackgroundColor:self.colorProgress];
    [self addSubview:self.progress];
    
    [self.progress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.progress.superview.mas_leading).offset(0);
        make.top.equalTo(self.progress.superview.mas_top).offset(0);
        make.bottom.equalTo(self.progress.superview.mas_bottom).offset(0);
        make.width.offset(0);
    }];
}

-(void)setProgressValue:(double)progressValue {
    [self.progress mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.offset(progressValue*self.progress.superview.frame.size.width);
    }];
}

@end
