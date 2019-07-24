//
//  AgeSection.h
//  餐型匹配
//
//  Created by 刘丰 on 2019/7/20.
//  Copyright © 2019 dev.liufeng@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/*年龄区间*/
@interface AgeSection : NSObject

//年龄区间左端点
@property (nonatomic,assign) NSUInteger     smaller;
//年龄区间右端点
@property (nonatomic,assign) NSUInteger     larger;
//左边是否闭合
@property (nonatomic,assign) BOOL           leftClose;
//右边是否闭合
@property (nonatomic,assign) BOOL           rightClose;

- (BOOL)ageLocatedWith:(NSUInteger)age;
@end

NS_ASSUME_NONNULL_END
