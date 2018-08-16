//
//  Factory.m
//  PrivateAlbum
//
//  Created by PengXiaodong on 2018/1/31.
//  Copyright © 2018年 PengXiaodong. All rights reserved.
//

#import "Factory.h"

@implementation Factory

+ (UIImageView *)imageViewWithFrame:(CGRect)frame
                               name:(NSString *)name
                                tag:(NSInteger)tag
                             hidden:(BOOL)hidden
                          container:(UIView *)container{
    UIImageView *imageView =[[UIImageView alloc] initWithFrame:frame];
    imageView.image = [UIImage imageNamed:name];
    imageView.tag = tag;
    imageView.hidden = hidden;
    [container addSubview:imageView];
    
    return imageView;
}

+ (ChangableImageView *)imageViewWithFrame:(CGRect)frame
                                normalName:(NSString *)normal
                                 wrongName:(NSString *)wrong
                                       tag:(NSInteger)tag
                                    hidden:(BOOL)hidden
                                 container:(UIView *)container{
    ChangableImageView *imageView = [[ChangableImageView alloc] initWithFrame:frame];
    imageView.normalImageName = normal;
    imageView.wrongImageName = wrong;
    imageView.tag = tag;
    imageView.hidden = hidden;
    [container addSubview:imageView];
    [imageView showNormalImage];
    
    return imageView;
}
@end












