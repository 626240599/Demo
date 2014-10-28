//
//  HYChartFooterView.h
//  Demo
//
//  Created by Hanton on 10/26/14.
//  Copyright (c) 2014 Darma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYChartFooterView : UIView

@property (nonatomic, assign) NSInteger sectionCount;
@property (nonatomic, readonly) UILabel *leftLabel;
@property (nonatomic, readonly) UILabel *centerLabel;
@property (nonatomic, readonly) UILabel *rightLabel;

@end
