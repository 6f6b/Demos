//
//  Protein.h
//  餐型匹配
//
//  Created by 刘丰 on 2019/7/24.
//  Copyright © 2019 dev.liufeng@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

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

NS_ASSUME_NONNULL_BEGIN

@interface Protein : NSObject
@property (nonatomic,assign) ProteinType proteinType;
@property (nonatomic,assign) int         priority;

@property (nonatomic,assign) int         ID;
@end

NS_ASSUME_NONNULL_END
