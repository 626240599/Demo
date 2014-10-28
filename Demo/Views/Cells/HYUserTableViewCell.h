//
//  HYUserTableViewCell.h
//  Demo
//
//  Created by Hanton on 10/26/14.
//  Copyright (c) 2014 Darma. All rights reserved.
//

#import <UIKit/UIKit.h>

// Views
#import "HYLineChartView.h"

// Numerics
extern CGFloat const kHYUserTableViewCellHeight;

@interface HYUserTableViewCell : UITableViewCell

@property (nonatomic, readonly) UIImageView *userImageView;
@property (nonatomic, readonly) UILabel *nameLabel;
@property (nonatomic, readonly) UILabel *dateLabel;
@property (nonatomic, readonly) HYLineChartView *lineChartView;

@end
