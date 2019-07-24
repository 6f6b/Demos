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

#import "Food.h"
#import "Protein.h"
#import "Rice.h"

NS_ASSUME_NONNULL_BEGIN

@interface Meal : NSObject

//蛋白类型
@property (nonatomic,strong) Protein        *protein;
//米饭类型
@property (nonatomic,strong) Rice           *rice;
//食物类型
@property (nonatomic,strong) Food           *food;

//Meal ID
@property (nonatomic,assign) int         ID;
@end

NS_ASSUME_NONNULL_END
