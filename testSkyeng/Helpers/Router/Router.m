//
//  Router.m
//  testSkyeng
//
//  Created by Andrew on 14.04.16.
//  Copyright © 2016 Andrew. All rights reserved.
//

#import "Router.h"

@implementation Router

-(UIWindow *)createWindowWith:(NSString *)controllerIdeintifier from:(UIStoryboard *)storyBoard {
    
    UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    UIViewController *controller = [storyBoard instantiateViewControllerWithIdentifier:controllerIdeintifier];

    UINavigationController *naviController = [[UINavigationController alloc] initWithRootViewController:controller];
    naviController.navigationBarHidden = YES;
    window.rootViewController = naviController;
    
    [window makeKeyAndVisible];
    
    return window;
}

-(void)pushNextController:(UIViewController *)controller inNaviController:(UINavigationController *)naviController {
    
    if (controller == naviController) {
        return;
    }
    
    if ([naviController isKindOfClass:[UINavigationController class]]) {
        
        [CATransaction begin];
        [naviController pushViewController:controller animated:YES];
        [CATransaction setCompletionBlock:^{
            naviController.viewControllers = @[controller];
        }];
        [CATransaction commit];
    }
    
}

-(UINavigationController *)pushWrapNaviController:(UIViewController *)controller toView:(UIView *)view {
    
    if (!controller)
        return nil;
    
    UINavigationController *naviController = [[UINavigationController alloc] initWithRootViewController:controller];
    naviController.navigationBarHidden = YES;
    [view addSubview:naviController.view];
    
    [naviController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(naviController.view.superview).with.insets(UIEdgeInsetsZero);
    }];
    
    return naviController;
}

-(void)presentModalController:(UIViewController *)controller {
    [[Router topMostController] presentViewController:controller animated:YES completion:nil];
}

+ (UIViewController*) topMostController
{
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    while (topController.presentedViewController) {
        topController = topController.presentedViewController;
    }
    
    return topController;
}

@end
