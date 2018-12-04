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
                    L->balance_factor = EH;
                    (*T)->balance_factor = RH;
                    break;
                case EH:
                    L->balance_factor = (*T)->balance_factor = EH;
                    break;
                case RH:
                    (*T)->balance_factor = EH;
                    L->balance_factor = LH;
                    break;
                default:
                    break;
            }
            Lr->balance_factor = EH;
            //先对左子树左转
            L_Rotate(&L);
            //再对T右转
            R_Rotate(T);
            break;
        default:
            break;
    }
}

void RightBalance(BiTree *T){
    BiTree R = (*T)->right_child;
    BiTree Rl = R->left_child;
    switch (R->balance_factor) {
        case LH:
            switch (Rl->balance_factor) {
                case LH:
                    (*T)->balance_factor = EH;
                    R->balance_factor = RH;
                    break;
                case EH:
                    (*T)->balance_factor = EH;
                    R->balance_factor = EH;
                    break;
                case RH:
                    R->balance_factor = EH;
                    (*T)->balance_factor = LH;
                    break;
                default:
                    break;
            }
            Rl->balance_factor = EH;
            R_Rotate(&R);
            L_Rotate(*T);
            break;
        case EH:
            
            break;
        case RH:
            (*T)->balance_factor = R->balance_factor = EH;
            L_Rotate(T);
            break;
        default:
            break;
    }
}

BOOL InsertAVL(BiTree *T,int e,BOOL *taller){
    if (!*T) {
        printf("插入:%d\n",e);
        *T = (BiTree)malloc(sizeof(BiNode));
        (*T)->data = e;
        (*T)->left_child = NULL;
        (*T)->right_child = NULL;
        (*T)->balance_factor = EH;
        *taller = true;
    }else{
        if (e < ((*T)->data)) {
            if(!InsertAVL(&(*T)->left_child, e, taller)){
                return false;
            }
            if (*taller) {//已插入T的左子树，且左子树长高
                //检查T的平衡度
                switch ((*T)->balance_factor) {
                    case LH:
                        LeftBalance(T);//原本左子树比右子树高，需要做左平衡处理
                        *taller = false;
                        break;
                    case EH:
                        (*T)->balance_factor = LH;//原本左右子树等高，现因左子树增高而增高
                        *taller = true;
                        break;
                    case RH:
                        (*T)->balance_factor = EH;
                        *taller = false;//原本右子树比左子树高，现因左子树增高而等高
                        break;
                    default:
                        break;
                }
                LeftBalance(T);
            }
        }
        if (e == (*T)->data) {
            *taller = false;
            return false;
        }
        if (e>(*T)->data) {
            if(!InsertAVL(&(*T)->right_child, e, taller)){
                return false;
            }
            if (*taller) {
                switch ((*T)->balance_factor) {
                    case LH:
                        (*T)->balance_factor = EH;//原本左子树比右子树高，现因右子树增高而等高
                        *taller = false;
                        break;
                    case EH:
                        (*T)->balance_factor = RH;
                        *taller = true;
                        break;
                    case RH:
                        RightBalance(T);
                        *taller = false;    //原本右子树比左子树高，现因右子树继续增高而需要做右平衡操作
                        break;
                    default:
                        break;
                }
            }
        }
    }
    return true;
}


//遍历
void scan(BiTree *T){
    if (!(*T)) {
        return;
    }
    printf("元素：%d\n",(*T)->data);
    if ((*T)->left_child) {
        printf("元素%d的左子树%d\n",(*T)->data,(*T)->left_child->data);
    }else{
        printf("元素%d的左子树为空\n",(*T)->data);
    }
    if ((*T)->right_child) {
        printf("元素%d的右子树%d\n",(*T)->data,(*T)->right_child->data);
    }else{
        printf("元素%d的右子树为空\n",(*T)->data);

    }
    scan(&(*T)->left_child);
    scan(&(*T)->right_child);
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        int a[10] = {2,3,5,6,8,10,11,100,9,4};
        BiTree T = NULL;
        BOOL taller;
        for (int i=0; i<10; i++) {
            InsertAVL(&T, a[i], &taller);
        }
        scan(&T);
    }
    return 0;
}
