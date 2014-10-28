//
//  HYFeatureViewController.m
//  Demo
//
//  Created by Hanton on 10/28/14.
//  Copyright (c) 2014 Darma. All rights reserved.
//

#import "HYFeatureViewController.h"
#import "NYSegmentedControl.h"
#import "HYBarChartViewController.h"


@interface HYFeatureViewController () {
    NYSegmentedControl *_segmentedControl;
    UIViewController* _currentVC;
}
@property (weak, nonatomic) IBOutlet UIView *contentView;
@end

@implementation HYFeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _segmentedControl = [[NYSegmentedControl alloc] initWithItems:@[@" Today ", @" Month "]];
    [_segmentedControl addTarget:self action:@selector(segmentSelected) forControlEvents:UIControlEventValueChanged];
    _segmentedControl.titleTextColor = [UIColor colorWithRed:62.0/255.0 green:210.0/255.0 blue:137.0/255.0 alpha:1.0];
    _segmentedControl.selectedTitleTextColor = [UIColor whiteColor];
    _segmentedControl.selectedTitleFont = [UIFont systemFontOfSize:13.0f];
    _segmentedControl.segmentIndicatorBackgroundColor = [UIColor colorWithRed:62.0/255.0 green:180.0/255.0 blue:137.0/255.0 alpha:1.0];
    _segmentedControl.backgroundColor = [UIColor colorWithRed:32.0/255.0 green:160.0/255.0 blue:107.0/255.0 alpha:1.0];
    _segmentedControl.borderWidth = 0.0f;
    _segmentedControl.segmentIndicatorBorderWidth = 0.0f;
    _segmentedControl.segmentIndicatorInset = 1.0f;
    _segmentedControl.segmentIndicatorBorderColor = self.view.backgroundColor;
    [_segmentedControl sizeToFit];
    _segmentedControl.cornerRadius = CGRectGetHeight(_segmentedControl.frame) / 2.0f;
    self.navigationItem.titleView = _segmentedControl;
    
    UIViewController *vc = [self viewControllerForSegmentIndex:_segmentedControl.selectedSegmentIndex];
    [self addChildViewController:vc];
    vc.view.frame = self.contentView.bounds;
    [self.contentView addSubview:vc.view];
    _currentVC = vc;
}

-(void) segmentSelected {
    UIViewController *vc = [self viewControllerForSegmentIndex:_segmentedControl.selectedSegmentIndex];
    [self addChildViewController:vc];
    [self transitionFromViewController:_currentVC toViewController:vc duration:0.5 options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
        [_currentVC.view removeFromSuperview];
        vc.view.frame = self.contentView.bounds;
        [self.contentView addSubview:vc.view];
    } completion:^(BOOL finished) {
        [vc didMoveToParentViewController:self];
        [_currentVC removeFromParentViewController];
        _currentVC = vc;
    }];
}

- (UIViewController *)viewControllerForSegmentIndex:(NSInteger)index {
    UIViewController *vc;
    switch (index) {
        case 0:
            vc = [self.storyboard instantiateViewControllerWithIdentifier:@"BarChartVC"];
            break;
        case 1:
            vc = (UITableViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"HistoryChartVC"];
            break;
    }
    return vc;
}

@end
