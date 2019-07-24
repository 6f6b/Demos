//
//  Sickness.h
//  餐型匹配
//
//  Created by 刘丰 on 2019/7/20.
//  Copyright © 2019 dev.liufeng@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Sickness : NSObject

//疾病名
@property (nonatomic,copy)    NSString                 *name;

//疾病ID
@property (nonatomic,assign)  NSUInteger                ID;

@property (nonatomic,assign) BOOL selected;
@end

NS_ASSUME_NONNULL_END
