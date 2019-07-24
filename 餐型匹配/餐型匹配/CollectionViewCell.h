//
//  CollectionViewCell.h
//  餐型匹配
//
//  Created by liufeng on 2019/7/24.
//  Copyright © 2019 dev.liufeng@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Sickness.h"

NS_ASSUME_NONNULL_BEGIN

@interface CollectionViewCell : UICollectionViewCell
- (void)configWithSickName:(Sickness *)sick;
@end

NS_ASSUME_NONNULL_END
