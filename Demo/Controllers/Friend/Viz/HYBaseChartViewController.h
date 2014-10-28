//
//  HYBaseChartViewController.h
//  Demo
//
//  Created by Hanton on 10/26/14.
//  Copyright (c) 2014 Darma. All rights reserved.
//

#import "HYBaseViewController.h"

// Views
#import "HYChartTooltipView.h"
#import "JBChartView.h"

@interface HYBaseChartViewController : HYBaseViewController

@property (nonatomic, strong, readonly) HYChartTooltipView *tooltipView;
@property (nonatomic, assign) BOOL tooltipVisible;

// Settres
- (void)setTooltipVisible:(BOOL)tooltipVisible animated:(BOOL)animated atTouchPoint:(CGPoint)touchPoint;
- (void)setTooltipVisible:(BOOL)tooltipVisible animated:(BOOL)animated;

// Getters
- (JBChartView *)chartView; // subclasses to return chart instance for tooltip functionality

@end
