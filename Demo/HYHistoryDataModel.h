//
//  HYHistoryDataModel.h
//  Demo
//
//  Created by Hanton on 10/26/14.
//  Copyright (c) 2014 Darma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// Enums
typedef NS_ENUM(NSInteger, HYDataModelChartType){
    HYDataModelChartType1,
	HYDataModelChartType2,
    HYDataModelChartType3,
    HYDataModelChartType4,
    HYDataModelChartTypeCount
};

@interface HYDataPoint : NSObject

- (id)initWithDataPoint:(CGPoint)point;

@property (nonatomic, readonly) CGPoint point;

@end

@interface HYHistoryDataModel : NSObject

+ (HYHistoryDataModel *)sharedInstance;

- (NSArray *)dataForChartType:(HYDataModelChartType)chartType; // default sorted
- (NSArray *)dataForChartType:(HYDataModelChartType)chartType sorted:(BOOL)sorted;

@end
