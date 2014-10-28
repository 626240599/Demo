//
//  HYLineChartView.m
//  Demo
//
//  Created by Hanton on 10/26/14.
//  Copyright (c) 2014 Darma. All rights reserved.
//

#import "HYLineChartView.h"
#import "HYDataModel.h"
#import "HYConstants.h"

@interface HYLineChartView ()

@property (nonatomic, strong) UIView *averageRangeView;
@property (nonatomic, strong) UILabel *lastValueLabel;

@end

@interface HYLineChartView (Private)

- (CGFloat)availableHeight;

@end

@implementation HYLineChartView

#pragma mark - Alloc/Init

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _averageRangeView = [[UIView alloc] init];
        _averageRangeView.backgroundColor = kHYColorRangeViewBackgroundColor;
        [self addSubview:_averageRangeView];
        
        _lastValueLabel = [[UILabel alloc] init];
        [self addSubview:_lastValueLabel];
    }
    return self;
}

#pragma mark - Layout

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSUInteger minimumAverage = 0;
    if ([self.dataSource respondsToSelector:@selector(minimumAverageInLineChartView:)])
    {
        minimumAverage = [self.dataSource minimumAverageInLineChartView:self];
    }
    CGFloat yOffsetTop = (((CGFloat)minimumAverage) / self.maximumValue) * [self availableHeight];
    
    NSUInteger maximumAverage = 0;
    if ([self.dataSource respondsToSelector:@selector(maximumAverageInLineChartView:)])
    {
        maximumAverage = [self.dataSource maximumAverageInLineChartView:self];
    }
    CGFloat yOffsetBottom = (((CGFloat)maximumAverage) / self.maximumValue) * [self availableHeight];
        
    self.averageRangeView.frame = CGRectMake(0, yOffsetTop, self.bounds.size.width, self.bounds.size.height - yOffsetTop - yOffsetBottom);
}

#pragma mark - Data

- (void)reloadData
{
    [super reloadData];
    self.averageRangeView.hidden = !(([self.dataSource respondsToSelector:@selector(minimumAverageInLineChartView:)] && [self.dataSource respondsToSelector:@selector(maximumAverageInLineChartView:)]));
}

@end
