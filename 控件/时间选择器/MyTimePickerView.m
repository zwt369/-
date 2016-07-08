//
//  MyTimePickerView.m
//  ZYSheetPicker
//
//  Created by Tony Zhang on 16/7/7.
//  Copyright © 2016年 Corki. All rights reserved.
//

#import "MyTimePickerView.h"

#define SCREEN_SIZE [UIScreen mainScreen].bounds.size
#define KScreenWidth  [UIScreen mainScreen].bounds.size.width

@interface MyTimePickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>

/** 小时数组 */
@property(nonatomic,strong)NSArray *hoursArray;

/** 分钟数组 */
@property(nonatomic,strong)NSArray *minutesArray;

/** 选取小时 */
@property(nonatomic,strong)NSString *selectedHour;

/** 选取分钟 */
@property(nonatomic,strong)NSString *selectedMinute;

/** 背景view */
@property(nonatomic,strong)UIView *backView;

/** 标题 */
@property(nonatomic,strong)UILabel *titleLab;

/** pickerView */
@property(nonatomic,strong)UIPickerView *pickerView;

/** 取消按钮 */
@property(nonatomic,strong)UIButton *cancelBtn;

/** 确定按钮 */
@property(nonatomic,strong)UIButton *confirmBtn;


@end


@implementation MyTimePickerView

+(instancetype)TimePickerWithHeadTitle:(NSString *)headTitle AndCompleteBlock:(CompleteBlock)completeBlock{

    MyTimePickerView *timePicker = [[MyTimePickerView alloc]initWithFrame:[UIScreen mainScreen].bounds HeadTitle:headTitle];
    timePicker.complete = completeBlock;
    return timePicker;
}

- (instancetype)initWithFrame:(CGRect)frame HeadTitle:(NSString *)headTitle{

    self = [super initWithFrame:frame];
    if (self) {
        [self addViews];
        self.titleLab.text = headTitle;
    }
    return self;
}

-(void)addViews{
    //首先创建一个位于屏幕下方看不到的view
    self.backView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.backView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.45];
    self.backView.alpha = 0.0f;
    UITapGestureRecognizer *g = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [self.backView addGestureRecognizer:g];
    [[[[UIApplication sharedApplication] delegate] window] addSubview:self.backView];
    
    //  标题
   self.titleLab = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_SIZE.width/2-75, 5, 150, 20)];
    self.titleLab.font = [UIFont systemFontOfSize:18];
    [self.titleLab setBackgroundColor:[UIColor clearColor]];
    [self.titleLab setTextAlignment:NSTextAlignmentCenter];
    [self.titleLab setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [self addSubview:self.titleLab];
    
    //取消按钮
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelBtn.frame = CGRectMake(2, 5, KScreenWidth*0.2, 20);
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"取消" attributes:
                                      @{ NSForegroundColorAttributeName: [UIColor grayColor],
                                         NSFontAttributeName :           [UIFont systemFontOfSize:14],
                                         NSUnderlineStyleAttributeName : @(NSUnderlineStyleNone) }];
    [self.cancelBtn setAttributedTitle:attrString forState:UIControlStateNormal];
    self.cancelBtn.adjustsImageWhenHighlighted = NO;
    self.cancelBtn.backgroundColor = [UIColor clearColor];
    [self.cancelBtn addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.cancelBtn];
    
    //完成按钮
    self.confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.confirmBtn.frame = CGRectMake(KScreenWidth-KScreenWidth*0.2-2, 5, KScreenWidth*0.2, 20);
    NSAttributedString *attrString2 = [[NSAttributedString alloc] initWithString:@"完成" attributes:
                                       @{ NSForegroundColorAttributeName: [UIColor grayColor],
                                          NSFontAttributeName :           [UIFont systemFontOfSize:14],
                                          NSUnderlineStyleAttributeName : @(NSUnderlineStyleNone) }];
    [self.confirmBtn setAttributedTitle:attrString2 forState:UIControlStateNormal];
    self.confirmBtn.adjustsImageWhenHighlighted = NO;
    self.confirmBtn.backgroundColor = [UIColor clearColor];
    [self.confirmBtn addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.confirmBtn];
    
    //选择器
   self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(5,22, SCREEN_SIZE.width-10, 230)];
    [self.pickerView setShowsSelectionIndicator:YES];
    [self.pickerView setDelegate:self];
    [self.pickerView setDataSource:self];
    [self addSubview:self.pickerView];
//    self.pickerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    //self
    self.backgroundColor = [UIColor whiteColor];
    [self setFrame:CGRectMake(0, SCREEN_SIZE.height-300, SCREEN_SIZE.width , 300)];
    self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleWidth;
    [[[[UIApplication sharedApplication] delegate] window] addSubview:self];
    [self setFrame: CGRectMake(0, SCREEN_SIZE.height,SCREEN_SIZE.width , 250)];

}

-(NSArray *)hoursArray{
    if (_hoursArray == nil) {
        _hoursArray = @[@"00",@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23"];
    }
    return _hoursArray;
}

-(NSArray *)minutesArray{

    if (_minutesArray == nil) {
        _minutesArray = @[@"00",@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31",@"32",@"33",@"34",@"35",@"36",@"37",@"38",@"39",@"40",@"41",@"42",@"43",@"44",@"45",@"46",@"47",@"48",@"49",@"50",@"51",@"52",@"53",@"54",@"55",@"56",@"57",@"58",@"59"];
    }
    return _minutesArray;
}

- (void)clicked:(UIButton *)sender
{
    if ([sender.titleLabel.text isEqualToString:@"确定"]) {
        [self dismissPicker];
    }else{
        if (self.complete) {
            self.complete(self,self.selectedHour,self.selectedMinute);
        }
        [self dismissPicker];
    }
}


#pragma mark - 该方法的返回值决定该控件包含多少列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView
{
    return 2;
}

#pragma mark - 该方法的返回值决定该控件指定列包含多少个列表项
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    if (component == 0) {
        return self.hoursArray.count;
    }else{
        
        return self.minutesArray.count;
    }
}

#pragma mark - 该方法返回的NSString将作为UIPickerView中指定列和列表项的标题文本
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) {
        return self.hoursArray[row];
    }else{
        return self.minutesArray[row];
    }
}

#pragma mark - 当用户选中UIPickerViewDataSource中指定列和列表项时激发该方法
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    //这个属性可以控制 标题栏。
    //self.titleLabel.text =self.dataArray[row];
    if (component == 0) {
        self.selectedHour = self.hoursArray[row];
        [pickerView reloadComponent:1];
        [pickerView selectRow:0 inComponent:1 animated:YES];
    }else{
        self.selectedMinute = self.minutesArray[row];
    }
}


- (void)tap
{
    [self dismissPicker];
}

- (void)show
{
    [UIView animateWithDuration:0.8f delay:0 usingSpringWithDamping:0.9f initialSpringVelocity:0.7f options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionLayoutSubviews animations:^{
        
        [[[[UIApplication sharedApplication] delegate] window] addSubview:self];
        self.backView.alpha = 1.0;
        
        self.frame = CGRectMake(0, SCREEN_SIZE.height-250, SCREEN_SIZE.width, 250);
    } completion:NULL];
}

- (void)dismissPicker
{
    [UIView animateWithDuration:0.8f delay:0 usingSpringWithDamping:0.9f initialSpringVelocity:0.7f options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionLayoutSubviews animations:^{
        self.backView.alpha = 0.0;
        self.frame = CGRectMake(0, SCREEN_SIZE.height,SCREEN_SIZE.width , 250);
        
    } completion:^(BOOL finished) {
        [self.backView removeFromSuperview];
        [self.titleLab removeFromSuperview];
        [self.cancelBtn removeFromSuperview];
        [self.confirmBtn removeFromSuperview];
        [self removeFromSuperview];
    }];
}



@end
