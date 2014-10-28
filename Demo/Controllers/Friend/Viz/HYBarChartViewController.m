//
//  HYBarChartViewController.m
//  Demo
//
//  Created by Hanton on 10/26/14.
//  Copyright (c) 2014 Darma. All rights reserved.
//

#import "HYBarChartViewController.h"

// Views
#import "JBBarChartView.h"
#import "HYFeatureChartHeaderView.h"
#import "HYBarChartFooterView.h"
#import "HYChartInformationView.h"

// Numerics
CGFloat const kHYBarChartViewControllerChartHeight = 250.0f;
CGFloat const kHYBarChartViewControllerChartPadding = 10.0f;
CGFloat const kHYBarChartViewControllerChartHeaderHeight = 80.0f;
CGFloat const kHYBarChartViewControllerChartHeaderPadding = 20.0f;
CGFloat const kHYBarChartViewControllerChartFooterHeight = 25.0f;
CGFloat const kHYBarChartViewControllerChartFooterPadding = 5.0f;
CGFloat const kHYBarChartViewControllerBarPadding = 1.0f;
NSInteger const kHYBarChartViewControllerNumBars = 24;
NSInteger const kHYBarChartViewControllerMaxBarHeight = 10;
NSInteger const kHYBarChartViewControllerMinBarHeight = 0;

// Strings
NSString * const kHYBarChartViewControllerNavButtonViewKey = @"view";

@interface HYBarChartViewController () <JBBarChartViewDelegate, JBBarChartViewDataSource>

@property (nonatomic, strong) JBBarChartView *barChartView;
@property (nonatomic, strong) HYChartInformationView *informationView;
@property (nonatomic, strong) NSArray *chartData;
@property (nonatomic, strong) NSArray *monthlySymbols;

// Buttons
- (void)chartToggleButtonPressed:(id)sender;

// Data
- (void)initFakeData;

@end

@implementation HYBarChartViewController

#pragma mark - Alloc/Init

- (id)init
{
    self = [super init];
    if (self)
    {
        [self initFakeData];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self initFakeData];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        [self initFakeData];
    }
    return self;
}

#pragma mark - Date

- (void)initFakeData
{
    NSMutableArray *mutableChartData = [NSMutableArray array];
    for (int i=0; i<kHYBarChartViewControllerNumBars; i++)
    {
//        NSInteger delta = (kHYBarChartViewControllerNumBars - abs((kHYBarChartViewControllerNumBars - i) - i)) + 2;
//        [mutableChartData addObject:[NSNumber numberWithFloat:MAX((delta * kHYBarChartViewControllerMinBarHeight), arc4random() % (delta * kHYBarChartViewControllerMaxBarHeight))]];
        if ((i>=0 && i<6) || (i>=20)) {
            [mutableChartData addObject:[NSNumber numberWithFloat:0.0]];
        } else {
            [mutableChartData addObject:[NSNumber numberWithFloat:rand()%60]];
        }
    }
    _chartData = [NSArray arrayWithArray:mutableChartData];
    
    NSMutableArray* mutableTimeData = [NSMutableArray array];
    for (int j=0; j<24; j++) {
        if (j<12) {
            mutableTimeData[j] = [NSString stringWithFormat:@"%d:00AM", j];
        } else {
            mutableTimeData[j] = [NSString stringWithFormat:@"%d:00PM", j];
        }
    }
    _monthlySymbols = [NSArray arrayWithArray:mutableTimeData];;//[[[NSDateFormatter alloc] init] shortMonthSymbols];
}

#pragma mark - View Lifecycle

- (void)loadView
{
    [super loadView];
    
    self.view.backgroundColor = [UIColor colorWithRed:49.0/255.0 green:49.0/255.0 blue:49.0/255.0 alpha:1.0];
    self.navigationItem.rightBarButtonItem = [self chartToggleButtonWithTarget:self action:@selector(chartToggleButtonPressed:)];

    self.barChartView = [[JBBarChartView alloc] init];
    self.barChartView.frame = CGRectMake(kHYBarChartViewControllerChartPadding, kHYBarChartViewControllerChartPadding, self.view.bounds.size.width - (kHYBarChartViewControllerChartPadding * 2), kHYBarChartViewControllerChartHeight);
    self.barChartView.delegate = self;
    self.barChartView.dataSource = self;
    self.barChartView.headerPadding = kHYBarChartViewControllerChartHeaderPadding;
    self.barChartView.minimumValue = 0.0f;
    self.barChartView.inverted = NO;
    self.barChartView.backgroundColor = [UIColor colorWithRed:60.0/255.0 green:60.0/255.0 blue:60.0/255.0 alpha:1.0];
    
    HYFeatureChartHeaderView *headerView = [[HYFeatureChartHeaderView alloc] initWithFrame:CGRectMake(kHYBarChartViewControllerChartPadding, ceil(self.view.bounds.size.height * 0.5) - ceil(kHYBarChartViewControllerChartHeaderHeight * 0.5), self.view.bounds.size.width - (kHYBarChartViewControllerChartPadding * 2), kHYBarChartViewControllerChartHeaderHeight)];
    headerView.titleLabel.text = [@"Today" uppercaseString];
    headerView.subtitleLabel.text = @"2014";
    headerView.separatorColor = [UIColor yellowColor];//[UIColor colorWithRed:68.0 green:68.0 blue:68.0 alpha:1.0];
    self.barChartView.headerView = headerView;
    
    HYBarChartFooterView *footerView = [[HYBarChartFooterView alloc] initWithFrame:CGRectMake(kHYBarChartViewControllerChartPadding, ceil(self.view.bounds.size.height * 0.5) - ceil(kHYBarChartViewControllerChartFooterHeight * 0.5), self.view.bounds.size.width - (kHYBarChartViewControllerChartPadding * 2), kHYBarChartViewControllerChartFooterHeight)];
    footerView.padding = kHYBarChartViewControllerChartFooterPadding;
    footerView.leftLabel.text = @"0:00 AM";//[[self.monthlySymbols firstObject] uppercaseString];
    footerView.leftLabel.textColor = [UIColor whiteColor];
    footerView.rightLabel.text = @"23:00 PM";//[[self.monthlySymbols lastObject] uppercaseString];
    footerView.rightLabel.textColor = [UIColor whiteColor];
    self.barChartView.footerView = footerView;
    
    self.informationView = [[HYChartInformationView alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x, CGRectGetMaxY(self.barChartView.frame), self.view.bounds.size.width, self.view.bounds.size.height - CGRectGetMaxY(self.barChartView.frame) - CGRectGetMaxY(self.navigationController.navigationBar.frame))];
    [self.view addSubview:self.informationView];

    [self.view addSubview:self.barChartView];
    [self.barChartView reloadData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.barChartView setState:JBChartViewStateExpanded];
}

#pragma mark - HYChartViewDataSource

- (BOOL)shouldExtendSelectionViewIntoHeaderPaddingForChartView:(JBChartView *)chartView
{
    return YES;
}

- (BOOL)shouldExtendSelectionViewIntoFooterPaddingForChartView:(JBChartView *)chartView
{
    return NO;
}

#pragma mark - HYBarChartViewDataSource

- (NSUInteger)numberOfBarsInBarChartView:(JBBarChartView *)barChartView
{
    return kHYBarChartViewControllerNumBars;
}

- (void)barChartView:(JBBarChartView *)barChartView didSelectBarAtIndex:(NSUInteger)index touchPoint:(CGPoint)touchPoint
{
    NSNumber *valueNumber = [self.chartData objectAtIndex:index];
    [self.informationView setValueText:[NSString stringWithFormat:@"%d Minutes", [valueNumber intValue]] unitText:nil];
    [self.informationView setTitleText:@"Sitting Time in this Hour"];
    [self.informationView setHidden:NO animated:YES];
    [self setTooltipVisible:YES animated:YES atTouchPoint:touchPoint];
    [self.tooltipView setText:[[self.monthlySymbols objectAtIndex:index] uppercaseString]];
}

- (void)didDeselectBarChartView:(JBBarChartView *)barChartView
{
    [self.informationView setHidden:YES animated:YES];
    [self setTooltipVisible:NO animated:YES];
}

#pragma mark - HYBarChartViewDelegate

- (CGFloat)barChartView:(JBBarChartView *)barChartView heightForBarViewAtIndex:(NSUInteger)index
{
    return [[self.chartData objectAtIndex:index] floatValue];
}

- (UIColor *)barChartView:(JBBarChartView *)barChartView colorForBarViewAtIndex:(NSUInteger)index
{
//    return (index % 2 == 0) ? [UIColor colorWithRed:8.0/255.0 green:188.0/255.0 blue:239.0 alpha:1.0] : [UIColor colorWithRed:52.0/255.0 green:178.0/255.0 blue:52.0/255.0 alpha:1.0];
    return [UIColor colorWithRed:62.0/255.0 green:180.0/255.0 blue:137.0/255.0 alpha:1.0];
}

- (UIColor *)barSelectionColorForBarChartView:(JBBarChartView *)barChartView
{
    return [UIColor whiteColor];
}

- (CGFloat)barPaddingForBarChartView:(JBBarChartView *)barChartView
{
    return kHYBarChartViewControllerBarPadding;
}

#pragma mark - Buttons

- (void)chartToggleButtonPressed:(id)sender
{
    UIView *buttonImageView = [self.navigationItem.rightBarButtonItem valueForKey:kHYBarChartViewControllerNavButtonViewKey];
    buttonImageView.userInteractionEnabled = NO;
    
    CGAffineTransform transform = self.barChartView.state == JBChartViewStateExpanded ? CGAffineTransformMakeRotation(M_PI) : CGAffineTransformMakeRotation(0);
    buttonImageView.transform = transform;
    
    [self.barChartView setState:self.barChartView.state == JBChartViewStateExpanded ? JBChartViewStateCollapsed : JBChartViewStateExpanded animated:YES callback:^{
        buttonImageView.userInteractionEnabled = YES;
    }];
}

#pragma mark - Overrides

- (JBChartView *)chartView
{
    return self.barChartView;
}

@end
