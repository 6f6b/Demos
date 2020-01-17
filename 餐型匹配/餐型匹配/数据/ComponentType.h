//
//  ComponentType.h
//  餐型匹配
//
//  Created by liufeng on 2019/7/25.
//  Copyright © 2019 dev.liufeng@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ComponentType : NSObject
@property (nonatomic,copy) NSString *desc;
@property (nonatomic,assign) int     priority;

//type的ID
@property (nonatomic,assign) int         ID;
@end

NS_ASSUME_NONNULL_END
