//
//  HYMainTabBarViewController.m
//  Demo
//
//  Created by Hanton on 10/28/14.
//  Copyright (c) 2014 Darma. All rights reserved.
//

#import "HYMainTabBarViewController.h"

@interface HYMainTabBarViewController ()

@end

@implementation HYMainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[UITabBar appearance] setTintColor:[UIColor colorWithRed:62.0/255.0 green:180.0/255.0 blue:137.0/255.0 alpha:1.0]];
//    [[UITabBar appearance] setBarTintColor:[UIColor yellowColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
