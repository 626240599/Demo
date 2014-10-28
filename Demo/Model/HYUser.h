//
//  HYUser.h
//  Demo
//
//  Created by Hanton on 10/26/14.
//  Copyright (c) 2014 Darma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// Enums
typedef NS_ENUM(NSInteger, HYUserGender){
    HYUserGenderMale,
    HYUserGenderFemale
};

@interface HYUser : NSObject

@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSDate *createDate;
@property (nonatomic, strong) NSArray *sittingHours;
@property (nonatomic, strong) UIImage *profileImage;
@property (nonatomic, assign) HYUserGender gender;

@end
