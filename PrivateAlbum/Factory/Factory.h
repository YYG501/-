//
//  Factory.h
//  PrivateAlbum
//
//  Created by PengXiaodong on 2018/1/31.
//  Copyright © 2018年 PengXiaodong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChangableImageView.h"

@interface Factory : NSObject
/*
 创建一个图片
 */
+ (UIImageView *)imageViewWithFrame:(CGRect)frame
                               name:(NSString *)name
                                tag:(NSInteger)tag
                             hidden:(BOOL)hidden
                          container:(UIView *)container;

+ (ChangableImageView *)imageViewWithFrame:(CGRect)frame
                                normalName:(NSString *)normal
                                 wrongName:(NSString *)wrong
                                       tag:(NSInteger)tag
                             hidden:(BOOL)hidden
                          container:(UIView *)container;
@end













