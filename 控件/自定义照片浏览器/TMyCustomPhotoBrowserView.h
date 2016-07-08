//
//  TMyCustomPhotoBrowserView.h
//  XiangNanOnHand
//
//  Created by Tony Zhang on 16/6/6.
//  Copyright © 2016年 www.chsh8j.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TMyCustomPhotoBrowserView : UIView

+(TMyCustomPhotoBrowserView *)photoBrowserView;

/** url数组 */
@property(nonatomic,strong)NSArray *pictureArray;

///** 讲座图片数组 */
//@property(nonatomic,strong)NSArray *pictureArray;
//
///** 提问图片数组 */
//@property(nonatomic,strong)NSArray *questionArray;

/** 当前index */
@property(nonatomic,assign)NSInteger currentIndex;

@end
