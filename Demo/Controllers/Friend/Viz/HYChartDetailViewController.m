//
//  HYChartDetailViewController.m
//  Demo
//
//  Created by Hanton on 10/26/14.
//  Copyright (c) 2014 Darma. All rights reserved.
//

#import "HYChartDetailViewController.h"

// Views
#import "HYDataPointTableCell.h"
#import "HYDataPointHeaderView.h"

#import "HYConstants.h"

// Strings
NSString * const kHYChartDetailViewControllerCellIdentifier = @"kHYChartDetailViewControllerCellIdentifier";

// Numerics
CGFloat static const kHYChartDetailViewControllerHeaderHeight = 50.0f;

@interface HYChartDetailViewController ()

@property (nonatomic, assign) HYDataModelChartType chartType;

// Buttons
- (void)closeButtonPressed:(id)sender;

@end

@implementation HYChartDetailViewController

#pragma mark - Alloc/Init

- (id)initWithChartType:(HYDataModelChartType)chartType
{
    self = [super init];
    if (self)
    {
        _chartType = chartType;
    }
    return self;
}

#pragma mark - View Lifecycle

- (void)loadView
{
    [super loadView];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:kHYStringLabelClose style:UIBarButtonItemStyleBordered target:self action:@selector(closeButtonPressed:)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor colorWithRed:62.0/255.0 green:180.0/255.0 blue:137.0/255.0 alpha:1.0];
    
//    self.title = [NSString stringWithFormat:kHYStringLabelChartDetails, self.chartType+1];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:20.0];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor colorWithRed:62.0/255.0 green:180.0/255.0 blue:137.0/255.0 alpha:1.0];
    self.navigationItem.titleView = label;
    label.text = [NSString stringWithFormat:kHYStringLabelChartDetails, self.chartType+1];
    [label sizeToFit];
    
    [self.tableView registerClass:[HYDataPointTableCell class] forCellReuseIdentifier:kHYChartDetailViewControllerCellIdentifier];
    [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithRed:49.0/255.0 green:49.0/255.0 blue:49.0/255.0 alpha:1.0];
    
    HYDataPointHeaderView *header = [[HYDataPointHeaderView alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, self.view.bounds.size.width, kHYChartDetailViewControllerHeaderHeight)];
    header.backgroundColor = [UIColor colorWithRed:49.0/255.0 green:49.0/255.0 blue:49.0/255.0 alpha:1.0];
    header.leftLabel.text = [NSString stringWithFormat:kHYStringLabelX];
    header.leftLabel.textColor = [UIColor colorWithRed:62.0/255.0 green:180.0/255.0 blue:137.0/255.0 alpha:1.0];
    header.rightLabel.text = [NSString stringWithFormat:kHYStringLabelY];
    header.rightLabel.textColor = [UIColor colorWithRed:62.0/255.0 green:180.0/255.0 blue:137.0/255.0 alpha:1.0];
    [self.tableView setTableHeaderView:header];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[HYHistoryDataModel sharedInstance] dataForChartType:self.chartType sorted:NO] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HYDataPointTableCell *cell = [tableView dequeueReusableCellWithIdentifier:kHYChartDetailViewControllerCellIdentifier forIndexPath:indexPath];
    HYDataPoint *dataPoint = [[[HYHistoryDataModel sharedInstance] dataForChartType:self.chartType sorted:NO] objectAtIndex:indexPath.row];
    cell.leftLabel.text = [NSString stringWithFormat:@"%d", (int)dataPoint.point.x];
    cell.leftLabel.textColor = [UIColor colorWithRed:62.0/255.0 green:180.0/255.0 blue:137.0/255.0 alpha:1.0];
    cell.rightLabel.text = [NSString stringWithFormat:@"%.1f", dataPoint.point.y];
    cell.rightLabel.textColor = [UIColor colorWithRed:62.0/255.0 green:180.0/255.0 blue:137.0/255.0 alpha:1.0];
    cell.backgroundColor = indexPath.row % 2 == 0 ? [UIColor colorWithRed:60.0/255.0 green:60.0/255.0 blue:60.0/255.0 alpha:1.0] : [UIColor colorWithRed:49.0/255.0 green:49.0/255.0 blue:49.0/255.0 alpha:1.0];
    return cell;
}

#pragma mark - Buttons

- (void)closeButtonPressed:(id)sender
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

@end
  