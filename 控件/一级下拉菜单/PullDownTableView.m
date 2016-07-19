//
//  PullDownTableView.m
//  TextDemo
//
//  Created by Tony Zhang on 16/7/8.
//  Copyright © 2016年 Tony Zhang. All rights reserved.
//

#import "PullDownTableView.h"

#define Width [UIScreen mainScreen].bounds.size.width
#define Height [UIScreen mainScreen].bounds.size.height


@interface PullDownTableView ()<UITableViewDelegate,UITableViewDataSource>

/** tableView */
@property(nonatomic,strong)UITableView *tableView;

/** 数据 */
@property(nonatomic,strong)NSArray *dataArray;

/** 背景 */
@property(nonatomic,strong)UIView *backView;

/** 初始化frame */
@property(nonatomic,assign)CGRect rect;

@end

@implementation PullDownTableView

+(instancetype)TableViewInitWithArray:(NSArray *)array andFrame:(CGRect)frame CompleteBlock:(CompleteBlock)completeBlock{

    PullDownTableView *pullTableView = [[PullDownTableView alloc]initWithFrame:frame];
    pullTableView.complete = completeBlock;
    pullTableView.dataArray = array;
    return pullTableView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.rect = frame;
       
        [self addViews];
    }
    return self;
}


-(void)addViews{
    
    self.backView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.backView.backgroundColor = [UIColor clearColor];
    [[UIApplication sharedApplication].keyWindow addSubview:self.backView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissTableView)];
    [self.backView addGestureRecognizer:tap];
    
    self.frame = CGRectMake(self.rect.origin.x, self.rect.origin.y, self.rect.size.width, 0);
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.rect.size.width, 0)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.tableView];
     self.tableView.backgroundColor = [UIColor colorWithRed:230/256.0 green:230/256.0 blue:230/256.0 alpha:1];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"];
    }
    NSString *string = self.dataArray[indexPath.row];
    cell.textLabel.text = string;
   cell.backgroundColor = [UIColor colorWithRed:230/256.0 green:230/256.0 blue:230/256.0 alpha:1];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 30;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    self.complete(self.dataArray[indexPath.row]);
    [self dismissTableView];
    
}

-(void)dismissTableView{
    [self.backView removeFromSuperview];
    [self.tableView removeFromSuperview];
    [self removeFromSuperview];
}

-(void)show{

    [UIView animateWithDuration:0.5 animations:^{
        self.frame = self.rect;
        self.tableView.frame = CGRectMake(0, 0, self.rect.size.width, self.rect.size.height);
;
    }];
    
}


@end
