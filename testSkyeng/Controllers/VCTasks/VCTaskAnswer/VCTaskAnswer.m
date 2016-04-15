//
//  VCTaskAnswer.m
//  testSkyeng
//
//  Created by Andrew on 15.04.16.
//  Copyright © 2016 Andrew. All rights reserved.
//

#import "VCTaskAnswer.h"
#import "Task.h"
#import "UIImageView+AFNetworking.h"

@interface VCTaskAnswer ()

@property (weak, nonatomic) IBOutlet UIButton *buttonNext;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutHeightButtonNext;
@property (weak, nonatomic) IBOutlet UIImageView *imageviewIcon;
@property (weak, nonatomic) IBOutlet UILabel *labelWord;
@property (weak, nonatomic) IBOutlet UILabel *labelTranslation;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicatorLoad;

@end

@implementation VCTaskAnswer

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.buttonNext.layer.cornerRadius = self.layoutHeightButtonNext.constant/2.0;
    
    self.labelWord.text = self.task.text;
    self.labelTranslation.text = self.task.translation;
    
    NSURL *urlIcon = [[NSURL alloc] initWithString:(NSString *)self.task.urlImage];
    
    if (urlIcon) {
        
        __weak __block VCTaskAnswer *_self = self;
        
        [self.imageviewIcon setImageWithURLRequest:[NSURLRequest requestWithURL:urlIcon] placeholderImage:nil success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
            [_self.indicatorLoad stopAnimating];
            _self.imageviewIcon.image = image;
        } failure:nil];
    }
}

- (IBAction)onNext:(id)sender {
    [self.delegate nextTask];
}

@end
