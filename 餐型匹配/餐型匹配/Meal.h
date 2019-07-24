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

typedef enum : NSUInteger {
    ///无蛋白
    ProteinTypeNone,
    ///低蛋白
    ProteinTypeLow,
    ///高蛋白
    ProteinTypeHigh,
    ///普通蛋白
    ProteinTypeGeneral
} ProteinType;

typedef enum : NSUInteger {
    ///无米饭
    RiceTypeNone,
    ///低蛋白米饭
    RiceTypeLowProtein,
    ///白米饭
    RiceTypeGeneral,
    ///杂粮饭
    RiceTypeCoarse
} RiceType;

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

@interface Meal : NSObject

//蛋白类型
@property (nonatomic,assign) ProteinType        proteinType;
//米饭类型
@property (nonatomic,assign) RiceType           riceType;
//食物类型
@property (nonatomic,assign) FoodType           foodType;

//校验优先级
@property (nonatomic,assign) NSUInteger         priority;

//Meal ID
@property (nonatomic,assign) NSUInteger         ID;
@end

NS_ASSUME_NONNULL_END
