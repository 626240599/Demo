//
//  HYDataModel.h
//  Demo
//
//  Created by Hanton on 10/26/14.
//  Copyright (c) 2014 Darma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HYUser.h"

@interface HYDataModel : NSObject

+ (HYDataModel *)sharedInstance;
- (HYUser *)currentUser;

// Metrics
- (CGFloat)maximumStepValue;
- (CGFloat)minimumStepValue;
- (CGFloat)averageStepValue;

@end
