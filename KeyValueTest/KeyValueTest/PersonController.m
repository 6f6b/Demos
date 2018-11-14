//
//  PersonController.m
//  KeyValueTest
//
//  Created by postop.dev.ios.nophone on 2018/10/25.
//  Copyright © 2018 postop_iosdev. All rights reserved.
//

#import "PersonController.h"

@interface PersonController ()
@property (nonatomic,copy) NSString *name;

@end

@implementation PersonController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"person name = :%@",self.name);
    self.title = self.name;
    self.view.backgroundColor = UIColor.yellowColor;
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
