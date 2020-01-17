//
//  Component.h
//  餐型匹配
//
//  Created by liufeng on 2019/7/25.
//  Copyright © 2019 dev.liufeng@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ComponentType.h"

NS_ASSUME_NONNULL_BEGIN

@interface Component : NSObject
@property (nonatomic,strong) ComponentType  *componentType;
@property (nonatomic,copy)   NSString       *desc;
@property (nonatomic,assign) int            priority;
@property (nonatomic,assign) int             ID;
@end

NS_ASSUME_NONNULL_END
