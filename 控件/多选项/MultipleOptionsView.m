//
//  MultipleOptionsView.m
//  TextDemo
//
//  Created by Tony Zhang on 16/7/8.
//  Copyright © 2016年 Tony Zhang. All rights reserved.
//

#import "MultipleOptionsView.h"

#define Width [UIScreen mainScreen].bounds.size.width
#define Height [UIScreen mainScreen].bounds.size.height

@interface MyCustomeOptionView : UIView

/** 标题 */
@property(nonatomic,strong)UILabel *title;

/** 图片 */
@property(nonatomic,strong)UIImageView *image;

/** 是否被选中 */
@property(nonatomic,assign)BOOL  selected;

@end


@implementation MyCustomeOptionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addViews];
    }
    return self;
}

-(void)addViews{
    
    self.image = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 20, 20)];
    self.image.image = [UIImage imageNamed:@"notSelected"];
    self.image.userInteractionEnabled = YES;
    [self addSubview:self.image];
    
    self.title = [[UILabel alloc]initWithFrame:CGRectMake(35, 5, Width/2 -55,20)];
    self.title.userInteractionEnabled = YES;
    [self addSubview:self.title];
    
}

-(void)setSelected:(BOOL)selected{
    
    if (selected) {
        self.image.image = [UIImage imageNamed:@"selected"];
        self.title.backgroundColor = [UIColor greenColor];
    }else{
        self.image.image = [UIImage imageNamed:@"notSelected"];
        self.title.backgroundColor = [UIColor whiteColor];
    }
    _selected = selected;
}

@end



@interface MultipleOptionsView ()

/** 确定按钮 */
@property(nonatomic,strong)UIButton *confirmBtn;

/** 数据 */
@property(nonatomic,strong)NSArray *dataArray;

/** 背景view */
@property(nonatomic,strong)UIView *backView;

@end

@implementation MultipleOptionsView

-(void)clickAction:(UIButton *)sender{
    
    MyCustomeOptionView *option = [self viewWithTag:sender.tag - 100];
    option.selected = !option.selected;
    
}


+(instancetype)OptionsViewInitWithArray:(NSArray *)array SelectString:(NSString *)string CompleteBlock:(CompleteBlock)completeBlock{
    
    MultipleOptionsView *optionView = [[MultipleOptionsView alloc]initWithFrame:[UIScreen mainScreen].bounds andDataArray:array];
    
    optionView.complete = completeBlock;
    return optionView;
}


- (instancetype)initWithFrame:(CGRect)frame andDataArray:(NSArray *)array
{
    self = [super initWithFrame:frame];
    if (self) {
        self.dataArray = array;
        self.backgroundColor = [UIColor whiteColor];
        [self addViews];
    }
    return self;
}

-(void)addViews{
    
    NSInteger num;
    if (self.dataArray.count%2 == 0) {
        num = self.dataArray.count/2;
    }else{
        num = self.dataArray.count/2+1;
    }
    
    self.confirmBtn = [[UIButton alloc]initWithFrame:CGRectMake(Width/2-55, num*40+10, 80, 40)];
    [self.confirmBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [self.confirmBtn setTitle:@"确定" forState:(UIControlStateNormal)];
    [self.confirmBtn addTarget:self action:@selector(clicked:) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:self.confirmBtn];
    
    for (NSInteger i = 0 ; i < self.dataArray.count; i ++) {
        
        NSInteger row = i/2;
        CGFloat count = i % 2;
        MyCustomeOptionView *option = [[MyCustomeOptionView
                                        alloc]init];
        option.tag = 100 + i;
        option.frame = CGRectMake((Width/2 - 15) * count, 40*row , Width/2 -20, 30);
        option.title.text = self.dataArray[i];
        
        [self addSubview:option];
        
        UIButton *button = [[UIButton alloc]initWithFrame:option.frame];
        [self addSubview:button];
        button.tag = 200 + i;
        [button addTarget:self action:@selector(clickAction:) forControlEvents:(UIControlEventTouchUpInside)];
        
    }
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    //首先创建一个位于屏幕下方看不到的view
    self.backView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.backView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.45];
    self.backView.alpha = 0.0f;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self.backView addGestureRecognizer:tap];
    [[UIApplication sharedApplication].keyWindow addSubview:self.backView];
    CGFloat height = CGRectGetMaxY(self.confirmBtn.frame)+10;
    self.frame = CGRectMake(15,(Height-height)/2 , Width-30,height );
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
}

- (void)clicked:(UIButton *)sender
{
    if (self.complete) {
        NSMutableArray *selectedArray = [[NSMutableArray alloc]init];
        for (NSInteger i = 0 ; i < self.dataArray.count; i ++){
            MyCustomeOptionView *option = [self viewWithTag:100 +i];
            if (option.selected) {
                [selectedArray addObject:option.title.text];
            }
        }
        self.complete(selectedArray);
    }
    [self dismissPicker];
}

- (void)tapAction
{
    [self dismissPicker];
}

- (void)show
{
    if (self.selectedArray.count != 0) {
        for (NSInteger i = 0 ; i < self.dataArray.count; i ++){
            MyCustomeOptionView *option = [self viewWithTag:100 +i];
            for (NSString *string in self.selectedArray) {
                if ([option.title.text isEqualToString:string]) {
                    option.selected = YES;
                }
            }
        }
    }
    
    [UIView animateWithDuration:0.8f delay:0 usingSpringWithDamping:0.9f initialSpringVelocity:0.7f options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionLayoutSubviews animations:^{
        self.backView.alpha = 1.0;
    } completion:NULL];
}

- (void)dismissPicker
{
    if (self.backView) {
        [self.backView removeFromSuperview];
    }
    
    for (UIView *option in self.subviews) {
        [option removeFromSuperview];
    }
    [self removeFromSuperview];
}


@end
