//
//  ViewController.m
//  餐型匹配
//
//  Created by 刘丰 on 2019/7/19.
//  Copyright © 2019 dev.liufeng@gmail.com. All rights reserved.
//

#import "ViewController.h"
#import "Condition.h"

#import "DataBase.h"

@interface ViewController ()
@property (nonatomic,strong) NSArray *conditions;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.conditions = [DataBase new].conditionTables;
    NSArray *sicknames = @[@"糖尿病肾病",@"肾功能不全",@"肾功能不全伴并发症",@"急性胆囊炎缓解中期"];
    NSMutableArray *sicks = [NSMutableArray new];
    for (NSString *sickName in sicknames) {
        Sickness *sick = [Sickness new];
        sick.name = sickName;
        [sicks addObject:sick];
    }
    Condition *condition = [self generateMealWith:sicks age:66 specialSelection:SpecialSelectionPillowyRice];
    [self showMealWith:condition.meal];
}

- (Condition *)generateMealWith:(NSArray<Sickness *> *)sicknesses age:(NSUInteger)age specialSelection:(SpecialSelection)specialSelection{
    //第一遍筛选
    NSMutableArray *firstSelections = [NSMutableArray new];
    NSMutableSet *set = [[NSMutableSet alloc] init];
    for (Sickness *sickness in sicknesses) {
        for (Condition *condition in self.conditions) {
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
    NSLog(@"食物类型：%@",foodMessage);
    NSLog(@"蛋白类型：%@",proteinMessage);
    NSLog(@"米饭类型：%@",riceMessage);
}

@end
