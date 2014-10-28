//
//  HYFriendVieController.m
//  Demo
//
//  Created by Hanton on 10/26/14.
//  Copyright (c) 2014 Darma. All rights reserved.
//

#import "HYFriendViewController.h"
#import "HYUserTableViewCell.h"
#import "HYDataModel.h"
#import "HYUser+Additions.h"
#import "HYSittingHour.h"
#import "HYBaseNavigationController.h"
#import "HYChartViewController.h"
#import "HYConstants.h"

// Enums
typedef NS_ENUM(NSInteger, HYMainViewControllerSection){
    HYMainViewControllerSectionCurrentUser,
	HYMainViewControllerSectionFriends,
    HYMainViewControllerSectionCount
};

// Strings
NSString * const kHYMainViewControllerCellIdentifier = @"kHYMainViewControllerCellIdentifier";

// Numerics
CGFloat static const kHYMainViewControllerLineChartLineWidth = 1.0f;
CGFloat static const kHYMainViewControllerSeparatorPadding = 10.0f;
NSUInteger static const kHYMainViewControllerChartLineCount = 1;

@interface HYFriendViewController () <HYLineChartViewDataSource, JBLineChartViewDelegate>

@property (nonatomic, strong) NSDateFormatter *dateFormatter;

@end

@implementation HYFriendViewController

#pragma mark - View Lifecycle

-(void)loadView {
    [super loadView];
    
//    self.title = kHYStringLabelProfile;
    self.view.backgroundColor = [UIColor whiteColor];//kHYColorBaseBackgroundColor;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:20.0];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor colorWithRed:62.0/255.0 green:180.0/255.0 blue:137.0/255.0 alpha:1.0];
    self.navigationItem.titleView = label;
    label.text = kHYStringLabelProfile;
    [label sizeToFit];
    
    [self.tableView registerClass:[HYUserTableViewCell class] forCellReuseIdentifier:kHYMainViewControllerCellIdentifier];
    [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, kHYMainViewControllerSeparatorPadding, 0, 0)];
    self.tableView.backgroundColor = [UIColor colorWithRed:60.0/255.0 green:60.0/255.0 blue:60.0/255.0 alpha:1.0];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return HYMainViewControllerSectionCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == HYMainViewControllerSectionCurrentUser)
    {
        return 1;
    }
    else if (section == HYMainViewControllerSectionFriends)
    {
        return [[[HYDataModel sharedInstance].currentUser friends] count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HYUserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kHYMainViewControllerCellIdentifier forIndexPath:indexPath];
    
    HYUser *user;
    if (indexPath.section == HYMainViewControllerSectionCurrentUser)
    {
        user = [HYDataModel sharedInstance].currentUser;
    }
    else if (indexPath.section == HYMainViewControllerSectionFriends)
    {
        user = [[[HYDataModel sharedInstance].currentUser friends] objectAtIndex:indexPath.row];
    }
    
    cell.backgroundColor = [UIColor colorWithRed:49.0/255.0 green:49.0/255.0 blue:49.0/255.0 alpha:1.0];

    cell.userImageView.image = user.profileImage;
    cell.nameLabel.text = [user fullName];
    cell.nameLabel.textColor = [UIColor colorWithRed:62.0/255.0 green:180.0/255.0 blue:137.0/255.0 alpha:1.0];
    cell.dateLabel.text = [NSString stringWithFormat:kHYStringLabelMemberSince, [self.dateFormatter stringFromDate:user.createDate]];
    cell.dateLabel.textColor = [UIColor colorWithRed:62.0/255.0 green:180.0/255.0 blue:137.0/255.0 alpha:1.0];
    
    cell.lineChartView.user = user;
    cell.lineChartView.delegate = self;
    cell.lineChartView.dataSource = self;
    cell.lineChartView.maximumValue = [[HYDataModel sharedInstance] maximumStepValue];
    cell.lineChartView.minimumValue = [[HYDataModel sharedInstance] minimumStepValue];
    
    [cell.lineChartView reloadData];
    return cell;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    if (section == HYMainViewControllerSectionCurrentUser)
//    {
//        return kHYStringLabelYou;
//    }
//    else if (section == HYMainViewControllerSectionFriends)
//    {
//        return kHYStringLabelFriends;
//    }
//    return nil;
//}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView* view = [[UIView alloc] init];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:20.0];
    label.textAlignment = NSTextAlignmentLeft;
    label.textColor = [UIColor colorWithRed:62.0/255.0 green:180.0/255.0 blue:137.0/255.0 alpha:1.0];
    if (section == HYMainViewControllerSectionCurrentUser)
    {
        label.text = kHYStringLabelYou;
    }
    else if (section == HYMainViewControllerSectionFriends)
    {
        label.text = kHYStringLabelFriends;
    }
    [label sizeToFit];
    label.frame = CGRectMake(10.0, 0.0, label.frame.size.width, label.frame.size.height);
    view.backgroundColor = [UIColor colorWithRed:60.0/255.0 green:60.0/255.0 blue:60.0/255.0 alpha:1.0];
    [view addSubview:label];
    return view;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    HYUser *user;
    if (indexPath.section == HYMainViewControllerSectionCurrentUser)
    {
        user = [HYDataModel sharedInstance].currentUser;
    }
    else if (indexPath.section == HYMainViewControllerSectionFriends)
    {
        user = [[[HYDataModel sharedInstance].currentUser friends] objectAtIndex:indexPath.row];
    }
    
    HYChartViewController *chartViewController = [[HYChartViewController alloc] initWithUser:user];
//    HYBaseNavigationController *navigationController = [[HYBaseNavigationController alloc] initWithRootViewController:chartViewController];
//    [self.navigationController presentViewController:navigationController animated:YES completion:nil];
    [self.navigationController pushViewController:chartViewController animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kHYUserTableViewCellHeight;
}

#pragma mark - SFLineChartViewDataSource

- (NSUInteger)numberOfLinesInLineChartView:(HYLineChartView *)lineChartView;
{
    return kHYMainViewControllerChartLineCount;
}

- (NSUInteger)lineChartView:(HYLineChartView *)lineChartView numberOfVerticalValuesAtLineIndex:(NSUInteger)lineIndex
{
    if ([lineChartView isKindOfClass:[HYLineChartView class]])
    {
        return [((HYLineChartView *)lineChartView).user.sittingHours count];
    }
    return 0;
}

- (UIColor *)lineChartView:(HYLineChartView *)lineChartView colorForLineAtLineIndex:(NSUInteger)lineIndex
{
    return [UIColor colorWithRed:62.0/255.0 green:180.0/255.0 blue:137.0/255.0 alpha:1.0];//kHYColorSparkChartLineColor;
}

- (CGFloat)lineChartView:(HYLineChartView *)lineChartView widthForLineAtLineIndex:(NSUInteger)lineIndex
{
    return kHYMainViewControllerLineChartLineWidth;
}

- (NSUInteger)minimumAverageInLineChartView:(HYLineChartView *)lineChartView
{
    if ([lineChartView isKindOfClass:[HYLineChartView class]])
    {
        return [[HYDataModel sharedInstance] averageStepValue];
    }
    return 0;
}

- (NSUInteger)maximumAverageInLineChartView:(HYLineChartView *)lineChartView
{
    if ([lineChartView isKindOfClass:[HYLineChartView class]])
    {
        return [[HYDataModel sharedInstance] averageStepValue];
    }
    return 0;
}

#pragma mark - HYLineChartViewDelegate

- (CGFloat)lineChartView:(HYLineChartView *)lineChartView verticalValueForHorizontalIndex:(NSUInteger)horizontalIndex atLineIndex:(NSUInteger)lineIndex
{
    if ([lineChartView isKindOfClass:[HYLineChartView class]])
    {
        HYUser *user = ((HYLineChartView *)lineChartView).user;
        HYSittingHour *sittingHour =  [user.sittingHours objectAtIndex:horizontalIndex];
        return sittingHour.value;
    }
    return 0.0f;
}

- (BOOL)lineChartView:(HYLineChartView *)lineChartView smoothLineAtLineIndex:(NSUInteger)lineIndex
{
    return YES;
}

#pragma mark - Getters

- (NSDateFormatter *)dateFormatter
{
    if (_dateFormatter == nil)
    {
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setDateStyle:NSDateFormatterShortStyle];
    }
    return _dateFormatter;
}

@end
