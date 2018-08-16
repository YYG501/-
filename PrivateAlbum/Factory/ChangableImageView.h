//
//  ChangableImageView.h
//  PrivateAlbum
//
//  Created by PengXiaodong on 2018/1/31.
//  Copyright © 2018年 PengXiaodong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangableImageView : UIImageView
//记录正常显示的图片
@property (nonatomic, strong) NSString *normalImageName;
//记录错误状态的图片
@property (nonatomic, strong) NSString *wrongImageName;

//切换图片的方法
- (void)showNormalImage;
- (void)showWrongImage;

@end












