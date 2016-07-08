//
//  MultipleOptionsView.h
//  TextDemo
//
//  Created by Tony Zhang on 16/7/8.
//  Copyright © 2016年 Tony Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CompleteBlock)(NSArray *selectedArray);

@interface MultipleOptionsView : UIView


/** 完成回调block */
@property(nonatomic,copy)CompleteBlock complete;

+(instancetype)OptionsViewInitWithArray:(NSArray *)array SelectString:(NSString *)string CompleteBlock:(CompleteBlock)completeBlock;

/** 被选中项标题 */
@property(nonatomic,strong)NSArray *selectedArray;

//显示
-(void)show;

@end


