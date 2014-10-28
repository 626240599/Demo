//
//  HYHistoryDataModel.m
//  Demo
//
//  Created by Hanton on 10/26/14.
//  Copyright (c) 2014 Darma. All rights reserved.
//

#import "HYHistoryDataModel.h"

@interface HYHistoryDataModel ()

@property (nonatomic, strong) NSArray *chartData1;
@property (nonatomic, strong) NSArray *chartData2;
@property (nonatomic, strong) NSArray *chartData3;
@property (nonatomic, strong) NSArray *chartData4;

@end

@interface HYDataPoint ()

@property (nonatomic, assign) CGPoint point;

@end

@implementation HYHistoryDataModel

#pragma mark - Alloc/Init

+ (HYHistoryDataModel *)sharedInstance
{
    static dispatch_once_t pred;
    static HYHistoryDataModel *instance = nil;
    dispatch_once(&pred, ^{
        instance = [[self alloc] init];
    });
	return instance;
}

#pragma mark - Getters

- (NSArray *)dataForChartType:(HYDataModelChartType)chartType sorted:(BOOL)sorted
{
    NSArray *dataArray = nil;
    
    switch (chartType) {
        case HYDataModelChartType1:
            dataArray = self.chartData1;
            break;
        case HYDataModelChartType2:
            dataArray = self.chartData2;
            break;
        case HYDataModelChartType3:
            dataArray = self.chartData3;
            break;
        case HYDataModelChartType4:
            dataArray = self.chartData4;
            break;
        default:
            break;
    }

    if (sorted)
    {
        dataArray = [dataArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            HYDataPoint *dataPoint1 = (HYDataPoint *)obj1;
            HYDataPoint *dataPoint2 = (HYDataPoint *)obj2;
            if (dataPoint1.point.x > dataPoint2.point.x)
            {
                return NSOrderedDescending;
            }
            return NSOrderedAscending;
        }];
    }
    return dataArray;
}

- (NSArray *)dataForChartType:(HYDataModelChartType)chartType
{
    return [self dataForChartType:chartType sorted:YES];
}

- (NSArray *)chartData1
{
    if (_chartData1 == nil)
    {
       _chartData1 = @[[[HYDataPoint alloc] initWithDataPoint:CGPointMake(1.0f, 8.04f)],
                       [[HYDataPoint alloc] initWithDataPoint:CGPointMake(2.0f, 6.95f)],
                       [[HYDataPoint alloc] initWithDataPoint:CGPointMake(3.0f, 7.58f)],
                       [[HYDataPoint alloc] initWithDataPoint:CGPointMake(4.0f, 8.81f)],
                       [[HYDataPoint alloc] initWithDataPoint:CGPointMake(5.0f, 8.33f)],
                       [[HYDataPoint alloc] initWithDataPoint:CGPointMake(6.0f, 9.96f)],
                       [[HYDataPoint alloc] initWithDataPoint:CGPointMake(7.0f, 7.24f)],
                       ];
    }
    return _chartData1;
}

- (NSArray *)chartData2
{
    if (_chartData2 == nil)
    {
        _chartData2 = @[[[HYDataPoint alloc] initWithDataPoint:CGPointMake(1.0f, 9.14f)],
                        [[HYDataPoint alloc] initWithDataPoint:CGPointMake(2.0f, 8.14f)],
                        [[HYDataPoint alloc] initWithDataPoint:CGPointMake(3.0f, 8.74f)],
                        [[HYDataPoint alloc] initWithDataPoint:CGPointMake(4.0f, 8.77f)],
                        [[HYDataPoint alloc] initWithDataPoint:CGPointMake(5.0f, 9.26f)],
                        [[HYDataPoint alloc] initWithDataPoint:CGPointMake(6.0f, 8.10f)],
                        [[HYDataPoint alloc] initWithDataPoint:CGPointMake(7.0f, 6.13f)],
                        ];
    }
    return _chartData2;
}

- (NSArray *)chartData3
{
    if (_chartData3 == nil)
    {
        _chartData3 = @[[[HYDataPoint alloc] initWithDataPoint:CGPointMake(1.0f, 7.46f)],
                        [[HYDataPoint alloc] initWithDataPoint:CGPointMake(2.0f, 6.77f)],
                        [[HYDataPoint alloc] initWithDataPoint:CGPointMake(3.0f, 12.74f)],
                        [[HYDataPoint alloc] initWithDataPoint:CGPointMake(4.0f, 7.11f)],
                        [[HYDataPoint alloc] initWithDataPoint:CGPointMake(5.0f, 7.81f)],
                        [[HYDataPoint alloc] initWithDataPoint:CGPointMake(6.0f, 8.84f)],
                        [[HYDataPoint alloc] initWithDataPoint:CGPointMake(7.0f, 6.08f)],
                        ];
    }
    return _chartData3;
}

- (NSArray *)chartData4
{
    if (_chartData4 == nil)
    {
        _chartData4 = @[[[HYDataPoint alloc] initWithDataPoint:CGPointMake(1.0f, 6.58f)],
                        [[HYDataPoint alloc] initWithDataPoint:CGPointMake(2.0f, 5.76f)],
                        [[HYDataPoint alloc] initWithDataPoint:CGPointMake(3.0f, 7.71f)],
                        [[HYDataPoint alloc] initWithDataPoint:CGPointMake(4.0f, 8.84f)],
                        [[HYDataPoint alloc] initWithDataPoint:CGPointMake(5.0f, 8.47f)],
                        [[HYDataPoint alloc] initWithDataPoint:CGPointMake(6.0f, 7.04f)],
                        [[HYDataPoint alloc] initWithDataPoint:CGPointMake(7.0f, 5.25f)],
                        ];
    }
    return _chartData4;
}

@end

@implementation HYDataPoint

#pragma mark - Alloc/Init

- (id)initWithDataPoint:(CGPoint)point
{
    self = [super init];
    if (self)
    {
        _point = point;
    }
    return self;
}

@end
