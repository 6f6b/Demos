//
//  Rice.h
//  餐型匹配
//
//  Created by 刘丰 on 2019/7/24.
//  Copyright © 2019 dev.liufeng@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
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

NS_ASSUME_NONNULL_BEGIN

@interface Rice : NSObject
@property (nonatomic,assign) RiceType    riceType;
@property (nonatomic,assign) int         priority;

@property (nonatomic,assign) int         ID;
@end

NS_ASSUME_NONNULL_END
