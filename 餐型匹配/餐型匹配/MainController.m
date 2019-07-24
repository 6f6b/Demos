//
//  MainController.m
//  餐型匹配
//
//  Created by liufeng on 2019/7/24.
//  Copyright © 2019 dev.liufeng@gmail.com. All rights reserved.
//

#import "MainController.h"
#import "CollectionViewCell.h"
#import "DataBase.h"
#import "Sickness.h"
#import "Condition.h"

@interface PickerModel : NSObject
@property (nonatomic,copy) NSString *title;
@property (nonatomic,assign) int value;

@end

@implementation PickerModel

@end

@interface MainController ()<UIPickerViewDelegate,UIPickerViewDataSource, UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic,strong) NSArray *dataArray;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bottomConstriant;
@property (strong, nonatomic) IBOutlet UIButton *ageBtn;
@property (strong, nonatomic) IBOutlet UIButton *specialSelectBtn;

@property (strong, nonatomic) IBOutlet UILabel *foodType;
@property (strong, nonatomic) IBOutlet UILabel *proteinType;
@property (strong, nonatomic) IBOutlet UILabel *riceType;
@property (strong, nonatomic) IBOutlet UIPickerView *pickerView;

@property (nonatomic,strong) NSArray *ageArray;
@property (nonatomic,strong) NSArray *specialArray;
@property (nonatomic,assign) BOOL isCurrentArrayAge;

@property (nonatomic,strong) PickerModel *ageModel;
@property (nonatomic,strong) PickerModel *specialModel;
@end

@implementation MainController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    NSArray *sickNames = [DataBase new].sicknesses;
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
    [self.collectionView reloadData];
    
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    
    {
        PickerModel *pickModel1 = [PickerModel new];
        pickModel1.title = @"软米饭";
        pickModel1.value = SpecialSelectionPillowyRice;
        
        PickerModel *pickModel2 = [PickerModel new];
        pickModel2.title = @"无特殊选择";
        pickModel2.value = SpecialSelectionNone;
        
        self.specialArray = @[pickModel1,pickModel2];
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
}
#pragma mark - 计算逻辑

- (Condition *)generateMealWith:(NSArray<Sickness *> *)sicknesses age:(NSUInteger)age specialSelection:(SpecialSelection)specialSelection{
    //第一遍筛选
    NSMutableArray *firstSelections = [NSMutableArray new];
    NSMutableSet *set = [[NSMutableSet alloc] init];
    NSArray *conditions = [DataBase new].conditionTables;
    for (Sickness *sickness in sicknesses) {
        for (Condition *condition in conditions) {
            if (condition.sickness.name != sickness.name) {
                continue;
            }
            if (![condition.ageSection ageLocatedWith:age]) {
                continue;
            }
            if (condition.specialSelection != SpecialSelectionNone && condition.specialSelection != specialSelection) {
                continue;
            }
            //            if ([set containsObject:@(meal.ID)]) {
            //                continue;
            //            }
            //            [set addObject:@(meal.ID)];
            [firstSelections addObject:condition];
        }
    }
    if (firstSelections.count <= 1) {
        return firstSelections.firstObject;
    }
    
    NSArray *secondSelections;
    
    secondSelections = [self filterMealsByFoodTypeWith:firstSelections];
    if (secondSelections.count <= 1) {
        return secondSelections.firstObject;
    }
    
    secondSelections = [self filterMealsByProteinWith:secondSelections];
    if (secondSelections.count <= 1) {
        return secondSelections.firstObject;
    }
    
    secondSelections = [self filterMealsBySpecialSelectionWith:secondSelections];
    if (secondSelections.count) {
        return secondSelections.firstObject;
    }
    
    return nil;
}

- (NSArray *)filterMealsByFoodTypeWith:(NSArray *)conditions{
    NSMutableArray *arr = [NSMutableArray new];
    FoodType priorityFirst = MAXFLOAT;
    for (Condition *condition in conditions) {
        Meal *meal = condition.meal;
        if (meal.foodType < priorityFirst) {
            priorityFirst = meal.foodType;
        }
    }
    for (Condition *condition in conditions) {
        Meal *meal = condition.meal;
        if (meal.foodType == priorityFirst) {
            [arr addObject:condition];
        }
    }
    return arr;
}

- (NSArray *)filterMealsByProteinWith:(NSArray *)conditions{
    NSMutableArray *arr = [NSMutableArray new];
    ProteinType priorityFirst = MAXFLOAT;
    for (Condition *condition in conditions) {
        Meal *meal = condition.meal;
        if (meal.foodType < priorityFirst) {
            priorityFirst = meal.priority;
        }
    }
    for (Condition *condition in conditions) {
        Meal *meal = condition.meal;
        if (meal.priority == priorityFirst) {
            [arr addObject:condition];
        }
    }
    return arr;
}

- (NSArray *)filterMealsBySpecialSelectionWith:(NSArray *)conditions{
    return conditions;
    //    for (Condition *condition in meals) {
    //        if (meal.specialSelection != ) {
    //            priorityFirst = meal.priority;
    //        }
    //    }
    //    return nil;
}

- (void)showMealWith:(Meal *)meal{
    NSString *proteinMessage;
    NSString *riceMessage;
    NSString *foodMessage;
    switch (meal.proteinType) {
        case ProteinTypeNone:
            proteinMessage = @"无蛋白匹配";
            break;
        case ProteinTypeLow:
            proteinMessage = @"低蛋白";
            break;
        case ProteinTypeGeneral:
            proteinMessage = @"普通蛋白";
            break;
        case ProteinTypeHigh:
            proteinMessage = @"高蛋白";
            break;
        default:
            proteinMessage = @"无蛋白匹配";
            break;
    }
    switch (meal.riceType) {
        case RiceTypeNone:
            riceMessage = @"无米饭匹配";
            break;
        case RiceTypeLowProtein:
            riceMessage = @"低蛋白米饭";
            break;
        case RiceTypeCoarse:
            riceMessage = @"杂粮饭";
            break;
        case RiceTypeGeneral:
            riceMessage = @"白米饭";
            break;
        default:
            riceMessage = @"无米饭匹配";
            break;
    }
    switch (meal.foodType) {
        case FoodTypeNone:
            foodMessage = @"无食物匹配";
            break;
        case FoodTypeLiquid:
            foodMessage = @"流食";
            break;
        case FoodTypeSemiliquid:
            foodMessage = @"半流食";
            break;
        case FoodTypePap:
            foodMessage = @"软食";
            break;
        case FoodTypeNormal:
            foodMessage = @"普食";
            break;
        default:
            foodMessage = @"无食物匹配";
            break;
    }
    self.foodType.text = [NSString stringWithFormat:@"食物类型：%@",foodMessage];
    self.proteinType.text = [NSString stringWithFormat:@"蛋白类型：%@",proteinMessage];
    self.riceType.text = [NSString stringWithFormat:@"米饭类型：%@",riceMessage];
}

#pragma mark - pickerview

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSArray *arr = self.isCurrentArrayAge ? self.ageArray : self.specialArray;
    PickerModel *pick = arr[row];
    return pick.title;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    NSArray *arr = self.isCurrentArrayAge ? self.ageArray : self.specialArray;
    return arr.count;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSArray *arr = self.isCurrentArrayAge ? self.ageArray : self.specialArray;
    PickerModel *pickModel = arr[row];
    if (self.isCurrentArrayAge) {
        self.ageModel = pickModel;
    }else{
        self.specialModel = pickModel;
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

    [self.ageBtn setTitle:ageTitle forState:UIControlStateNormal];
    [self.specialSelectBtn setTitle:specialTitle forState:UIControlStateNormal];
}

- (IBAction)clickAge:(id)sender {
    self.isCurrentArrayAge = YES;
    [self.pickerView reloadAllComponents];
    [UIView animateWithDuration:0.5 animations:^{
        self.bottomConstriant.constant = 0;
        [self.view layoutIfNeeded];
    }];
    
}
- (IBAction)clickSpecialBtn:(id)sender {
    self.isCurrentArrayAge = NO;
    [self.pickerView reloadAllComponents];
    [UIView animateWithDuration:0.5 animations:^{
        self.bottomConstriant.constant = 0;
        [self.view layoutIfNeeded];
    }];
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
    Condition *condition = [self generateMealWith:sicks age:self.ageModel.value specialSelection:self.specialModel.value];
    [self showMealWith:condition.meal];
}
@end
