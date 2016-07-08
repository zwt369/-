//
//  MyTimePickerView.h
//  ZYSheetPicker
//
//  Created by Tony Zhang on 16/7/7.
//  Copyright © 2016年 Corki. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyTimePickerView;

typedef void(^CompleteBlock)(MyTimePickerView *pickerView,NSString *hour,NSString *minute);

@interface MyTimePickerView : UIView

/** 完成回调block */
@property(nonatomic,copy)CompleteBlock complete;

+(instancetype)TimePickerWithHeadTitle:(NSString *)headTitle AndCompleteBlock:(CompleteBlock)completeBlock;

//显示
-(void)show;

@end
