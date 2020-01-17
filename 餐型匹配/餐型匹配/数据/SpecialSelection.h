//
//  SpecialSelection.h
//  餐型匹配
//
//  Created by liufeng on 2019/7/25.
//  Copyright © 2019 dev.liufeng@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef enum : NSUInteger {
    ///无特殊选择
    SpecialSelectionTypeNone,
    ///软米饭
    SpecialSelectionTypePillowyRice
} SpecialSelectionType;

@interface SpecialSelection : NSObject
@property (nonatomic,copy)     NSString                    *selectionName;
@property (nonatomic,assign)   SpecialSelectionType        selectionType;

@property (nonatomic,assign)   int        ID;
@end

NS_ASSUME_NONNULL_END
