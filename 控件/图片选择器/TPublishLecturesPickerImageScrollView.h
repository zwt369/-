//
//  TPublishLecturesPickerImageScrollView.h
//  XiangNanOnHand
//
//  Created by Tony Zhang on 16/6/3.
//  Copyright © 2016年 www.chsh8j.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLecturePictureUrlModel.h"

typedef enum : NSUInteger {
    FIRST,
    SECOND,
} ORDEROFPICKER;

@interface TPublishLecturesPickerImageScrollView : UIScrollView

/** pickerView的次序 */
@property(nonatomic,assign)ORDEROFPICKER order;

/** addImageView */
@property(nonatomic,strong)UIImageView *addImageView;

/** 将要添加图片的index */
@property(nonatomic,assign)NSInteger index;

/** 图片数组 */
@property(nonatomic,strong)NSMutableArray *imageArray;

/** 同一个页面上其他pickerView图片数组 */
@property(nonatomic,strong)NSMutableArray *secondArray;;

-(void)addPicture:(UIImage *)image;

#pragma mark +++++++  修改图片   ++++++++

/** 图片url数组 */
@property(nonatomic,strong)NSArray *imageArrayUrl;

/** 单张主讲人图片 */
@property(nonatomic,strong)TLecturePictureUrlModel *lecturerUrl;

/** 需要修改的图片ID数组 */
@property(nonatomic,strong)NSMutableArray *imageIdArray;

/** 新上传图片数组 */
@property(nonatomic,strong)NSMutableArray *imageNewArray;

-(void)addNewPicture:(UIImage *)image;

@end
