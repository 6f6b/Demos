//
//  CollectionViewCell.m
//  餐型匹配
//
//  Created by liufeng on 2019/7/24.
//  Copyright © 2019 dev.liufeng@gmail.com. All rights reserved.
//

#import "CollectionViewCell.h"
@interface CollectionViewCell ()
@property (strong, nonatomic) IBOutlet UILabel *sickName;
@end
@implementation CollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.layer.cornerRadius = 5;
    self.contentView.clipsToBounds = true;
    self.contentView.layer.borderColor = [UIColor blackColor].CGColor;
}

- (void)configWithSickName:(Sickness *)sick{
    UIColor *color = sick.selected ? [UIColor redColor] : [UIColor lightGrayColor];
    self.contentView.backgroundColor = color;
    self.sickName.text = sick.name;
}

@end
