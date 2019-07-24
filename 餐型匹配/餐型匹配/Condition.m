//
//  Condition.m
//  餐型匹配
//
//  Created by 刘丰 on 2019/7/21.
//  Copyright © 2019 dev.liufeng@gmail.com. All rights reserved.
//

#import "Condition.h"

@implementation Condition
- (instancetype)init{
    if (self = [super init]) {
//        self.ageSection
        self.specialSelection = SpecialSelectionNone;
    }
    return self;
}
@end
