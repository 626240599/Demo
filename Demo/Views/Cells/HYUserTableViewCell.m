//
//  HYUserTableViewCell.m
//  Demo
//
//  Created by Hanton on 10/26/14.
//  Copyright (c) 2014 Darma. All rights reserved.
//

#import "HYUserTableViewCell.h"
#import <QuartzCore/QuartzCore.h>
#import "HYConstants.h"

// Numerics
CGFloat const kHYUserTableViewCellPadding = 10.0f;
CGFloat const kHYUserTableViewCellProfilePhotoPadding = 2.0f;
CGFloat const kHYUserTableViewCellHeight = 80.0f;
CGFloat const kHYUserTableViewCellNameLabelHeight = 25.0f;
CGFloat const kHYUserTableViewCellDateLabelHeight = 15.0f;
CGFloat const kHYUserTableViewCellProfileImageBorderWidth = 0.5f;

@interface HYUserTableViewCell ()

@property (nonatomic, strong) UIView *userImageViewBackground;

// Getters
- (CGSize)userImageViewBackgroundSize;
- (CGRect)userImageViewBackgroundRect;
- (CGSize)userImageViewSize;
- (CGRect)userImageViewRect;
- (CGSize)lineChartViewSize;
- (CGRect)lineChartViewRect;

@end

@implementation HYUserTableViewCell

#pragma mark - Alloc/Init

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _userImageViewBackground = [[UIView alloc] initWithFrame:[self userImageViewBackgroundRect]];
        _userImageViewBackground.layer.cornerRadius = ceil([self userImageViewBackgroundRect].size.width * 0.5);
        _userImageViewBackground.layer.masksToBounds = YES;
        _userImageViewBackground.backgroundColor = [UIColor clearColor];
        _userImageViewBackground.layer.borderColor = kHYColorUserCellProfileImageStrokeColor.CGColor;
        _userImageViewBackground.layer.borderWidth = kHYUserTableViewCellProfileImageBorderWidth;
        [self addSubview:_userImageViewBackground];
        
        _userImageView = [[UIImageView alloc] initWithFrame:[self userImageViewRect]];
        _userImageView.layer.cornerRadius = ceil([self userImageViewRect].size.width * 0.5);
        _userImageView.layer.masksToBounds = YES;
        [self addSubview:_userImageView];
        
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.numberOfLines = 1;
        _nameLabel.font = kHYFontUserTableCellName;
        _nameLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_nameLabel];
        
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.backgroundColor = [UIColor clearColor];
        _dateLabel.numberOfLines = 1;
        _dateLabel.font = kHYFontUserTableCellDate;
        _dateLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_dateLabel];
        
        _lineChartView = [[HYLineChartView alloc] initWithFrame:[self lineChartViewRect]];
        [self addSubview:_lineChartView];
    }
    return self;
}

#pragma mark - Layout

- (void)layoutSubviews
{
    [super layoutSubviews];

    // User image background
    self.userImageViewBackground.frame = [self userImageViewBackgroundRect];
    
    // User image
    self.userImageView.frame = [self userImageViewRect];
    
    // Line chart
    self.lineChartView.frame = [self lineChartViewRect];

    CGFloat availableLabelWidth = self.bounds.size.width - self.userImageView.frame.size.width - self.lineChartView.frame.size.width - (kHYUserTableViewCellPadding * 4);
    
    // Labels
    self.nameLabel.frame = CGRectMake(CGRectGetMaxX(self.userImageView.frame) + kHYUserTableViewCellPadding, kHYUserTableViewCellPadding, availableLabelWidth, kHYUserTableViewCellNameLabelHeight);
    self.dateLabel.frame = CGRectMake(CGRectGetMaxX(self.userImageView.frame) + kHYUserTableViewCellPadding, CGRectGetMaxY(self.nameLabel.frame), availableLabelWidth, kHYUserTableViewCellDateLabelHeight);
}

#pragma mark - Getters

- (CGSize)userImageViewBackgroundSize
{
    return CGSizeMake(kHYUserTableViewCellHeight - (kHYUserTableViewCellPadding * 2), kHYUserTableViewCellHeight - (kHYUserTableViewCellPadding * 2));
}

- (CGRect)userImageViewBackgroundRect
{
    return CGRectMake(kHYUserTableViewCellPadding, kHYUserTableViewCellPadding, [self userImageViewBackgroundSize].width, [self userImageViewBackgroundSize].height);
}

- (CGSize)userImageViewSize
{
    return CGSizeMake(kHYUserTableViewCellHeight - (kHYUserTableViewCellPadding * 2) - (kHYUserTableViewCellProfilePhotoPadding * 2), kHYUserTableViewCellHeight - (kHYUserTableViewCellPadding * 2) - (kHYUserTableViewCellProfilePhotoPadding * 2));
}

- (CGRect)userImageViewRect
{
    return CGRectMake(kHYUserTableViewCellPadding + kHYUserTableViewCellProfilePhotoPadding, kHYUserTableViewCellPadding + kHYUserTableViewCellProfilePhotoPadding, [self userImageViewSize].width, [self userImageViewSize].height);
}

- (CGSize)lineChartViewSize
{
    return CGSizeMake(kHYUserTableViewCellHeight - (kHYUserTableViewCellPadding * 2), kHYUserTableViewCellHeight - (kHYUserTableViewCellPadding * 2));
}

- (CGRect)lineChartViewRect
{
    return CGRectMake(self.bounds.size.width - [self lineChartViewSize].width - kHYUserTableViewCellPadding, kHYUserTableViewCellPadding, [self lineChartViewSize].width, [self lineChartViewSize].height);
}

@end
