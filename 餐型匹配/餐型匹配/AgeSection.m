//
//  AgeSection.m
//  餐型匹配
//
//  Created by 刘丰 on 2019/7/20.
//  Copyright © 2019 dev.liufeng@gmail.com. All rights reserved.
//

#import "AgeSection.h"

@implementation AgeSection

- (BOOL)ageLocatedWith:(NSUInteger)age{
    NSUInteger compareSmall = self.leftClose  ? (self.smaller) : (self.smaller + 1);
    NSUInteger compareLarge = self.rightClose ? (self.larger)  : (self.larger - 1);
    if (age >= compareSmall && age <= compareLarge) {
        return YES;
    }
    return NO;
}
@end
