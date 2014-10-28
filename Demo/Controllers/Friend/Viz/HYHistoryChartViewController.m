//
//  HYHistoryChartViewController.m
//  Demo
//
//  Created by Hanton on 10/26/14.
//  Copyright (c) 2014 Darma. All rights reserved.
//

#import "HYHistoryChartViewController.h"

// Views
#import "HYHistoryLineChartView.h"

// Controllers
#import "HYChartDetailViewController.h"
#import "HYBaseNavigationController.h"

// Model
#import "HYHistoryDataModel.h"

#import "HYConstants.h"

// Enums (HYCHartViewController)
typedef NS_ENUM(NSInteger, HYCHartViewControllerChartType){
    HYCHartViewControllerChartTypeDot,
	HYCHartViewControllerChartTypeBestFit,
    HYCHartViewControllerChartTypeCount
};

typedef NS_ENUM(NSInteger, HYCHartViewControllerBestFitPoint){
    HYCHartViewControllerBestFitPoint1,
	HYCHartViewControllerBestFitPoint2,
    HYCHartViewControllerBestFitPointCount
};

// Numerics (HYChartLegendView)
CGFloat static const kHYChartLegendViewMarginSize = 15.0f;
CGFloat static const kHYChartLegendViewSeparatorWidth = 0.25f;
CGFloat static const kHYChartLegendViewTitleHeight = 40.0f;

// Numerics (HYChartGridView)
CGFloat static const kHYChartGridViewPadding = 0.0f;//5.0f;

// Numerics (HYCHartViewController)
CGFloat static const kHYCHartViewControllerDotRadius = 4.0f;
CGFloat static const kHYCHartViewControllerLineWidth = 1.0f;

@interface HYChartLegendView : UIView

@property (nonatomic, strong) UILabel *yAxisLabel;
@property (nonatomic, strong) UILabel *xAxisLabel;

@end

@protocol HYChartViewDelegate;

@interface HYChartView : UIView

@property (nonatomic, weak) id<HYChartViewDelegate> delegate;
@property (nonatomic, strong) HYHistoryLineChartView *dotChartView;
@property (nonatomic, strong) HYHistoryLineChartView *bestFitChartView;
@property (nonatomic, strong) HYChartLegendView *chartLegendView;
@property (nonatomic, strong) UILabel *titleLabel;

// Gestures
-  (void)chartViewTapped:(id)sender;

@end

@protocol HYChartViewDelegate <NSObject>

@optional

- (void)didSelectChartView:(HYChartView *)chartView;

@end

@interface HYChartGridView : UIView

@property (nonatomic, strong) NSArray *chartViews;

- (void)reloadData;

@end

@interface HYHistoryChartViewController () <JBLineChartViewDataSource, JBLineChartViewDelegate, HYChartViewDelegate>

@property (nonatomic, strong) HYChartGridView *chartGridView;
@property (nonatomic, strong) NSDictionary *dataModel;

- (void)initDataModel;

@end

@implementation HYHistoryChartViewController

#pragma mark - Alloc/Init

- (id)init
{
    self = [super init];
    if (self)
    {
        [self initDataModel];
    }
    return self;
}

#pragma mark - Data

- (void)initDataModel
{
    NSMutableDictionary *mutableDataModel = [NSMutableDictionary dictionary];
    self.dataModel = [NSMutableDictionary dictionaryWithDictionary:mutableDataModel];
}

#pragma mark - View Lifecycle

- (void)loadView
{
    [super loadView];
    
    self.title = kHYStringLabelAnscombeQuartet;
    
    self.edgesForExtendedLayout = UIRectEdgeNone;

    self.chartGridView = [[HYChartGridView alloc] initWithFrame:self.view.bounds];
    self.view = self.chartGridView;
    
    NSMutableArray *mutableChartGrids = [[NSMutableArray alloc] init];
    for (int chartIndex=0; chartIndex<HYDataModelChartTypeCount; chartIndex++)
    {
        HYChartView *chartView = [[HYChartView alloc] init];
        chartView.delegate = self;
        
        chartView.dotChartView.delegate = self;
        chartView.dotChartView.dataSource = self;
        chartView.dotChartView.tag = HYCHartViewControllerChartTypeDot;
        chartView.dotChartView.userInteractionEnabled = NO;
        chartView.dotChartView.showsLineSelection = NO;
        chartView.dotChartView.showsVerticalSelection = NO;
        ((HYHistoryLineChartView *)chartView.dotChartView).chartIndex = chartIndex;
        
        chartView.bestFitChartView.delegate = self;
        chartView.bestFitChartView.dataSource = self;
        chartView.bestFitChartView.tag = HYCHartViewControllerChartTypeBestFit;
        chartView.bestFitChartView.userInteractionEnabled = NO;
        chartView.bestFitChartView.showsLineSelection = NO;
        chartView.bestFitChartView.showsVerticalSelection = NO;
        ((HYHistoryLineChartView *)chartView.bestFitChartView).chartIndex = chartIndex;
        
        chartView.tag = chartIndex;

        chartView.chartLegendView.xAxisLabel.text = [NSString stringWithFormat:kHYStringLabelXAxis];
        chartView.chartLegendView.yAxisLabel.text = [NSString stringWithFormat:kHYStringLabelYAxis];
        chartView.titleLabel.text = [NSString stringWithFormat:kHYStringLabelChart, chartIndex+1];
        chartView.titleLabel.textColor = [UIColor whiteColor];
        [mutableChartGrids addObject:chartView];
    }
    self.chartGridView.chartViews = [NSArray arrayWithArray:mutableChartGrids];
    
    [self.chartGridView reloadData];
}

#pragma mark - JBLineChartViewDataSource

- (NSUInteger)numberOfLinesInLineChartView:(JBLineChartView *)lineChartView
{
    return 1;
}

- (NSUInteger)lineChartView:(JBLineChartView *)lineChartView numberOfVerticalValuesAtLineIndex:(NSUInteger)lineIndex
{
    if (lineChartView.tag == HYCHartViewControllerChartTypeDot)
    {
        return [[[HYHistoryDataModel sharedInstance] dataForChartType:lineChartView.tag] count];
    }
    else if (lineChartView.tag == HYCHartViewControllerChartTypeBestFit)
    {
        return HYCHartViewControllerBestFitPointCount;
    }
    return 0;
}

- (UIColor *)lineChartView:(JBLineChartView *)lineChartView colorForLineAtLineIndex:(NSUInteger)lineIndex
{
    if (lineChartView.tag == HYCHartViewControllerChartTypeDot)
    {
        return [UIColor clearColor];
    }
    else if (lineChartView.tag == HYCHartViewControllerChartTypeBestFit)
    {
        return kQAColorChartLineColor;
    }
    return nil;
}

- (CGFloat)lineChartView:(JBLineChartView *)lineChartView widthForLineAtLineIndex:(NSUInteger)lineIndex
{
    return kHYCHartViewControllerLineWidth;
}

- (BOOL)lineChartView:(JBLineChartView *)lineChartView showsDotsForLineAtLineIndex:(NSUInteger)lineIndex
{
    return (lineChartView.tag == HYCHartViewControllerChartTypeDot);
}

- (UIColor *)lineChartView:(JBLineChartView *)lineChartView colorForDotAtHorizontalIndex:(NSUInteger)horizontalIndex atLineIndex:(NSUInteger)lineIndex
{
    return kQAColorChartDotColor;
}

- (CGFloat)lineChartView:(JBLineChartView *)lineChartView dotRadiusForLineAtLineIndex:(NSUInteger)lineIndex
{
    return kHYCHartViewControllerDotRadius;
}

- (JBLineChartViewLineStyle)lineChartView:(JBLineChartView *)lineChartView lineStyleForLineAtLineIndex:(NSUInteger)lineIndex
{
    return JBLineChartViewLineStyleSolid;
}

- (BOOL)lineChartView:(JBLineChartView *)lineChartView smoothLineAtLineIndex:(NSUInteger)lineIndex
{
    return NO;
}

#pragma mark - JBLineChartViewDelegate

- (CGFloat)lineChartView:(JBLineChartView *)lineChartView verticalValueForHorizontalIndex:(NSUInteger)horizontalIndex atLineIndex:(NSUInteger)lineIndex
{
    NSArray *data = [[HYHistoryDataModel sharedInstance] dataForChartType:((HYHistoryLineChartView *)lineChartView).chartIndex];
    
    if (lineChartView.tag == HYCHartViewControllerChartTypeDot)
    {
        HYDataPoint *dataPoint = (HYDataPoint *)[data objectAtIndex:horizontalIndex];
        return [dataPoint point].y;
    }
    else if (lineChartView.tag == HYCHartViewControllerChartTypeBestFit)
    {
        HYDataPoint *firstPoint = (HYDataPoint *)[data firstObject];
        HYDataPoint *lastPoint = (HYDataPoint *)[data lastObject];
        
        if (horizontalIndex == HYCHartViewControllerBestFitPoint1)
        {
            return firstPoint.point.y;
        }
        else if (horizontalIndex == HYCHartViewControllerBestFitPoint2)
        {
            return lastPoint.point.y;
        }
    }
    return 0.0f;
}

#pragma mark - HYChartViewDelegate

- (void)didSelectChartView:(HYChartView *)chartView
{
    HYChartDetailViewController *detailViewController = [[HYChartDetailViewController alloc] initWithChartType:chartView.dotChartView.chartIndex];
    HYBaseNavigationController *navigationController = [[HYBaseNavigationController alloc] initWithRootViewController:detailViewController];
    [self.navigationController presentViewController:navigationController animated:YES completion:nil];
}

@end

@implementation HYChartLegendView

#pragma mark - Alloc/Init

- (id)init
{
    self = [super init];
    if (self)
    {
        [self setContentMode:UIViewContentModeRedraw];
        
        _yAxisLabel = [[UILabel alloc] init];
        _yAxisLabel.backgroundColor = [UIColor clearColor];
        _yAxisLabel.textAlignment = NSTextAlignmentCenter;
        _yAxisLabel.textColor = [UIColor whiteColor];
        _yAxisLabel.font = [UIFont italicSystemFontOfSize:8.0f];
        [self addSubview:_yAxisLabel];
        
        _xAxisLabel = [[UILabel alloc] init];
        _xAxisLabel.backgroundColor = [UIColor clearColor];
        _xAxisLabel.textAlignment = NSTextAlignmentCenter;
        _xAxisLabel.textColor = [UIColor whiteColor];
        _xAxisLabel.font = [UIFont italicSystemFontOfSize:8.0f];
        [self addSubview:_xAxisLabel];
    }
    return self;
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:49.0/255.0 green:49.0/255.0 blue:49.0/255.0 alpha:1.0].CGColor);
    CGContextSetLineWidth(context, kHYChartLegendViewSeparatorWidth);
    CGContextSetShouldAntialias(context, YES);

    CGFloat xOffset = kHYChartLegendViewMarginSize - kHYChartLegendViewSeparatorWidth;
    CGFloat yOffset = self.bounds.origin.y;
    
    CGContextSaveGState(context);
    {
        CGContextMoveToPoint(context, xOffset, yOffset);
        yOffset = self.bounds.size.height - kHYChartLegendViewMarginSize + kHYChartLegendViewSeparatorWidth;
        CGContextAddLineToPoint(context, xOffset, yOffset);
        xOffset = CGRectGetMaxX(self.bounds);
        CGContextAddLineToPoint(context, xOffset, yOffset);
        CGContextStrokePath(context);
    }
    CGContextRestoreGState(context);
}

#pragma mark - Layout

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize yAxisLabelSize = [self.yAxisLabel.text sizeWithAttributes:@{NSFontAttributeName:self.yAxisLabel.font}];
    self.yAxisLabel.frame = CGRectMake(self.bounds.origin.x+4.0, ceil((self.bounds.size.height - kHYChartLegendViewMarginSize) * 0.5) - ceil(yAxisLabelSize.height * 0.5), yAxisLabelSize.width, yAxisLabelSize.height);
    
    CGSize xAxisLabelSize = [self.xAxisLabel.text sizeWithAttributes:@{NSFontAttributeName:self.yAxisLabel.font}];
    self.xAxisLabel.frame = CGRectMake(ceil((self.bounds.size.width + kHYChartLegendViewMarginSize) * 0.5) - ceil(xAxisLabelSize.width * 0.5), self.bounds.size.height - kHYChartLegendViewMarginSize+2.0, xAxisLabelSize.width, xAxisLabelSize.height);
}

@end

@implementation HYChartView

#pragma mark - Alloc/Init

- (id)init
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        
        _chartLegendView = [[HYChartLegendView alloc] init];
        _chartLegendView.backgroundColor = [UIColor colorWithRed:49.0/255.0 green:49.0/255.0 blue:49.0/255.0 alpha:1.0];
        [self addSubview:_chartLegendView];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor whiteColor];;
        _titleLabel.font = [UIFont systemFontOfSize:12.0f];
        [self addSubview:_titleLabel];
        
        _bestFitChartView = [[HYHistoryLineChartView alloc] init];
        _bestFitChartView.backgroundColor = [UIColor colorWithRed:60.0/255.0 green:60.0/255.0 blue:60.0/255.0 alpha:1.0];
        [self addSubview:_bestFitChartView];

        _dotChartView = [[HYHistoryLineChartView alloc] init];
        _dotChartView.backgroundColor = [UIColor clearColor];
        [self addSubview:_dotChartView];

        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chartViewTapped:)];
        [self addGestureRecognizer:tapGestureRecognizer];
    }
    return self;
}

#pragma mark - Layout

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize titleSize = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}];
    self.titleLabel.frame = CGRectMake(kHYChartLegendViewMarginSize, self.bounds.origin.y+18.0, self.bounds.size.width - kHYChartLegendViewMarginSize, titleSize.height);

    self.chartLegendView.frame = self.bounds;
    
    self.bestFitChartView.frame = CGRectMake(kHYChartLegendViewMarginSize+10, self.bounds.origin.y + kHYChartLegendViewTitleHeight, self.bounds.size.width - kHYChartLegendViewMarginSize, self.bounds.size.height - kHYChartLegendViewMarginSize - kHYChartLegendViewTitleHeight);
    [self.bestFitChartView reloadData];

    self.dotChartView.frame = CGRectMake(kHYChartLegendViewMarginSize+10, self.bounds.origin.y + kHYChartLegendViewTitleHeight, self.bounds.size.width - kHYChartLegendViewMarginSize, self.bounds.size.height - kHYChartLegendViewMarginSize - kHYChartLegendViewTitleHeight);
    [self.dotChartView reloadData];
}

#pragma mark - Gestures

-  (void)chartViewTapped:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(didSelectChartView:)])
    {
        [self.delegate didSelectChartView:self];
    }
}

@end

@implementation HYChartGridView

#pragma mark - Alloc/Init

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = kHYColorBaseBackgroundColor;
    }
    return self;
}

#pragma mark - Data

- (void)reloadData
{
    for (HYChartView *chartView in self.chartViews)
    {
        if ([chartView isKindOfClass:[HYChartView class]])
        {
            [chartView.bestFitChartView reloadData];
            [chartView.dotChartView reloadData];
        }
    }
}

#pragma mark - Layout

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if ([self.chartViews count] > 0)
    {
        // Layout assumes max 4 charts
        NSAssert([self.chartViews count] == 4, @"HYChartGridView // layout supports exactly 4 charts.");
        
        CGFloat chartWidth = ceil((self.bounds.size.width - (kHYChartGridViewPadding * 3)) * 0.5f);
        CGFloat chartHeight = ceil((self.bounds.size.height - (kHYChartGridViewPadding * 3)) * 0.5f);
        
        CGFloat xOffset = kHYChartGridViewPadding;
        CGFloat yOffset = kHYChartGridViewPadding;
        
        for (HYChartView *chartView in self.chartViews)
        {
            chartView.frame = CGRectMake(xOffset, yOffset, chartWidth, chartHeight);
            
            if (chartView.tag == HYDataModelChartType2)
            {
                yOffset += chartHeight + kHYChartGridViewPadding;
                xOffset = kHYChartGridViewPadding;
            }
            else
            {
                xOffset += chartWidth + kHYChartGridViewPadding;
            }
        }
    }
    
    [self reloadData];
}

#pragma mark - Setters

- (void)setChartViews:(NSArray *)chartViews
{
    for (HYChartView *oldChartView in self.chartViews)
    {
        [oldChartView removeFromSuperview];
    }
    
    for (HYChartView *newChartView in chartViews)
    {
        [self addSubview:newChartView];
    }
    
    _chartViews = chartViews;
    
    [self setNeedsLayout];
}

@end
