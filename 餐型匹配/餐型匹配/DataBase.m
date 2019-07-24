//
//  DataBase.m
//  餐型匹配
//
//  Created by 刘丰 on 2019/7/20.
//  Copyright © 2019 dev.liufeng@gmail.com. All rights reserved.
//

#import "DataBase.h"
#import "Condition.h"

@interface DataBase ()
@property (nonatomic,assign) NSUInteger idNum;
@end
@implementation DataBase

- (instancetype)init{
    if (self = [super init]) {
        self.idNum = 0;
    }
    return self;
}

- (Meal *)createAMeal{
    Meal *meal = [Meal new];
    self.idNum += 1;
    meal.ID = self.idNum;
    return meal;
}

- (NSArray *)sicknesses{
    NSArray *sicknessSection1 = @[@"痛风急性发作",@"高尿酸血症",@"上消化道出血",@"慢性乙肝",@"腹部大手术"];
    NSArray *sicknessSection2 = @[@"急性胆囊炎缓解初期",@"炎症性肠病",@"急性胰腺炎缓解初期",@"结肠息肉切除术后",@"急性胃炎缓解初期",@"消化性溃疡I期",@"胃息肉切除术后",@"疝气术后",@"胃肠术后1-3d",@"妇科术后1-3d"];
    NSArray *sicknessSection3 = @[@"急性胆囊炎缓解中期",@"急性胰腺炎缓解中期",@"急性胃炎缓解中期",@"慢性胃炎急性发作期",@"消化性溃疡恢复II期-III期"];
    NSArray *sicknessSection4 = @[@"糖尿病肾病",@"肾功能不全",@"肾功能不全伴并发症",@"慢性肾炎",@"肾病综合症",@"肾炎",@"肾功能不全"];
    NSArray *sicknessSection5 = @[@"心衰",@"脑卒中",@"慢性心功不全（心功III级及以上）",@"脑出血",@"脑肿瘤",@"阑尾手术",@"肛门疾病手术",@"肝脏手术",@"胃肠手术",@"胆道手术",@"胆囊手术",@"慢性胆囊炎",@"疝气术后恢复期",@"鼻咽癌",@"鼻咽部手术",@"结肠息肉",@"胃息肉",@"食管癌",@"肺癌",@"气胸",@"心率不齐",@"重症肺炎",@"重症感染伴胸腔积液",@"消化不良",@"肝硬化",@"急性胰腺炎恢复期",@"急性胆囊炎恢复期",@"慢性胃炎",@"消化性溃疡恢复IV期"];
    NSArray *sicknessSection6 = @[@"高血压",@"高血压伴并发症",@"糖尿病",@"高血脂",@"糖尿病足",@"甲亢",@"高钙血症",@"血色病",@"骨质疏松",@"冠心病伴并发症",@"冠心病",@"慢性心功不全（心功I-II级）",@"心率不齐",@"心动过速",@"房颤",@"室颤",@"心室肥厚",@"心肌炎",@"多囊肾",@"血液透析",@"急性肾炎",@"肾结石",@"癫痫",@"帕金森病",@"白内障",@"结膜炎",@"角膜溃疡",@"糖尿病眼病",@"疝气",@"甲乳手术",@"下肢静脉曲张手术",@"表皮包块切除术",@"慢性盆腔炎",@"子宫肌瘤",@"子宫脱垂",@"宫颈糜烂",@"肾囊肿",@"泌尿系统结石",@"前列腺增生",@"痴呆",@"慢性支气管炎急性发作",@"慢性支气管炎",@"支气管哮喘急性发作期",@"慢性阻塞性肺病",@"肺炎",@"慢性支气管哮喘",@"支气管扩张",@"支气管扩张伴并发症",@"哮喘",@"胃食管反流性疾病",@"胃食管反流性疾病伴食管炎",@"肠易激综合征不伴腹泻",@"肠易激综合征伴腹泻",@"痛风稳定期",@"胸腔积液"];
    NSArray *sicknessSection7 = @[@"颈椎病",@"髋骨折",@"关节置换",@"上肢骨折",@"脊柱疾病",@"下肢骨折",@"骨肿瘤",@"颅脑损伤",@"肝恶性肿瘤",@"一般恶性肿瘤",@"血液恶性肿瘤",@"妇科恶性肿瘤",@"泌尿系统恶性肿瘤"];
    return @[sicknessSection1,sicknessSection2,sicknessSection3,sicknessSection4,sicknessSection5,sicknessSection6,sicknessSection7];
}

- (NSArray *)conditionTables{

    NSMutableArray *conditionTables = [NSMutableArray new];
    
    //餐型1：不可匹配、蛋白类型：不可匹配、米饭类型：不可匹配
    for (NSString *sickName in self.sicknesses[0]) {
        AgeSection *ageSection = [AgeSection new];
        ageSection.smaller = 0;
        ageSection.larger = 10000;
        ageSection.leftClose = NO;
        ageSection.rightClose = NO;
        
        Sickness *sickness = [Sickness new];
        sickness.name = sickName;
        
        Meal *meal = [self createAMeal];
        meal.foodType = FoodTypeNone;
        meal.proteinType = ProteinTypeNone;
        meal.riceType = RiceTypeNone;
        
        Condition *condition = [Condition new];
        condition.ageSection = ageSection;
        condition.sickness = sickness;
        condition.meal = meal;
        [conditionTables addObject:condition];
    }
    
    //餐型2：流食、蛋白类型：不可匹配、米饭类型：不可匹配
    for (NSString *sickName in self.sicknesses[1]) {
        AgeSection *ageSection = [AgeSection new];
        ageSection.smaller = 0;
        ageSection.larger = 10000;
        ageSection.leftClose = NO;
        ageSection.rightClose = NO;
        
        Sickness *sickness = [Sickness new];
        sickness.name = sickName;
        
        Meal *meal = [self createAMeal];
        meal.foodType = FoodTypeLiquid;
        meal.proteinType = ProteinTypeNone;
        meal.riceType = RiceTypeNone;
        
        Condition *condition = [Condition new];
        condition.ageSection = ageSection;
        condition.sickness = sickness;
        condition.meal = meal;
        [conditionTables addObject:condition];
    }
    
    //餐型3：半流食、蛋白类型：不可匹配、米饭类型：不可匹配
    for (NSString *sickName in self.sicknesses[2]) {
        AgeSection *ageSection = [AgeSection new];
        ageSection.smaller = 0;
        ageSection.larger = 10000;
        ageSection.leftClose = NO;
        ageSection.rightClose = NO;
        
        Sickness *sickness = [Sickness new];
        sickness.name = sickName;
        
        Meal *meal = [self createAMeal];
        meal.foodType = FoodTypeSemiliquid;
        meal.proteinType = ProteinTypeNone;
        meal.riceType = RiceTypeNone;
        
        Condition *condition = [Condition new];
        condition.ageSection = ageSection;
        condition.sickness = sickness;
        condition.meal = meal;
        [conditionTables addObject:condition];
    }
    
    //餐型4：软食、蛋白类型：低蛋白、米饭类型：低蛋白大米 年龄>=65
    for (NSString *sickName in self.sicknesses[3]) {
        AgeSection *ageSection = [AgeSection new];
        ageSection.smaller = 65;
        ageSection.larger = 10000;
        ageSection.leftClose = YES;
        ageSection.rightClose = NO;
        
        Sickness *sickness = [Sickness new];
        sickness.name = sickName;
        
        Meal *meal = [self createAMeal];
        meal.foodType = FoodTypePap;
        meal.proteinType = ProteinTypeLow;
        meal.riceType = RiceTypeLowProtein;
        
        Condition *condition = [Condition new];
        condition.ageSection = ageSection;
        condition.sickness = sickness;
        condition.meal = meal;
        [conditionTables addObject:condition];
    }
    
    //餐型5：软食、蛋白类型：普通蛋白、米饭类型：白米饭  任何年龄
    for (NSString *sickName in self.sicknesses[4]) {
        AgeSection *ageSection = [AgeSection new];
        ageSection.smaller = 0;
        ageSection.larger = 10000;
        ageSection.leftClose = NO;
        ageSection.rightClose = NO;
        
        Sickness *sickness = [Sickness new];
        sickness.name = sickName;
        
        Meal *meal = [self createAMeal];
        meal.foodType = FoodTypePap;
        meal.proteinType = ProteinTypeGeneral;
        meal.riceType = RiceTypeGeneral;
        
        Condition *condition = [Condition new];
        condition.ageSection = ageSection;
        condition.sickness = sickness;
        condition.meal = meal;
        [conditionTables addObject:condition];
    }
    
    //餐型6：软食、蛋白类型：普通蛋白、米饭类型：白米饭  年龄>=65
    for (NSString *sickName in self.sicknesses[5]) {
        AgeSection *ageSection = [AgeSection new];
        ageSection.smaller = 65;
        ageSection.larger = 10000;
        ageSection.leftClose = YES;
        ageSection.rightClose = NO;
        
        Sickness *sickness = [Sickness new];
        sickness.name = sickName;
        
        Meal *meal = [self createAMeal];
        meal.foodType = FoodTypePap;
        meal.proteinType = ProteinTypeGeneral;
        meal.riceType = RiceTypeGeneral;
        
        Condition *condition = [Condition new];
        condition.ageSection = ageSection;
        condition.sickness = sickness;
        condition.meal = meal;
        [conditionTables addObject:condition];
    }
    
    //餐型7：软食、蛋白类型：高蛋白、米饭类型：白米饭 年龄>=65
    for (NSString *sickName in self.sicknesses[6]) {
        AgeSection *ageSection = [AgeSection new];
        ageSection.smaller = 65;
        ageSection.larger = 10000;
        ageSection.leftClose = YES;
        ageSection.rightClose = NO;
        
        Sickness *sickness = [Sickness new];
        sickness.name = sickName;
        
        Meal *meal = [self createAMeal];
        meal.foodType = FoodTypePap;
        meal.proteinType = ProteinTypeHigh;
        meal.riceType = RiceTypeGeneral;
        
        Condition *condition = [Condition new];
        condition.ageSection = ageSection;
        condition.sickness = sickness;
        condition.meal = meal;
        [conditionTables addObject:condition];
    }
    
    //餐型8：普食、蛋白类型：低蛋白、米饭类型：低蛋白大米 年龄<65
    for (NSString *sickName in self.sicknesses[3]) {
        AgeSection *ageSection = [AgeSection new];
        ageSection.smaller = 0;
        ageSection.larger = 65;
        ageSection.leftClose = NO;
        ageSection.rightClose = NO;
        
        Sickness *sickness = [Sickness new];
        sickness.name = sickName;
        
        Meal *meal = [self createAMeal];
        meal.foodType = FoodTypeNormal;
        meal.proteinType = ProteinTypeLow;
        meal.riceType = RiceTypeLowProtein;
        
        Condition *condition = [Condition new];
        condition.ageSection = ageSection;
        condition.sickness = sickness;
        condition.meal = meal;
        [conditionTables addObject:condition];
    }
    
    //餐型9：普食、蛋白类型：普通蛋白、米饭类型：白米饭 年龄<65 软米饭
    for (NSString *sickName in self.sicknesses[5]) {
        AgeSection *ageSection = [AgeSection new];
        ageSection.smaller = 0;
        ageSection.larger = 65;
        ageSection.leftClose = NO;
        ageSection.rightClose = NO;
        
        Sickness *sickness = [Sickness new];
        sickness.name = sickName;
        
        Meal *meal = [self createAMeal];
        meal.foodType = FoodTypeNormal;
        meal.proteinType = ProteinTypeGeneral;
        meal.riceType = RiceTypeGeneral;
        
        Condition *condition = [Condition new];
        condition.ageSection = ageSection;
        condition.sickness = sickness;
        condition.meal = meal;
        condition.specialSelection = SpecialSelectionPillowyRice;
        [conditionTables addObject:condition];
    }
    
    //餐型10：普食、蛋白类型：普通蛋白、米饭类型：杂粮饭 年龄<65
    for (NSString *sickName in self.sicknesses[5]) {
        AgeSection *ageSection = [AgeSection new];
        ageSection.smaller = 0;
        ageSection.larger = 65;
        ageSection.leftClose = NO;
        ageSection.rightClose = NO;
        
        Sickness *sickness = [Sickness new];
        sickness.name = sickName;
        
        Meal *meal = [self createAMeal];
        meal.foodType = FoodTypeNormal;
        meal.proteinType = ProteinTypeGeneral;
        meal.riceType = RiceTypeCoarse;
        
        Condition *condition = [Condition new];
        condition.ageSection = ageSection;
        condition.sickness = sickness;
        condition.meal = meal;
        [conditionTables addObject:condition];
    }
    
    //餐型11：普食、蛋白类型：高蛋白、米饭类型：杂粮饭 年龄<65 软米饭
    for (NSString *sickName in self.sicknesses[6]) {
        AgeSection *ageSection = [AgeSection new];
        ageSection.smaller = 0;
        ageSection.larger = 65;
        ageSection.leftClose = NO;
        ageSection.rightClose = NO;
        
        Sickness *sickness = [Sickness new];
        sickness.name = sickName;
        
        Meal *meal = [self createAMeal];
        meal.foodType = FoodTypeNormal;
        meal.proteinType = ProteinTypeHigh;
        meal.riceType = RiceTypeGeneral;
        
        Condition *condition = [Condition new];
        condition.ageSection = ageSection;
        condition.sickness = sickness;
        condition.meal = meal;
        condition.specialSelection = SpecialSelectionPillowyRice;
        [conditionTables addObject:condition];
    }
    
    //餐型12：普食、蛋白类型：高蛋白、米饭类型：杂粮饭 年龄<65 无
    for (NSString *sickName in self.sicknesses[6]) {
        AgeSection *ageSection = [AgeSection new];
        ageSection.smaller = 0;
        ageSection.larger = 65;
        ageSection.leftClose = NO;
        ageSection.rightClose = NO;
        
        Sickness *sickness = [Sickness new];
        sickness.name = sickName;
        
        Meal *meal = [self createAMeal];
        meal.foodType = FoodTypeNormal;
        meal.proteinType = ProteinTypeHigh;
        meal.riceType = RiceTypeCoarse;
        
        Condition *condition = [Condition new];
        condition.ageSection = ageSection;
        condition.sickness = sickness;
        condition.meal = meal;
        [conditionTables addObject:condition];
        condition.meal = meal;
    }
    return conditionTables;
}
@end
