//
//  TMyCustomPhotoBrowserView.m
//  XiangNanOnHand
//
//  Created by Tony Zhang on 16/6/6.
//  Copyright © 2016年 www.chsh8j.com. All rights reserved.
//

#import "TMyCustomPhotoBrowserView.h"
#import "Header.h"

@interface TMyCustomPhotoBrowserView ()<UIScrollViewDelegate>

/** scrollView */
@property(nonatomic,strong)UIScrollView *scrollView;

/** page */
@property(nonatomic,strong)UILabel *page;

@end

@implementation TMyCustomPhotoBrowserView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addViews];
    }
    return self;
}

-(void)addViews{
    self.backgroundColor = [UIColor blackColor];
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT*0.1, SCREEN_WIDTH, SCREEN_HEIGHT*0.8)];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.tag = 1001;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.scrollView];
    
    self.page = [[UILabel alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT*0.9, SCREEN_WIDTH, SCREEN_HEIGHT*0.1)];
    self.page.backgroundColor = [UIColor clearColor];
    self.page.textColor = [UIColor whiteColor];
    self.page.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.page];
}


+(TMyCustomPhotoBrowserView *)photoBrowserView{

    return [[self alloc]initWithFrame:[UIScreen mainScreen].bounds];
}

-(void)setPictureArray:(NSArray *)pictureArray{

    _pictureArray = pictureArray;
    self.scrollView.delegate = self;
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH*pictureArray.count, 0);
    if ([[pictureArray firstObject]isKindOfClass:[UIImage class]]) {
        for (int i = 0; i < pictureArray.count; i ++) {
            UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*i, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.8)];
            scrollView.delegate = self;
            scrollView.maximumZoomScale = 2.5;
            scrollView.minimumZoomScale = 1;
            [self.scrollView addSubview:scrollView];
            UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH , SCREEN_HEIGHT*0.8)];
            image.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeSelfFromSuperView)];
            [image addGestureRecognizer:tap];
            image.image = pictureArray[i];
            [scrollView addSubview:image];
        }

    }else{
        for (int i = 0; i < pictureArray.count; i ++) {
            UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*i, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.8)];
            scrollView.delegate = self;
            scrollView.maximumZoomScale = 2.5;
            scrollView.minimumZoomScale = 1;
            [self.scrollView addSubview:scrollView];
            UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH , SCREEN_HEIGHT*0.8)];
            image.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeSelfFromSuperView)];
            [image addGestureRecognizer:tap];
            NSArray * array = [pictureArray[i] componentsSeparatedByString:@"%22"];
            NSString *uuu = [array componentsJoinedByString:@"\""];
            NSString * contStr = [NSString stringWithFormat:@"%@",uuu];
            NSString *urlStr = [contStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [image sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"defaultsImage"]];
            [scrollView addSubview:image];
        }
    }
  
}



-(void)setCurrentIndex:(NSInteger)currentIndex{

    if (self.pictureArray.count != 0) {
        self.page.text = [NSString stringWithFormat:@"%ld/%lu",(long)currentIndex+1,(unsigned long)_pictureArray.count];
    }

    self.scrollView.contentOffset = CGPointMake(SCREEN_WIDTH*currentIndex, 0);
    _currentIndex = currentIndex;
}



-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if (scrollView.tag == 1001) {
        NSInteger count = (scrollView.contentOffset.x+SCREEN_WIDTH*0.5)/SCREEN_WIDTH;
//        NSInteger displace = scrollView.contentOffset.x/SCREEN_WIDTH;
        self.page.text = [NSString stringWithFormat:@"%ld/%lu",(long)count+1,(unsigned long)self.pictureArray.count];
        if (count >= 0 && count < self.pictureArray.count-1) {
          
            for (UIScrollView *view in scrollView.subviews) {
                if ([view isKindOfClass:[UIScrollView class]]) {
                    [view setZoomScale:1.0];
                }
            }
        }
    }
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
   
    for (UIView *view in scrollView.subviews) {
        return view;
    }
    return nil;
}


-(void)removeSelfFromSuperView{

    [self removeFromSuperview];
}


@end
