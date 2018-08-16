//
//  ChangableImageView.m
//  PrivateAlbum
//
//  Created by PengXiaodong on 2018/1/31.
//  Copyright © 2018年 PengXiaodong. All rights reserved.
//

#import "ChangableImageView.h"

@implementation ChangableImageView

- (void)showNormalImage{
    self.image = [UIImage imageNamed:self.normalImageName];
}
- (void)showWrongImage{
    self.image = [UIImage imageNamed:self.wrongImageName];
}

@end












