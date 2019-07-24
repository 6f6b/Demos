//
//  Condition.h
//  餐型匹配
//
//  Created by 刘丰 on 2019/7/21.
//  Copyright © 2019 dev.liufeng@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AgeSection.h"
#import "Sickness.h"
#import "Meal.h"

typedef enum : NSUInteger {
    ///无特殊选择
    SpecialSelectionNone,
    ///软米饭
    SpecialSelectionPillowyRice
} SpecialSelection;
NS_ASSUME_NONNULL_BEGIN

@interface Condition : NSObject
//年龄区间
@property (nonatomic,strong) AgeSection         *ageSection;
//特殊选择
@property (nonatomic,assign) SpecialSelection   specialSelection;
//疾病
@property (nonatomic,strong) Sickness           *sickness;


//该条件下对应的meal
@property (nonatomic,strong) Meal               *meal;
@end

NS_ASSUME_NONNULL_END
