//
//  UIImage+FixOrientation.h
//  XiangNanOnHand
//
//  Created by Tony Zhang on 16/6/30.
//  Copyright © 2016年 www.chsh8j.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (FixOrientation)

/**
 *  解决图片选择器选择图片时，图片旋转的问题
 */
- (UIImage *)fixOrientation:(UIImage *)aImage;

@end
