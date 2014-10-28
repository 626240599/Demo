//
//  HYBaseViewController.m
//  Demo
//
//  Created by Hanton on 10/26/14.
//  Copyright (c) 2014 Darma. All rights reserved.
//

#import "HYBaseViewController.h"

@interface HYBaseViewController ()

@end

@implementation HYBaseViewController

#pragma mark - View Lifecycle

- (void)loadView
{
    [super loadView];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeTop;
    }
    self.view.backgroundColor = [UIColor whiteColor];
//    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:kHYImageIconJawboneLogo]];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:20.0];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor colorWithRed:62.0/255.0 green:180.0/255.0 blue:137.0/255.0 alpha:1.0];
    self.navigationItem.titleView = label;
    label.text = @"Darma";
    [label sizeToFit];
}

#pragma mark - Orientation

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark - Getters

- (UIBarButtonItem *)chartToggleButtonWithTarget:(id)target action:(SEL)action
{
//    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:kHYImageIconArrow] style:UIBarButtonItemStylePlain target:target action:action];
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"BarButton" style:UIBarButtonItemStylePlain target:target action:action];
    button.tintColor = [UIColor colorWithRed:62.0/255.0 green:180.0/255.0 blue:137.0/255.0 alpha:1.0];
    return nil;//button;
}

@end
