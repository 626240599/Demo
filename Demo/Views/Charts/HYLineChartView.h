//
//  HYLineChartView.h
//  Demo
//
//  Created by Hanton on 10/26/14.
//  Copyright (c) 2014 Darma. All rights reserved.
//

#import "JBLineChartView.h"

// Model
#import "HYUser.h"

@class HYLineChartView;

@protocol HYLineChartViewDataSource <JBLineChartViewDataSource>

@optional

- (NSUInteger)minimumAverageInLineChartView:(JBLineChartView *)lineChartView;
- (NSUInteger)maximumAverageInLineChartView:(JBLineChartView *)lineChartView;

@end

@interface HYLineChartView : JBLineChartView

@property (nonatomic, weak) id<HYLineChartViewDataSource> dataSource;

@property (nonatomic, strong) HYUser *user;

@end
