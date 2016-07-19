//
//  PullDownTableView.h
//  TextDemo
//
//  Created by Tony Zhang on 16/7/8.
//  Copyright © 2016年 Tony Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CompleteBlock)(NSString *selected);

@interface PullDownTableView : UIView

/** 完成回调block */
@property(nonatomic,copy)CompleteBlock complete;

+(instancetype)TableViewInitWithArray:(NSArray *)array andFrame:(CGRect)frame CompleteBlock:(CompleteBlock)completeBlock;

-(void)show;

@end
