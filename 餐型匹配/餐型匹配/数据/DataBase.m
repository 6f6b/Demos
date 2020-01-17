//
//  DataBase.m
//  餐型匹配
//
//  Created by 刘丰 on 2019/7/20.
//  Copyright © 2019 dev.liufeng@gmail.com. All rights reserved.
//

#import "DataBase.h"
#import "Condition.h"

#import "Component.h"

#define Priority_0 0
#define Priority_1 1
#define Priority_2 2
#define Priority_3 3
#define Priority_4 4
#define Priority_5 5

@interface DataBase ()
@property (nonatomic,assign) NSUInteger idNum;
@end
@implementation DataBase

+ (instancetype)shareinstance {
    static DataBase *_sharedSingleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedSingleton = [[super allocWithZone:NULL] init];
        _sharedSingleton.idNum = 0;
        [_sharedSingleton initialData];
    });
    return _sharedSingleton;
}

- (Meal *)createAMeal{
    Meal *meal = [Meal new];
    self.idNum += 1;
    meal.ID = self.idNum;
    return meal;
}

- (void)initialData{
    [self createSicknesses];
    
    NSMutableArray *conditionTables = [NSMutableArray new];
    
    /*组件类型*/
    ComponentType *componentTypeFood = [ComponentType new];    //食物
    componentTypeFood.desc = @"食物";
    componentTypeFood.priority = Priority_0;
    
    ComponentType *componentTypeProtein = [ComponentType new]; //蛋白质
    componentTypeProtein.desc = @"蛋白质";
    componentTypeProtein.priority = Priority_1;
    
    ComponentType *componentTypeRice = [ComponentType new];     //米饭
    componentTypeRice.desc = @"米饭";
    componentTypeRice.priority = Priority_2;
    
    self.componentTypeTable = @[componentTypeFood,componentTypeProtein,componentTypeRice];
    /*食物*/
    
    Component *foodNone = [Component new];
    foodNone.componentType = componentTypeFood;
    foodNone.desc = @"无食物";
    foodNone.priority = Priority_0;
    
    Component *foodLiquid = [Component new];
    foodLiquid.componentType = componentTypeFood;
    foodLiquid.desc = @"流食";
    foodLiquid.priority = Priority_1;
    
    Component *foodSemiliquid = [Component new];
    foodSemiliquid.componentType = componentTypeFood;
    foodSemiliquid.desc = @"半流食";
    foodSemiliquid.priority = Priority_2;
    
    Component *foodPap = [Component new];
    foodPap.componentType = componentTypeFood;
    foodPap.desc = @"软食";
    foodPap.priority = Priority_3;
    
    Component *foodNormal = [Component new];
    foodNormal.componentType = componentTypeFood;
    foodNormal.desc = @"普食";
    foodNormal.priority = Priority_4;
    
    /*蛋白质*/
    Component *proteinNone = [Component new];
    proteinNone.componentType = componentTypeProtein;
    proteinNone.desc = @"无蛋白质";
    proteinNone.priority = Priority_0;
    
    Component *proteinLow = [Component new];
    proteinLow.componentType = componentTypeProtein;
    proteinLow.desc = @"低蛋白";
    proteinLow.priority = Priority_1;
    
    Component *proteinHigh = [Component new];
    proteinHigh.componentType = componentTypeProtein;
    proteinHigh.desc = @"高蛋白";
    proteinHigh.priority = Priority_2;
    
    Component *proteinGeneral = [Component new];
    proteinGeneral.componentType = componentTypeProtein;
    proteinGeneral.desc = @"普通蛋白";
    proteinGeneral.priority = Priority_3;
    
    /*米饭*/
    Component *riceNone = [Component new];
    riceNone.componentType = componentTypeRice;
    riceNone.desc = @"无米饭";
    riceNone.priority = Priority_0;
    
    Component *riceLowProtein = [Component new];
    riceLowProtein.componentType = componentTypeRice;
    riceLowProtein.desc = @"低蛋白米饭";
    riceLowProtein.priority = Priority_1;
    
    Component *riceGeneral = [Component new];
    riceGeneral.componentType = componentTypeRice;
    riceGeneral.desc = @"白米饭";
    riceGeneral.priority = Priority_2;
    
    Component *riceCoarse = [Component new];
    riceCoarse.componentType = componentTypeRice;
    riceCoarse.desc = @"杂粮饭";
    riceCoarse.priority = Priority_3;
    
    
    //特殊选择
    SpecialSelection *specialSelectionNone = [SpecialSelection new];
    specialSelectionNone.selectionType = SpecialSelectionTypeNone;
    specialSelectionNone.selectionName = @"无选择";
    
    SpecialSelection *specialSelectionPillowRice = [SpecialSelection new];
    specialSelectionPillowRice.selectionType = SpecialSelectionTypePillowyRice;
    specialSelectionPillowRice.selectionName = @"软米饭";

    //餐型1：不可匹配、蛋白类型：不可匹配、米饭类型：不可匹配
    for (NSString *sickName in self.sicknessTable[0]) {
        AgeSection *ageSection = [AgeSection new];
        ageSection.smaller = 0;
        ageSection.larger = 10000;
        ageSection.leftClose = NO;
        ageSection.rightClose = NO;
        
        Sickness *sickness = [Sickness new];
        sickness.name = sickName;
        
        Meal *meal = [self createAMeal];
        meal.components = @[foodNone,proteinNone,riceNone];
        
        Condition *condition = [Condition new];
        condition.ageSection = ageSection;
        condition.sickness = sickness;
        condition.meal = meal;
        condition.specialSelection = specialSelectionNone;
        [conditionTables addObject:condition];
    }
    
    //餐型2：流食、蛋白类型：不可匹配、米饭类型：不可匹配
    for (NSString *sickName in self.sicknessTable[1]) {
        AgeSection *ageSection = [AgeSection new];
        ageSection.smaller = 0;
        ageSection.larger = 10000;
        ageSection.leftClose = NO;
        ageSection.rightClose = NO;
        
        Sickness *sickness = [Sickness new];
        sickness.name = sickName;
        
        Meal *meal = [self createAMeal];
        meal.components = @[foodLiquid,proteinNone,riceNone];
        
        Condition *condition = [Condition new];
        condition.ageSection = ageSection;
        condition.sickness = sickness;
        condition.meal = meal;
        condition.specialSelection = specialSelectionNone;
        [conditionTables addObject:condition];
    }
    
    //餐型3：半流食、蛋白类型：不可匹配、米饭类型：不可匹配
    for (NSString *sickName in self.sicknessTable[2]) {
        AgeSection *ageSection = [AgeSection new];
        ageSection.smaller = 0;
        ageSection.larger = 10000;
        ageSection.leftClose = NO;
        ageSection.rightClose = NO;
        
        Sickness *sickness = [Sickness new];
        sickness.name = sickName;
        
        Meal *meal = [self createAMeal];
        meal.components = @[foodSemiliquid,proteinNone,riceNone];
        
        Condition *condition = [Condition new];
        condition.ageSection = ageSection;
        condition.sickness = sickness;
        condition.meal = meal;
        condition.specialSelection = specialSelectionNone;
        [conditionTables addObject:condition];
    }
    
    //餐型4：软食、蛋白类型：低蛋白、米饭类型：低蛋白大米 年龄>=65
    for (NSString *sickName in self.sicknessTable[3]) {
        AgeSection *ageSection = [AgeSection new];
        ageSection.smaller = 65;
        ageSection.larger = 10000;
        ageSection.leftClose = YES;
        ageSection.rightClose = NO;
        
        Sickness *sickness = [Sickness new];
        sickness.name = sickName;
        
        Meal *meal = [self createAMeal];
        meal.components = @[foodPap,proteinLow,riceLowProtein];
        
        Condition *condition = [Condition new];
        condition.ageSection = ageSection;
        condition.sickness = sickness;
        condition.meal = meal;
        condition.specialSelection = specialSelectionNone;
        [conditionTables addObject:condition];
    }
    
    //餐型5：软食、蛋白类型：普通蛋白、米饭类型：白米饭  任何年龄
    for (NSString *sickName in self.sicknessTable[4]) {
        AgeSection *ageSection = [AgeSection new];
        ageSection.smaller = 0;
        ageSection.larger = 10000;
        ageSection.leftClose = NO;
        ageSection.rightClose = NO;
        
        Sickness *sickness = [Sickness new];
        sickness.name = sickName;
        
        Meal *meal = [self createAMeal];
        meal.components = @[foodPap,proteinGeneral,riceGeneral];
        
        Condition *condition = [Condition new];
        condition.ageSection = ageSection;
        condition.sickness = sickness;
        condition.meal = meal;
        condition.specialSelection = specialSelectionNone;
        [conditionTables addObject:condition];
    }
    
    //餐型6：软食、蛋白类型：普通蛋白、米饭类型：白米饭  年龄>=65
    for (NSString *sickName in self.sicknessTable[5]) {
        AgeSection *ageSection = [AgeSection new];
        ageSection.smaller = 65;
        ageSection.larger = 10000;
        ageSection.leftClose = YES;
        ageSection.rightClose = NO;
        
        Sickness *sickness = [Sickness new];
        sickness.name = sickName;
        
        Meal *meal = [self createAMeal];
        meal.components = @[foodPap,proteinGeneral,riceGeneral];
        
        Condition *condition = [Condition new];
        condition.ageSection = ageSection;
        condition.sickness = sickness;
        condition.meal = meal;
        condition.specialSelection = specialSelectionNone;
        [conditionTables addObject:condition];
    }
    
    //餐型7：软食、蛋白类型：高蛋白、米饭类型：白米饭 年龄>=65
    for (NSString *sickName in self.sicknessTable[6]) {
        AgeSection *ageSection = [AgeSection new];
        ageSection.smaller = 65;
        ageSection.larger = 10000;
        ageSection.leftClose = YES;
        ageSection.rightClose = NO;
        
        Sickness *sickness = [Sickness new];
        sickness.name = sickName;
        
        Meal *meal = [self createAMeal];
        meal.components = @[foodPap,proteinHigh,riceGeneral];
        
        Condition *condition = [Condition new];
        condition.ageSection = ageSection;
        condition.sickness = sickness;
        condition.meal = meal;
        condition.specialSelection = specialSelectionNone;
        [conditionTables addObject:condition];
    }
    
    //餐型8：普食、蛋白类型：低蛋白、米饭类型：低蛋白大米 年龄<65
    for (NSString *sickName in self.sicknessTable[3]) {
        AgeSection *ageSection = [AgeSection new];
        ageSection.smaller = 0;
        ageSection.larger = 65;
        ageSection.leftClose = NO;
        ageSection.rightClose = NO;
        
        Sickness *sickness = [Sickness new];
        sickness.name = sickName;
        
        Meal *meal = [self createAMeal];
        meal.components = @[foodNormal,proteinLow,riceLowProtein];
        
        Condition *condition = [Condition new];
        condition.ageSection = ageSection;
        condition.sickness = sickness;
        condition.meal = meal;
        condition.specialSelection = specialSelectionNone;
        [conditionTables addObject:condition];
    }
    
    //餐型9：普食、蛋白类型：普通蛋白、米饭类型：白米饭 年龄<65 软米饭
    for (NSString *sickName in self.sicknessTable[5]) {
        AgeSection *ageSection = [AgeSection new];
        ageSection.smaller = 0;
        ageSection.larger = 65;
        ageSection.leftClose = NO;
        ageSection.rightClose = NO;
        
        Sickness *sickness = [Sickness new];
        sickness.name = sickName;
        
        Meal *meal = [self createAMeal];
        meal.components = @[foodNormal,proteinGeneral,riceGeneral];
        
        Condition *condition = [Condition new];
        condition.ageSection = ageSection;
        condition.sickness = sickness;
        condition.meal = meal;
        condition.specialSelection = specialSelectionPillowRice;
        [conditionTables addObject:condition];
    }
    
    //餐型10：普食、蛋白类型：普通蛋白、米饭类型：杂粮饭 年龄<65
    for (NSString *sickName in self.sicknessTable[5]) {
        AgeSection *ageSection = [AgeSection new];
        ageSection.smaller = 0;
        ageSection.larger = 65;
        ageSection.leftClose = NO;
        ageSection.rightClose = NO;
        
        Sickness *sickness = [Sickness new];
        sickness.name = sickName;
        
        Meal *meal = [self createAMeal];
        meal.components = @[foodNormal,proteinGeneral,riceCoarse];
        
        Condition *condition = [Condition new];
        condition.ageSection = ageSection;
        condition.sickness = sickness;
        condition.meal = meal;
        condition.specialSelection = specialSelectionNone;
        [conditionTables addObject:condition];
    }
    
    //餐型11：普食、蛋白类型：高蛋白、米饭类型：杂粮饭 年龄<65 软米饭
    for (NSString *sickName in self.sicknessTable[6]) {
        AgeSection *ageSection = [AgeSection new];
        ageSection.smaller = 0;
        ageSection.larger = 65;
        ageSection.leftClose = NO;
        ageSection.rightClose = NO;
        
        Sickness *sickness = [Sickness new];
        sickness.name = sickName;
        
        Meal *meal = [self createAMeal];
        meal.components = @[foodNormal,proteinHigh,riceGeneral];
        
        Condition *condition = [Condition new];
        condition.ageSection = ageSection;
        condition.sickness = sickness;
        condition.meal = meal;
        condition.specialSelection = specialSelectionPillowRice;
        [conditionTables addObject:condition];
    }
    
    //餐型12：普食、蛋白类型：高蛋白、米饭类型：杂粮饭 年龄<65 无
    for (NSString *sickName in self.sicknessTable[6]) {
        AgeSection *ageSection = [AgeSection new];
        ageSection.smaller = 0;
        ageSection.larger = 65;
        ageSection.leftClose = NO;
        ageSection.rightClose = NO;
        
        Sickness *sickness = [Sickness new];
        sickness.name = sickName;
        
        Meal *meal = [self createAMeal];
        meal.components = @[foodNormal,proteinHigh,riceCoarse];
        
        Condition *condition = [Condition new];
        condition.ageSection = ageSection;
        condition.sickness = sickness;
        condition.meal = meal;
        condition.specialSelection = specialSelectionNone;
        [conditionTables addObject:condition];
        condition.meal = meal;
    }
    self.conditionTable = conditionTables;
}

- (void)createSicknesses{
    NSArray *sicknessSection1 = @[@"痛风急性发作",@"高尿酸血症",@"上消化道出血",@"慢性乙肝",@"腹部大手术"];
    NSArray *sicknessSection2 = @[@"急性胆囊炎缓解初期",@"炎症性肠病",@"急性胰腺炎缓解初期",@"结肠息肉切除术后",@"急性胃炎缓解初期",@"消化性溃疡I期",@"胃息肉切除术后",@"疝气术后",@"胃肠术后1-3d",@"妇科术后1-3d"];
    NSArray *sicknessSection3 = @[@"急性胆囊炎缓解中期",@"急性胰腺炎缓解中期",@"急性胃炎缓解中期",@"慢性胃炎急性发作期",@"消化性溃疡恢复II期-III期"];
    NSArray *sicknessSection4 = @[@"糖尿病肾病",@"肾功能不全",@"肾功能不全伴并发症",@"慢性肾炎",@"肾病综合症",@"肾炎",@"肾功能不全"];
    NSArray *sicknessSection5 = @[@"心衰",@"脑卒中",@"慢性心功不全（心功III级及以上）",@"脑出血",@"脑肿瘤",@"阑尾手术",@"肛门疾病手术",@"肝脏手术",@"胃肠手术",@"胆道手术",@"胆囊手术",@"慢性胆囊炎",@"疝气术后恢复期",@"鼻咽癌",@"鼻咽部手术",@"结肠息肉",@"胃息肉",@"食管癌",@"肺癌",@"气胸",@"心率不齐",@"重症肺炎",@"重症感染伴胸腔积液",@"消化不良",@"肝硬化",@"急性胰腺炎恢复期",@"急性胆囊炎恢复期",@"慢性胃炎",@"消化性溃疡恢复IV期"];
    NSArray *sicknessSection6 = @[@"高血压",@"高血压伴并发症",@"糖尿病",@"高血脂",@"糖尿病足",@"甲亢",@"高钙血症",@"血色病",@"骨质疏松",@"冠心病伴并发症",@"冠心病",@"慢性心功不全（心功I-II级）",@"心率不齐",@"心动过速",@"房颤",@"室颤",@"心室肥厚",@"心肌炎",@"多囊肾",@"血液透析",@"急性肾炎",@"肾结石",@"癫痫",@"帕金森病",@"白内障",@"结膜炎",@"角膜溃疡",@"糖尿病眼病",@"疝气",@"甲乳手术",@"下肢静脉曲张手术",@"表皮包块切除术",@"慢性盆腔炎",@"子宫肌瘤",@"子宫脱垂",@"宫颈糜烂",@"肾囊肿",@"泌尿系统结石",@"前列腺增生",@"痴呆",@"慢性支气管炎急性发作",@"慢性支气管炎",@"支气管哮喘急性发作期",@"慢性阻塞性肺病",@"肺炎",@"慢性支气管哮喘",@"支气管扩张",@"支气管扩张伴并发症",@"哮喘",@"胃食管反流性疾病",@"胃食管反流性疾病伴食管炎",@"肠易激综合征不伴腹泻",@"肠易激综合征伴腹泻",@"痛风稳定期",@"胸腔积液"];
    NSArray *sicknessSection7 = @[@"颈椎病",@"髋骨折",@"关节置换",@"上肢骨折",@"脊柱疾病",@"下肢骨折",@"骨肿瘤",@"颅脑损伤",@"肝恶性肿瘤",@"一般恶性肿瘤",@"血液恶性肿瘤",@"妇科恶性肿瘤",@"泌尿系统恶性肿瘤"];
    
    
    NSArray *sickNames =  @[sicknessSection1,sicknessSection2,sicknessSection3,sicknessSection4,sicknessSection5,sicknessSection6,sicknessSection7];
    self.sicknessTable = sickNames;
//    NSMutableArray *sicknessTable = [NSMutableArray new];
//    for (NSArray *sicks in sickNames) {
//        for (NSString *sickName in sicks) {
//            Sickness *sick
//        }
//    }
}
@end
