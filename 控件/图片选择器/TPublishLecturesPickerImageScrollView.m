//
//  TPublishLecturesPickerImageScrollView.m
//  XiangNanOnHand
//
//  Created by Tony Zhang on 16/6/3.
//  Copyright © 2016年 www.chsh8j.com. All rights reserved.
//

#import "TPublishLecturesPickerImageScrollView.h"
#import "Header.h"
#import "TMyCustomPhotoBrowserView.h"

@implementation TPublishLecturesPickerImageScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addViews];
    }
    return self;
}

-(void)addViews{
 
    self.addImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
    self.addImageView.image = [UIImage imageNamed:@"addImage"];
    self.addImageView.userInteractionEnabled = YES;
    self.index = 0;
    [self addSubview:self.addImageView];
}


-(NSMutableArray *)imageArray{

    if (_imageArray == nil) {
        _imageArray = [[NSMutableArray alloc]init];
    }
    return _imageArray;
}

-(void)addPicture:(UIImage *)image{
    switch (self.order) {
        case FIRST:
        {
            if (self.imageArray.count >= 5) {
                [APPDELEGATE showToast:@"最多添加5张照片"];
                return;
            }
            [self.imageArray addObject:image];
            self.index = self.imageArray.count-1;
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(70*self.index, 0, 60, 60)];
            imageView.image = image;
            imageView.userInteractionEnabled = YES;
            imageView.tag = self.index+100;
            [self addSubview:imageView];
            UIButton *showBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 45, 60)];
            [showBtn addTarget:self action:@selector(showBigPhotoWithImage:) forControlEvents:(UIControlEventTouchUpInside)];
            showBtn.tag = 300+self.index;
            [imageView addSubview:showBtn];
            UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(70*self.index + 45, 0, 15, 15)];
            [button setImage:[UIImage imageNamed:@"closeBtn"] forState:(UIControlStateNormal)];
            [button addTarget:self action:@selector(delePicture:) forControlEvents:(UIControlEventTouchUpInside)];
            button.tag = self.index+200;
            [self addSubview:button];
            self.addImageView.frame = CGRectMake(70*(self.index+1), 0, 60, 60);
            self.contentSize = CGSizeMake((self.index+3)*70, 60);
            if (self.index >= 2) {
                self.contentOffset = CGPointMake(70*(self.index-1)-20, 0);
            }
        }
            break;
            
        default:
        {
            [self.secondArray addObject:image];
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
            imageView.image = image;
            imageView.userInteractionEnabled = YES;
            imageView.tag = 400;
            [self addSubview:imageView];
            UIButton *showBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 45, 60)];
            [showBtn addTarget:self action:@selector(showSinglePhotoWithImage:) forControlEvents:(UIControlEventTouchUpInside)];
            showBtn.tag = 401;
            [imageView addSubview:showBtn];
            UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(45, 0, 15, 15)];
            [button setImage:[UIImage imageNamed:@"closeBtn"] forState:(UIControlStateNormal)];
            [button addTarget:self action:@selector(deleSinglePicture:) forControlEvents:(UIControlEventTouchUpInside)];
            button.tag = 402;
            [self addSubview:button];
        }
            break;
    }
}


-(void)delePicture:(UIButton *)sender{
    
    NSInteger index = sender.tag - 200;
    for (int i = 0; i  < self.imageArray.count; i ++) {
        if (i == index) {
            [[[[self viewWithTag:index+100] subviews]firstObject]removeFromSuperview];
            [[self viewWithTag:index+100]removeFromSuperview];
            [sender removeFromSuperview];
        }
        if (i > index) {
            UIImageView *imageView = [self viewWithTag:i + 100];
            UIButton *button = [self viewWithTag:i + 200];
            imageView.frame = CGRectMake(70*(i-1), 0, 60, 60);
            button.frame = CGRectMake(70*(i-1)+45, 0, 15, 15);
            imageView.tag = i +99;
            button.tag = i +199;
        }
    }
    if (self.imageArray) {
        [self.imageArray removeObjectAtIndex:index];
        self.index = self.imageArray.count-1;
    }
    self.contentSize = CGSizeMake((self.index+2)*70, 60);
    
    if (self.index >= 2) {
        self.contentOffset = CGPointMake(70*(self.index-1)-20, 0);
    }
   
    self.addImageView.frame = CGRectMake(70*(self.index+1), 0, 60, 60);
}

-(void)deleSinglePicture:(UIButton *)sender{

    [[self viewWithTag:401] removeFromSuperview];
    [[self viewWithTag:402]removeFromSuperview];
    [[self viewWithTag:400]removeFromSuperview];
    if (self.lecturerUrl) {
        [self.imageIdArray addObject:self.lecturerUrl.lectPictId];
    }
}

//-(void)addSinglePicture:(UIImage *)image{
//    
//    UIButton *showBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 45, 60)];
//    [showBtn addTarget:self action:@selector(showBigPhotoWithImage:) forControlEvents:(UIControlEventTouchUpInside)];
//    showBtn.backgroundColor = [UIColor redColor];
//    showBtn.tag = 401;
//    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
//    imageView.image = image;
//    imageView.tag = 402;
//    [imageView addSubview:showBtn];
//    [self addSubview:imageView];
//    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(70*self.index + 45, 0, 15, 15)];
//    [button setImage:[UIImage imageNamed:@"closeBtn"] forState:(UIControlStateNormal)];
//    [button addTarget:self action:@selector(deletSinglePicture) forControlEvents:(UIControlEventTouchUpInside)];
//    button.tag = 400;
//    [self addSubview:button];
//}
//
//-(void)deletSinglePicture{
//    
//    self.addImageView.image = [UIImage imageNamed:@"addImage"];
//    [[self viewWithTag:401] removeFromSuperview];
//    [[self viewWithTag:402]removeFromSuperview];
//    [[self viewWithTag:400]removeFromSuperview];
//    if (self.lecturerUrl) {
//        [self.imageIdArray addObject:self.lecturerUrl.lectPictId];
//    }
//}

#pragma mark +++++++    修改图片      +++++++++++

-(NSMutableArray *)imageIdArray{

    if (_imageIdArray == nil) {
        _imageIdArray = [[NSMutableArray alloc]init];
    }
    return _imageIdArray;
}

-(NSMutableArray *)imageNewArray{

    if (_imageNewArray == nil) {
        _imageNewArray = [[NSMutableArray alloc]init];
    }
    return _imageNewArray;
}

-(NSMutableArray *)secondArray{

    if (_secondArray == nil) {
        _secondArray = [[NSMutableArray alloc]init];
    }
    return _secondArray;
}

-(void)setImageArrayUrl:(NSArray *)imageArrayUrl{

    _imageArrayUrl = imageArrayUrl;
    for (int i = 0; i < imageArrayUrl.count; i ++) {
        TLecturePictureUrlModel *pictureModel = imageArrayUrl[i];
        NSArray * array = [pictureModel.lectThumbPictId componentsSeparatedByString:@"%22"];
        NSString *uuu = [array componentsJoinedByString:@"\""];
        NSString * contStr = [NSString stringWithFormat:@"%@",uuu];
        NSString *urlStr = [contStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url = [NSURL URLWithString:urlStr];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(70*i, 0, 60, 60)];
        [imageView sd_setImageWithURL:url];
        imageView.userInteractionEnabled = YES;
//        [self.imageArray addObject:imageView.image];
        imageView.tag = i+100;
        [self addSubview:imageView];
        UIButton *showBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 45, 60)];
        [showBtn addTarget:self action:@selector(showBigPhotoWithUrl:) forControlEvents:(UIControlEventTouchUpInside)];
        [imageView addSubview:showBtn];
        showBtn.tag = 300 + i;
     
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(70*i + 45, 0, 15, 15)];
        [button setImage:[UIImage imageNamed:@"closeBtn"] forState:(UIControlStateNormal)];
        [button addTarget:self action:@selector(deleNewPicture:) forControlEvents:(UIControlEventTouchUpInside)];
        button.tag = i+200;
        [self addSubview:button];
    }
        self.addImageView.frame = CGRectMake(70*(imageArrayUrl.count), 0, 60, 60);
        self.contentSize = CGSizeMake((imageArrayUrl.count+1)*70, 60);
    if (imageArrayUrl.count > 3) {
        self.contentOffset = CGPointMake(70*(imageArrayUrl.count-2)-20, 0);
    }
}


-(void)setLecturerUrl:(TLecturePictureUrlModel *)lecturerUrl{
    
    _lecturerUrl = lecturerUrl;
    NSArray * array = [lecturerUrl.lectDescPictId componentsSeparatedByString:@"%22"];
    NSString *uuu = [array componentsJoinedByString:@"\""];
    NSString * contStr = [NSString stringWithFormat:@"%@",uuu];
    NSString *urlStr = [contStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:urlStr];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
    imageView.tag = 400;
    imageView.userInteractionEnabled = YES;
    [imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"defaultsImage"]];
    [self addSubview:imageView];
    UIButton *showBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 45, 60)];
    [showBtn addTarget:self action:@selector(showBigPhotoWithUrl:) forControlEvents:(UIControlEventTouchUpInside)];
    [imageView addSubview:showBtn];
    showBtn.tag = 401;

    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(45, 0, 15, 15)];
    [button setImage:[UIImage imageNamed:@"closeBtn"] forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(deleSinglePicture:) forControlEvents:(UIControlEventTouchUpInside)];
    button.tag = 402;
    [self addSubview:button];
}

-(void)addNewPicture:(UIImage *)image{

    NSInteger total = self.imageArrayUrl.count - self.imageIdArray.count + self.imageNewArray.count;
//    NSInteger existent = self.imageArrayUrl.count - self.imageIdArray.count;
    if (total >= 5) {
        [APPDELEGATE showToast:@"最多添加5张照片"];
        return;
    }
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(70*total, 0, 60, 60)];
    imageView.image = image;
    imageView.tag = total+100;
    imageView.userInteractionEnabled = YES;
    [self addSubview:imageView];
    UIButton *showBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 45, 60)];
    [showBtn addTarget:self action:@selector(showNewBigPhotoWithImage:) forControlEvents:(UIControlEventTouchUpInside)];
    [imageView addSubview:showBtn];
    showBtn.tag = 300 + total;
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(70*total + 45, 0, 15, 15)];
    [button setImage:[UIImage imageNamed:@"closeBtn"] forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(deleNewPicture:) forControlEvents:(UIControlEventTouchUpInside)];
    button.tag = total+200;
    [self addSubview:button];
    self.addImageView.frame = CGRectMake(70*(total+1), 0, 60, 60);
    self.contentSize = CGSizeMake((total+3)*70, 60);
    [self.imageNewArray addObject:image];
    
}

-(void)deleNewPicture:(UIButton *)sender{

    NSLog(@"%lu",sender.tag);
    NSInteger index = sender.tag - 200;
    NSInteger total = self.imageArrayUrl.count - self.imageIdArray.count + self.imageNewArray.count;
    NSInteger existent = self.imageArrayUrl.count - self.imageIdArray.count;
    for (NSInteger i = 0; i < total; i ++) {
        if (i == index) {
            [[self viewWithTag:index+100]removeFromSuperview];
            [[self viewWithTag:index + 300]removeFromSuperview];
            [sender removeFromSuperview];
        }
        if (i > index) {
            UIImageView *imageView = [self viewWithTag:i + 100];
            UIButton *button = [self viewWithTag:i + 200];
            UIButton *showBtn = [self viewWithTag:i +300];
            imageView.frame = CGRectMake(70*(i-1), 0, 60, 60);
            button.frame = CGRectMake(70*(i-1)+45, 0, 15, 15);
            imageView.tag = i +99;
            button.tag = i +199;
            showBtn.tag = i + 299;
        }
    }
    self.contentSize = CGSizeMake(total*70, 60);
//    self.contentOffset = CGPointMake(70*(total-3)-20, 0);
    self.addImageView.frame = CGRectMake(70*(total-1), 0, 60, 60);
    if (index < self.imageArrayUrl.count - self.imageIdArray.count) {
        TLecturePictureUrlModel *pictureModel = _imageArrayUrl[index];
        [self.imageIdArray addObject:pictureModel.lectPictId];
    }else{
        [self.imageNewArray removeObjectAtIndex:index - existent];
    }
}


#pragma mark ++++++++    展示大图     +++++++

-(void)showBigPhotoWithImage:(UIButton *)sender{
    NSInteger index = sender.tag - 200;
    TMyCustomPhotoBrowserView *photoBrowser = [TMyCustomPhotoBrowserView photoBrowserView];
    NSMutableArray *array = [[NSMutableArray alloc]init];
    UIImageView *imageView = [self viewWithTag:index];
    UIImage *image = imageView.image;
//    NSString *string = self.model.lecturerUrl.lectDescPictId;
    [array addObject:image];
    photoBrowser.pictureArray = array;
    photoBrowser.currentIndex = 0;
    [[UIApplication sharedApplication].keyWindow addSubview:photoBrowser];
}

-(void)showSinglePhotoWithImage:(UIButton *)sender{
    TMyCustomPhotoBrowserView *photoBrowser = [TMyCustomPhotoBrowserView photoBrowserView];
    UIImageView *imageView = [self viewWithTag:400];
    UIImage *image = imageView.image;
     NSMutableArray *array = [[NSMutableArray alloc]init];
    [array addObject:image];
    photoBrowser.pictureArray = array;
    photoBrowser.currentIndex = 0;
    [[UIApplication sharedApplication].keyWindow addSubview:photoBrowser];
}


-(void)showBigPhotoWithUrl:(UIButton *)sender{
    NSInteger index = sender.tag - 300;
    TMyCustomPhotoBrowserView *photoBrowser = [TMyCustomPhotoBrowserView photoBrowserView];
    NSMutableArray *array = [[NSMutableArray alloc]init];
    TLecturePictureUrlModel *model = [[TLecturePictureUrlModel alloc]init];
    if (sender.tag == 401) {
        model = _lecturerUrl;
    }else{
        model = self.imageArrayUrl[index];
    }
    NSString *string = model.lectDescPictId;
    [array addObject:string];
    photoBrowser.pictureArray = array;
    photoBrowser.currentIndex = 0;
    [[UIApplication sharedApplication].keyWindow addSubview:photoBrowser];
}

-(void)showNewBigPhotoWithImage:(UIButton *)sender{

    NSInteger total = self.imageArrayUrl.count - self.imageIdArray.count;
    NSInteger index = sender.tag - 300 - total;
    TMyCustomPhotoBrowserView *photoBrowser = [TMyCustomPhotoBrowserView photoBrowserView];
    NSMutableArray *array = [[NSMutableArray alloc]init];
    UIImage *model = self.imageNewArray[index];
    [array addObject:model];
    photoBrowser.pictureArray = array;
    photoBrowser.currentIndex = 0;
    [[UIApplication sharedApplication].keyWindow addSubview:photoBrowser];
}



@end
