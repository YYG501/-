//
//  ViewController.m
//  PrivateAlbum
//
//  Created by PengXiaodong on 2018/1/31.
//  Copyright © 2018年 PengXiaodong. All rights reserved.
//

#import "ViewController.h"
#import "GestureUnlockView.h"
#import "PINUnlockView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //NSUserDefaults 持久化 用来保存用户少量的数据 用户名 密码 图片
    //特点：整个程序 只有一个userDefaults对象
    //1.获取唯一的那个对象
    //NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //2.使用方式和字典类似
    //[userDefaults setObject:@"123" forKey:@"password"];
    //[userDefaults objectForKey:@"password"];
    
    //判断到底是加载Gestue的还是PIN的
    //unlocktype - 1 2
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //读取用户的设置 @"1"  @"2"
    //[userDefaults setObject:@"1" forKey:@"unlocktype"];
    NSString *type = [userDefaults objectForKey:@"unlocktype"];
    if ([type isEqualToString:@"1"]){
        //手势解锁
        GestureUnlockView *guv = [[GestureUnlockView alloc] initWithFrame:self.view.frame];
        [self.view addSubview:guv];
    } else{
        //pin解锁
        PINUnlockView *puv = [[PINUnlockView alloc] initWithFrame:self.view.frame];
        [self.view addSubview:puv];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
