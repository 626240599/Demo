//
//  HYChartViewController.m
//  Demo
//
//  Created by Hanton on 10/26/14.
//  Copyright (c) 2014 Darma. All rights reserved.
//

#import "HYChartViewController.h"
#import "HYDataModel.h"
#import "HYUser+Additions.h"
#import "HYSittingHour.h"
#import "HYLineChartView.h"
#import "HYChartFooterView.h"
#import "HYChartHeaderView.h"
#import "HYConstants.h"

// Numerics
CGFloat static const kHYChartViewContainerPadding = 20.0f;
CGFloat static const kHYChartViewContainerHeaderHeight = 40.0f;
CGFloat static const kHYChartViewContainerFooterHeight = 30.0f;
CGFloat static const kHYChartViewContainerLineChartLineWidth = 3.0f;
NSUInteger static const kHYChartViewControllerFooterSectionCount = 2;
NSUInteger static const kHYChartViewControllerChartLineCount = 1;

@interface HYChartViewContainer : UIView

@property (nonatomic, strong) HYLineChartView *lineChartView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *footerView;

@end

@interface HYChartViewController () <JBLineChartViewDelegate, HYLineChartViewDataSource>

@property (nonatomic, strong) HYUser *user;
@property (nonatomic, strong) HYChartViewContainer *chartContainer;

@end

@implementation HYChartViewController

#pragma mark - Alloc/Init

- (id)initWithUser:(HYUser *)user
{
    self = [super init];
    if (self)
    {
        _user = user;
    }
    return self;
}

#pragma mark - View Lifecycle

- (void)loadView
{
    [super loadView];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:kHYStringLabelClose style:UIBarButtonItemStyleBordered target:self action:@selector(closeButtonPressed:)];
//    self.title = [self.user fullName];

    self.navigationItem.leftBarButtonItem.tintColor = [UIColor colorWithRed:62.0/255.0 green:180.0/255.0 blue:137.0/255.0 alpha:1.0];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:20.0];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor colorWithRed:62.0/255.0 green:180.0/255.0 blue:137.0/255.0 alpha:1.0];
    self.navigationItem.titleView = label;
    label.text = [self.user fullName];
    [label sizeToFit];

    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.chartContainer = [[HYChartViewContainer alloc] initWithFrame:self.view.bounds];
    self.view = self.chartContainer;

    self.chartContainer.lineChartView.delegate = self;
    self.chartContainer.lineChartView.dataSource = self;

    self.chartContainer.lineChartView.maximumValue = [[HYDataModel sharedInstance] maximumStepValue];
    self.chartContainer.lineChartView.minimumValue = [[HYDataModel sharedInstance] minimumStepValue];
    
    HYChartHeaderView *headerView = [[HYChartHeaderView alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, self.view.bounds.size.width, kHYChartViewContainerHeaderHeight)];
    headerView.titleLabel.text = kHYStringLabelAnnualStepData;
//    headerView.titleLabel.textColor = [UIColor colorWithRed:62.0/255.0 green:180.0/255.0 blue:137.0/255.0 alpha:1.0];
    self.chartContainer.headerView = headerView;

    HYChartFooterView *footerView = [[HYChartFooterView alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, self.view.bounds.size.width, kHYChartViewContainerFooterHeight)];
    footerView.sectionCount = kHYChartViewControllerFooterSectionCount;
    footerView.leftLabel.text = [kHYStringLabelJan uppercaseString];
//    footerView.leftLabel.textColor = [UIColor colorWithRed:62.0/255.0 green:180.0/255.0 blue:137.0/255.0 alpha:1.0];
    footerView.rightLabel.text = [kHYStringLabelDec uppercaseString];
//    footerView.rightLabel.textColor = [UIColor colorWithRed:62.0/255.0 green:180.0/255.0 blue:137.0/255.0 alpha:1.0];
    footerView.centerLabel.text = kHYStringLabel2013;
//    footerView.centerLabel.textColor = [UIColor colorWithRed:62.0/255.0 green:180.0/255.0 blue:137.0/255.0 alpha:1.0];
    self.chartContainer.footerView = footerView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.chartContainer.lineChartView reloadData];
}

#pragma mark - Buttons

- (void)closeButtonPressed:(id)sender
{
//    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - SFLineChartViewDataSource

- (NSUInteger)numberOfLinesInLineChartView:(HYLineChartView *)lineChartView;
{
    return kHYChartViewControllerChartLineCount;
}

- (NSUInteger)lineChartView:(HYLineChartView *)lineChartView numberOfVerticalValuesAtLineIndex:(NSUInteger)lineIndex
{
    return [self.user.sittingHours count];
}

- (UIColor *)lineChartView:(HYLineChartView *)lineChartView colorForLineAtLineIndex:(NSUInteger)lineIndex
{
    return [UIColor colorWithRed:62.0/255.0 green:180.0/255.0 blue:137.0/255.0 alpha:1.0];//kHYColorChartLineColor;
}

- (CGFloat)lineChartView:(HYLineChartView *)lineChartView widthForLineAtLineIndex:(NSUInteger)lineIndex
{
    return kHYChartViewContainerLineChartLineWidth;
}

- (NSUInteger)minimumAverageInLineChartView:(HYLineChartView *)lineChartView
{
    return [[HYDataModel sharedInstance] averageStepValue];
}

- (NSUInteger)maximumAverageInLineChartView:(HYLineChartView *)lineChartView
{
    return [[HYDataModel sharedInstance] averageStepValue];
}

#pragma mark - HYLineChartViewDelegate

- (CGFloat)lineChartView:(HYLineChartView *)lineChartView verticalValueForHorizontalIndex:(NSUInteger)horizontalIndex atLineIndex:(NSUInteger)lineIndex
{
    HYSittingHour *sittingHour = [self.user.sittingHours objectAtIndex:horizontalIndex];
    return sittingHour.value;
}

- (BOOL)lineChartView:(HYLineChartView *)lineChartView smoothLineAtLineIndex:(NSUInteger)lineIndex
{
    return YES;
}

@end

@implementation HYChartViewContainer

#pragma mark - Alloc/Init

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = kHYColorBaseBackgroundColor;
        
        _lineChartView = [[HYLineChartView alloc] initWithFrame:self.bounds];
        _lineChartView.backgroundColor = kHYColorBaseBackgroundColor;
        _lineChartView.showsLineSelection = NO;
        _lineChartView.showsVerticalSelection = NO;
        [self addSubview:_lineChartView];
    }
    return self;
}

#pragma mark - Setters

- (void)setHeaderView:(UIView *)headerView
{
    if (_headerView != nil)
    {
        [_headerView removeFromSuperview];
        _headerView = nil;
    }
    
    _headerView = headerView;
    [self addSubview:_headerView];
    [self setNeedsLayout];
}

- (void)setFooterView:(UIView *)footerView
{
    if (_footerView != nil)
    {
        [_footerView removeFromSuperview];
        _footerView = nil;
    }
    
    _footerView = footerView;
    [self addSubview:_footerView];
    [self setNeedsLayout];
}

#pragma mark - Layout

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat yOffset = kHYChartViewContainerPadding;
    CGFloat xOffset = kHYChartViewContainerPadding;
    
    self.headerView.frame = CGRectMake(xOffset, yOffset, self.bounds.size.width - (kHYChartViewContainerPadding * 2), self.headerView.frame.size.height);
    yOffset += self.headerView.frame.size.height;
    self.lineChartView.frame = CGRectMake(xOffset, yOffset, self.bounds.size.width - (kHYChartViewContainerPadding * 2), self.bounds.size.height - self.headerView.frame.size.height - self.footerView.frame.size.height - (kHYChartViewContainerPadding * 2));
    yOffset += self.lineChartView.frame.size.height;
    self.footerView.frame = CGRectMake(xOffset, yOffset, self.bounds.size.width - (kHYChartViewContainerPadding * 2), self.footerView.frame.size.height);
    
    [self.lineChartView reloadData];
}

@end
