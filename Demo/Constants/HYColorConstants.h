//
//  HYColorConstants.h
//  Demo
//
//  Created by Hanton on 10/26/14.
//  Copyright (c) 2014 Darma. All rights reserved.
//

#define UIColorFromHex(hex) [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0 green:((float)((hex & 0xFF00) >> 8))/255.0 blue:((float)(hex & 0xFF))/255.0 alpha:1.0]

#pragma mark - Base

#define kHYColorBaseBackgroundColor UIColorFromHex(0xf5f4f0)
#define kHYColorChartLineColor UIColorFromHex(0x222222)
#define kHYColorSparkChartLineColor UIColorFromHex(0x141414)
#define kHYColorRangeViewBackgroundColor UIColorFromHex(0xf6c29a)

#pragma mark - Footer

#define kHYColorChartFooterSeparatorColor UIColorFromHex(0x222222)
#define kHYColorChartFooterSideTextColor UIColorFromHex(0x222222)
#define kHYColorChartFooterCenterTextColor UIColorFromHex(0x787878)

#pragma mark - Header

#define kHYColorChartHeaderTextColor UIColorFromHex(0x222222)
#define kHYColorChartHeaderUnderlineColor UIColorFromHex(0x222222)

#pragma mark - Cells

#define kHYColorUserCellProfileImageStrokeColor UIColorFromHex(0x898989)

#define kHYColorBaseBackgroundColor UIColorFromHex(0xf5f4f0)
#define kHYColorLegendSeparatorColor UIColorFromHex(0x585858)
#define kHYColorLegendTextColor UIColorFromHex(0x585858)
#define kHYColorChartTitleColor UIColorFromHex(0x000000)
#define kQAColorChartDotColor UIColorFromHex(0xe23100)
#define kQAColorChartLineColor [UIColor colorWithRed:0.029f green:0.615f blue:0.843f alpha:0.5f]
#define kQAColorDetailCellTextColor UIColorFromHex(0x242424)
#define kQAColorDetailCellBackgroundColor UIColorFromHex(0xe0e0e0)
#define kQAColorDetailHeaderTextColor UIColorFromHex(0x000000)

