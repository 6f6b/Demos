//
//  MainController.m
//  餐型匹配
//
//  Created by liufeng on 2019/7/24.
//  Copyright © 2019 dev.liufeng@gmail.com. All rights reserved.
//

#import "MainController.h"
#import "数据/Component.h"
#import "CollectionViewCell.h"
#import "DataBase.h"
#import "Sickness.h"
#import "Condition.h"
#import "CollectionHeaderView.h"

@interface PickerModel : NSObject
@property (nonatomic,copy) NSString *title;
@property (nonatomic,assign) NSInteger value;

@end

@implementation PickerModel

@end

@interface MainController ()<UIPickerViewDelegate,UIPickerViewDataSource, UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic,strong) NSArray *dataArray;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bottomConstriant;

@property (strong, nonatomic) IBOutlet UIButton *ageBtn;
@property (strong, nonatomic) IBOutlet UIButton *specialSelectBtn;
@property (strong, nonatomic) IBOutlet UIButton *exTimesBtn;
@property (strong, nonatomic) IBOutlet UIButton *startBtn;

@property (strong, nonatomic) IBOutlet UILabel *foodType;
@property (strong, nonatomic) IBOutlet UIPickerView *pickerView;

@property (nonatomic,strong) NSArray *ageArray;
@property (nonatomic,strong) NSArray *specialArray;
@property (nonatomic,strong) NSArray *exTimesArray;

@property (nonatomic,assign) BOOL isCurrentArrayAge;

@property (nonatomic,strong) PickerModel *ageModel;
@property (nonatomic,strong) PickerModel *specialModel;
@property (nonatomic,strong) PickerModel *extimeModel;

@end

@implementation MainController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    NSArray *sickNames = [DataBase shareinstance].sicknessTable;
    NSMutableArray *arr = [NSMutableArray new];
    for (NSArray *sicks in sickNames) {
        NSMutableArray *subArr = [NSMutableArray new];
        for (NSString *sickname in sicks) {
            Sickness *sick = [Sickness new];
            sick.name = sickname;
            sick.selected = NO;
            [subArr addObject:sick];
        }
        [arr addObject:subArr];
    }
    self.dataArray = arr;
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CollectionViewCell"];
    [self.collectionView registerClass:[CollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CollectionHeaderView"];
    [self.collectionView reloadData];
    
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    
    {
        PickerModel *pickModel1 = [PickerModel new];
        pickModel1.title = @"软米饭";
        pickModel1.value = SpecialSelectionTypePillowyRice;
        
        PickerModel *pickModel2 = [PickerModel new];
        pickModel2.title = @"无特殊选择";
        pickModel2.value = SpecialSelectionTypeNone;
        
        self.specialArray = @[pickModel2,pickModel1];
    }
    
    {
        NSMutableArray *arr = [NSMutableArray new];
        for (int i=1; i<150; i++) {
            PickerModel *pickModel = [PickerModel new];
            pickModel.title = [NSString stringWithFormat:@"%d岁",i];
            pickModel.value = i;
            [arr addObject:pickModel];
        }
        self.ageArray = arr;
    }
    {
        NSMutableArray *arr = [NSMutableArray new];
        NSArray *timeArr = @[@1,@10,@100,@1000,@10000,@100000];
        for (int i=0; i<timeArr.count; i++) {
            PickerModel *pickModel = [PickerModel new];
            pickModel.title = [NSString stringWithFormat:@"%@次",timeArr[i]];
            pickModel.value = [timeArr[i] integerValue];
            [arr addObject:pickModel];
        }
        self.exTimesArray = arr;
    }
    self.ageModel = self.ageArray[0];
    self.specialModel = self.specialArray[0];
    self.extimeModel = self.exTimesArray[0];
    [self refreshBtn];
}

#pragma mark - 计算逻辑
- (Meal *)generateMealWith:(NSArray<Sickness *> *)sicknesses age:(NSUInteger)age specialSelection:(SpecialSelectionType )specialSelectionType{
    //第一遍条件筛选
    NSMutableArray *firstSelections = [NSMutableArray new];
    NSArray *conditions = [DataBase shareinstance].conditionTable;
    for (Sickness *sickness in sicknesses) {
        for (Condition *condition in conditions) {
            if (condition.sickness.name != sickness.name) {
                continue;
            }
            if (![condition.ageSection ageLocatedWith:age]) {
                continue;
            }
            if (condition.specialSelection.selectionType != SpecialSelectionTypeNone && condition.specialSelection.selectionType != specialSelectionType) {
                continue;
            }
            [firstSelections addObject:condition];
        }
    }
    if (firstSelections.count <= 1) {
        Condition *condition = firstSelections.firstObject;
        return condition.meal;
    }

    Meal *meal = [Meal new];
    
    NSArray *componentTypes = [DataBase shareinstance].componentTypeTable;
    NSMutableArray *finalComponents = [NSMutableArray new];
    for (ComponentType *componentType in componentTypes) {
        Component *selectedComponent = nil;
        for (Condition *condition in firstSelections) {
            for (Component *component in condition.meal.components) {
                if (component.componentType.desc == componentType.desc) {
                    if (!selectedComponent) {
                        selectedComponent = component;
                        break;
                    }
                    if (component.priority < selectedComponent.priority) {
                        selectedComponent = component;
                        break;
                    }
                }
            }
        }
        if (selectedComponent) {
            //NSLog(@"添加组件：%@",selectedComponent.desc);
            [finalComponents addObject:selectedComponent];
        }
    }
    
    meal.components = finalComponents;
    return meal;
}

- (void)showMealWith:(Meal *)meal time:(float)time{
    float avTime = time/self.extimeModel.value;
    NSString *desc = [NSString stringWithFormat:@"执行：%ld次，总耗时：%f 秒，平均每次耗时：%f 秒\n\n",(long)self.extimeModel.value,time,avTime];
    
    for (Component *component in meal.components) {
        desc = [NSString stringWithFormat:@"%@%@:%@\n",desc,component.componentType.desc,component.desc];
    }
    self.foodType.text = desc;
}

#pragma mark - pickerview

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSArray *arr = [self pickerViewArray];
    PickerModel *pick = arr[row];
    return pick.title;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    NSArray *arr = [self pickerViewArray];
    return arr.count;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSArray *arr = [self pickerViewArray];
    PickerModel *pickModel = arr[row];
    if (self.ageBtn.isSelected) {
        self.ageModel = pickModel;
    }
    else if (self.specialSelectBtn.isSelected) {
        self.specialModel = pickModel;
    }
    else if (self.exTimesBtn.isSelected){
        self.extimeModel = pickModel;
    }
}

#pragma mark - collectionview
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.dataArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSArray *arr = self.dataArray[section];
    return arr.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    Sickness *sick = self.dataArray[indexPath.section][indexPath.row];
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell" forIndexPath:indexPath];
    [cell configWithSickName:sick];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        CollectionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CollectionHeaderView" forIndexPath:indexPath];
        headerView.frame = CGRectMake(0, 0, 500, 30);
        headerView.backgroundColor = [UIColor redColor];
        return headerView;
    }
    return [UICollectionReusableView new];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    Sickness *sick = self.dataArray[indexPath.section][indexPath.row];
    sick.selected = !sick.selected;
    [collectionView reloadItemsAtIndexPaths:@[indexPath]];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    Sickness *sick = self.dataArray[indexPath.section][indexPath.row];
    CGSize size = [sick.name boundingRectWithSize:CGSizeMake(1000, 1000) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
    return CGSizeMake(size.width + 10, 40);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
}

#pragma mark - actions

- (IBAction)clickSure:(id)sender {
    [UIView animateWithDuration:0.5 animations:^{
        self.bottomConstriant.constant = -300;
        [self.view layoutIfNeeded];
    }];
    [self refreshBtn];
}

- (void)refreshBtn{
    NSString *ageTitle = self.ageModel.title ? self.ageModel.title : @"年龄";
    NSString *specialTitle = self.specialModel.title ? self.specialModel.title : @"特殊选择";
    NSString *exTimeTitle = self.extimeModel.title ? self.extimeModel.title : @"执行次数";

    [self.ageBtn setTitle:ageTitle forState:UIControlStateNormal];
    [self.specialSelectBtn setTitle:specialTitle forState:UIControlStateNormal];
    [self.exTimesBtn setTitle:exTimeTitle forState:UIControlStateNormal];

}

- (IBAction)clickAge:(id)sender {
    [self.ageBtn setSelected:YES];
    [self.specialSelectBtn setSelected:NO];
    [self.exTimesBtn setSelected:NO];
    [self.pickerView reloadAllComponents];
    [UIView animateWithDuration:0.5 animations:^{
        self.bottomConstriant.constant = 0;
        [self.view layoutIfNeeded];
    }];
    
}
- (IBAction)clickSpecialBtn:(id)sender {
    [self.ageBtn setSelected:NO];
    [self.specialSelectBtn setSelected:YES];
    [self.exTimesBtn setSelected:NO];

    [self.pickerView reloadAllComponents];
    [UIView animateWithDuration:0.5 animations:^{
        self.bottomConstriant.constant = 0;
        [self.view layoutIfNeeded];
    }];
}
- (IBAction)clickExTimesBtn:(id)sender {
    [self.ageBtn setSelected:NO];
    [self.specialSelectBtn setSelected:NO];
    [self.exTimesBtn setSelected:YES];
    
    [self.pickerView reloadAllComponents];
    [UIView animateWithDuration:0.5 animations:^{
        self.bottomConstriant.constant = 0;
        [self.view layoutIfNeeded];
    }];
}

- (NSArray *)pickerViewArray{
    if (self.ageBtn.selected) {
        return self.ageArray;
    }
    if (self.specialSelectBtn.selected) {
        return self.specialArray;
    }
    if (self.exTimesBtn.selected) {
        return self.exTimesArray;
    }
    return nil;
}

- (IBAction)clickStart:(id)sender {
    NSMutableArray *sicks = [NSMutableArray new];
    for (NSArray *sickss in self.dataArray) {
        for (Sickness *sick in sickss) {
            if (sick.selected) {
                [sicks addObject:sick];
            }
        }
    }
    
    Meal *meal;
    NSTimeInterval beforeTime = [NSDate date].timeIntervalSince1970;
    for (int i=0; i<self.extimeModel.value; i++) {
        meal = [self generateMealWith:sicks age:self.ageModel.value specialSelection:self.specialModel.value];
    }
    NSTimeInterval afterTime = [NSDate date].timeIntervalSince1970;
    [self showMealWith:meal time:afterTime-beforeTime];
}
@end
