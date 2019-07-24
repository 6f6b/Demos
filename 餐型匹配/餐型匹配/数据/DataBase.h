//
//  DataBase.h
//  餐型匹配
//
//  Created by 刘丰 on 2019/7/20.
//  Copyright © 2019 dev.liufeng@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Meal.h"

NS_ASSUME_NONNULL_BEGIN

@interface DataBase : NSObject
+ (instancetype)shareinstance;

@property (nonatomic,strong) NSArray *sicknessTable;
@property (nonatomic,strong) NSArray *conditionTable;

@end

NS_ASSUME_NONNULL_END
