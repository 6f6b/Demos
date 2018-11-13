//
//  MsgListController.m
//  聊天列表Demo
//
//  Created by postop.dev.ios.nophone on 2018/11/6.
//  Copyright © 2018 postop_iosdev. All rights reserved.
//

#import "MsgListController.h"
#import "ChatMsgCell.h"
#import "MessageModel.h"
#import "ChatMsgFactory.h"
#import "UITableView+scrollBottom.h"

@interface MsgListController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UITextField *inputText;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *barBottomHeightCostraint;
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *barBottomConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *tableViewTopConstriant;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeightConstraint;
@property (nonatomic, assign) BOOL isShow;
@end

@implementation MsgListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [NSMutableArray new];
    self.tableViewHeightConstraint.constant = ScreenHeight-BottomHeight-self.barBottomHeightCostraint.constant;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [ChatMsgFactory registerChatMsgCellWith:self.tableView];
    self.tableView.estimatedRowHeight = 100.0;
    [self initDataArray];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}

///初始化一个聊天数组
- (void)initDataArray{
    //聊天信息条数
    int msgNum = 2;
    NSArray *words = @[@"hello",@"my",@"name",@"is",@"liufeng",@"whats",@"your",@"name",@"you",@"look",@"so",@"beautyful",@".",@"!",@"when",@"see",@"me",@"will",@"love",@"belive"];
    for (int i=0; i<msgNum; i++) {
        MessageModel *messageModel = [MessageModel new];
        messageModel.text = [self generateTextWith:words];
        messageModel.isrReceived = [self randNum]%2 == 0;
        [self.dataArray addObject:messageModel];
    }
    [self reloadChatList];
}

- (int)randNum{
    return rand();
}

///生成一个句子
- (NSString *)generateTextWith:(NSArray *)words{
    int wordsNum = [self randNum]%words.count;
    NSMutableString *text = [NSMutableString new];
    for (int i=0; i<wordsNum; i++) {
        int wordIndex = [self randNum]%words.count;
        [text appendFormat:@"%@ ",words[wordIndex]];
    }
    return text;
}

- (void)reloadChatList{
    [self.tableView reloadData];
    [self updateTableViewWith:self.barBottomHeightCostraint.constant > 0];
}

- (CGFloat)totalHeightWith:(NSArray *)dataArray{
    CGFloat totalHeight = 0.0;
    for (int i=0; i<dataArray.count; i++) {
        MessageModel *messageModel = dataArray[i];
        CGFloat cellHeight = [self cellHeightWith:messageModel];
        totalHeight += cellHeight;
    }
    return totalHeight;
}

- (CGFloat)cellHeightWith:(MessageModel *)messageModel{
    CGFloat maxWidth = [UIScreen mainScreen].bounds.size.width - 160.0;
    CGFloat cellheight = 0.0;
    CGSize size = [messageModel.text boundingRectWithSize:CGSizeMake(maxWidth, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
    if (size.height >= 50) {
        cellheight = 15+15+cellheight;
    }
    if (size.height < 50) {
        cellheight = 15+15+50;
    }
    return cellheight;
}

//发送
- (IBAction)clickSendBtn:(id)sender {
    MessageModel *messageModel = [MessageModel new];
    messageModel.isrReceived = [self randNum] % 2 == 0;
    messageModel.text = self.inputText.text;
    [self.dataArray addObject:messageModel];
    [self reloadChatList];
}

- (void)updateTableViewWith:(BOOL)isBarShow{
    if (!isBarShow) {
        self.tableViewTopConstriant.constant = 0;
        self.tableViewHeightConstraint.constant = ScreenHeight-self.barBottomHeightCostraint.constant;
        return;
    }
    CGFloat visiableHeight = ScreenHeight-self.barBottomConstraint.constant-self.barBottomHeightCostraint.constant;
    self.tableViewHeightConstraint.constant = visiableHeight;
    [self.tableView nim_scrollToBottom:NO];
//    CGFloat contentHeight = [self totalHeightWith:self.dataArray];
//    CGFloat topConstraint = 0;
//    if (contentHeight <= visiableHeight) {
//    }
//    if (contentHeight > visiableHeight && contentHeight <= self.tableViewHeightConstraint.constant) {
//        topConstraint = visiableHeight - contentHeight;
//        //topConstraint = visiableHeight - self.tableViewHeightConstraint.constant;
//    }
//    if (contentHeight > self.tableViewHeightConstraint.constant) {
//        topConstraint = visiableHeight - self.tableViewHeightConstraint.constant;
//    }
//    self.tableViewTopConstriant.constant = topConstraint;
    
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageModel *msg = self.dataArray[indexPath.row];
    CGFloat height = [self cellHeightWith:msg];
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageModel *msg = self.dataArray[indexPath.row];
    ChatMsgCell *chatMsgCell = [ChatMsgFactory cellWith:tableView messageModel:msg];
    [chatMsgCell configWithMessageModel:msg];
    return chatMsgCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.inputText resignFirstResponder];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.inputText resignFirstResponder];
}


#pragma mark - 键盘通知
- (void)keyboardWillShow:(NSNotification *)note
{
    if (self.isShow) {
        return;
    }
    // 1.取出键盘的frame
    CGRect begin = [note.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    
    CGRect end = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // 2.取出键盘弹出的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    //3.输入框弹起后的Y
    CGFloat y_board = 0;
    //4.处理键盘（包括第三方键盘）
    if(begin.size.height > 0 && (begin.origin.y - end.origin.y > 0)){
        NSLog(@"键盘弹出%f",begin.origin.y-end.origin.y);
        self.isShow =YES;
        //处理逻辑
        [UIView animateWithDuration:duration animations:^{
            self.barBottomConstraint.constant = begin.origin.y-end.origin.y;
            [self updateTableViewWith:YES];
        }];
    }
    
}

/**
 *  键盘即将退出的时候调用
 */
- (void)keyboardWillHide:(NSNotification *)note
{   self.isShow = NO;
    // 1.取出键盘弹出的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 2.执行动画
    [UIView animateWithDuration:duration animations:^{
        //如果高度超过了本身高度，要让最后一个cell在底部
        [self.view layoutIfNeeded];
        self.barBottomConstraint.constant = 0;
        [self updateTableViewWith:NO];
    }];
}

@end
