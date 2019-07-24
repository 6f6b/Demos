//
//  Food.h
//  餐型匹配
//
//  Created by 刘丰 on 2019/7/24.
//  Copyright © 2019 dev.liufeng@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    ///无流食
    FoodTypeNone,
    ///流食
    FoodTypeLiquid,
    ///半流食
    FoodTypeSemiliquid,
    ///软食
    FoodTypePap,
    ///普食
    FoodTypeNormal
} FoodType;


NS_ASSUME_NONNULL_BEGIN

@interface Food : NSObject
@property (nonatomic,assign) FoodType    foodType;
@property (nonatomic,assign) int         priority;

@property (nonatomic,assign) int         ID;
@end

NS_ASSUME_NONNULL_END
