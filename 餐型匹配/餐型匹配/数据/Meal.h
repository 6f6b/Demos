//
//  Meal.h
//  餐型匹配
//
//  Created by 刘丰 on 2019/7/19.
//  Copyright © 2019 dev.liufeng@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AgeSection.h"
#import "Sickness.h"

NS_ASSUME_NONNULL_BEGIN

@interface Meal : NSObject

@property (nonatomic,strong) NSArray *components;

//Meal ID
@property (nonatomic,assign) NSUInteger     ID;
@end

NS_ASSUME_NONNULL_END
