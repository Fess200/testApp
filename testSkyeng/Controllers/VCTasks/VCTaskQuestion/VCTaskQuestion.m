//
//  VCTaskQuestion.m
//  testSkyeng
//
//  Created by Andrew on 15.04.16.
//  Copyright © 2016 Andrew. All rights reserved.
//

#import "VCTaskQuestion.h"
#import "ButtonSelectColor.h"
#import "DIProtocols.h"
#import "Task.h"
#import "Alternative.h"

@interface VCTaskQuestion ()

@property (weak, nonatomic) IBOutlet UILabel *labelWord;
@property (strong, nonatomic) IBOutletCollection(ButtonSelectColor) NSArray *buttonsSelect;

@property (readwrite, nonatomic) int rightTaskButtonTag;

@end

@implementation VCTaskQuestion

-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.labelWord.text = self.task.text;
    
    [self fillButtonsSelect];
}

- (void)fillButtonsSelect {
    self.rightTaskButtonTag = arc4random()%4;
    
    NSMutableArray *alternatives = self.task.alternatives.mutableCopy;
    
    for (UIButton *button in self.buttonsSelect) {
        if (button.tag == self.rightTaskButtonTag) {
            [button setTitle:self.task.translation forState:UIControlStateNormal];
        } else {
            Alternative *alternative = alternatives[arc4random()%alternatives.count];
            [button setTitle:alternative.translation forState:UIControlStateNormal];
            [alternatives removeObject:alternative];
        }
    }
}

- (IBAction)onSelectAnswer:(ButtonSelectColor *)button {
    
    UIColor *colorRight = [UIColor colorWithRed:171.0/255.0 green:207.0/255.0 blue:114.0/255.0 alpha:1];
    UIColor *colorNoRight = [UIColor colorWithRed:255.0/255.0 green:127.0/255.0 blue:129.0/255.0 alpha:1];
    
    if (button.tag == self.rightTaskButtonTag) {
        [button selectColor:colorRight];
        [self.delegate answerTask:YES];
        return;
    } else {
        [button selectColor:colorNoRight];
    }
    
    for (ButtonSelectColor *buttonSelect in self.buttonsSelect) {
        if (buttonSelect.tag == self.rightTaskButtonTag) {
            [buttonSelect selectColor:colorRight];
        }
    }
    
    [self.delegate answerTask:NO];
}

- (IBAction)onNoRemember:(id)sender {
    
    [self.delegate skipTask];
}

@end
