//
//  main.m
//  数据结构001-平衡二叉树
//
//  Created by postop.dev.ios.nophone on 2018/11/14.
//  Copyright © 2018 postop_iosdev. All rights reserved.
//

#import <Foundation/Foundation.h>

#define LH +1
#define EH 0
#define RH -1


typedef struct BiNode{
    int data;
    int balance_factor;
    struct BiNode *left_child,*right_child;
}BiNode, *BiTree;

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
    }
    return 0;
}


/**
 对以p为根的树进行左旋
 */
void L_Rotate(BiTree *p){
    BiTree R = (*p)->right_child;
    (*p)->right_child = R->left_child;
    R->left_child = *p;
    *p = R;
}


/**
 对以p为根的树进行右旋
 */
void R_Rotate(BiTree *p){
    BiTree L = (*p)->left_child;
    (*p)->left_child = L->right_child;
    L->right_child = *p;
    *p = L;
}


/**
 对以T为根的树进行左平衡操作
 */
void LeftBalance(BiTree *T){
    //旋转前检查左子树的平衡度是否跟树根保持一正负相同
    BiTree L = (*T)->left_child;
    BiTree Lr = L->right_child;
    switch (L->balance_factor) {
        case LH:
            L->balance_factor = (*T)->balance_factor = EH;
            R_Rotate(T);
            break;
        case EH:
            //当为EH的时候不需要操作
            break;
        case RH:
            switch (Lr->balance_factor) {
                case LH:
                    Lr->left_child->balance_factor = EH;
                    (*T)->balance_factor = LH;
                    break;
                case EH:
                    Lr->balance_factor = EH;
                    (*T)->balance_factor = EH;
                    break;
                case RH:
                    Lr->balance_factor = EH;
                    (*T)->balance_factor = LH;
                    break;
                default:
                    break;
            }
            L->balance_factor = EH;
            //先对左子树左转
            L_Rotate(&L);
            //再对T右转
            R_Rotate(T);
            break;
        default:
            break;
    }
}
