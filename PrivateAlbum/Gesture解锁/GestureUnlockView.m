//
//  GestureUnlockView.m
//  PrivateAlbum
//
//  Created by PengXiaodong on 2018/1/31.
//  Copyright © 2018年 PengXiaodong. All rights reserved.
//

#import "GestureUnlockView.h"
#import "Factory.h"

#define kHidden YES

@interface GestureUnlockView ()
@property (nonatomic, strong) UILabel *alertLabel;
//保存9个点视图的数组
@property (nonatomic, strong) NSMutableArray *nineDotViewArray;
//保存所有的线条的tag值 NSNumber
@property (nonatomic, strong) NSMutableArray *allLineTagsArray;
//记录上一个点亮的点的tag值
@property (nonatomic, assign) NSInteger lastSelectedDotTag;
//记录每次划过的每个点的tag组成的字符串 当做密码
@property (nonatomic, strong) NSMutableString *passwordString;
//记录设置密码中第一次输入的密码字符串
@property (nonatomic, strong) NSString *firtTimePasswordString;
//记录所有点亮的视图
@property (nonatomic, strong) NSMutableArray *allSelectedViewsArray;
//保存原有的密码
@property (nonatomic, strong) NSString *originPasswordString;
@end

@implementation GestureUnlockView

//重写initWithFrame方法
//因为创建一个视图对象 我们通常使用[[ClassA alloc】initWithFrame:self.view];也就是说会调用initWithFrame方法来初始化这个视图对象,那么对于这个视图上面的内容如何显示 就应该在这个方法里面去写
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self != nil) {
        //在这里布局这个界面
        [self initUI];
    }
    return self;
}
#pragma mark ------- 初始化图片 ---------
//初始化界面上面的控件
- (void)initUI{
    //1.设置背景图片
    //[Factory imageViewWithFrame:self.frame name:@"Main_BG" tag:0 container:self];
    
    //2.创建默认的点的图片
    [Factory imageViewWithFrame:CGRectMake((self.frame.size.width-320)/2.0, 85, 320, 460) name:@"Unlock_DotLock1_Normal" tag:0 hidden:NO container:self];
    
    //3.添加用于提示用户操作的label
    self.alertLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 170, self.frame.size.width-100, 50)];
    _alertLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_alertLabel];
    
    //获取userDefaults里面保存的密码
    NSString *password = [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
    if (password.length == 0) {
        //第一次
        self.alertLabel.text = @"请设置密码图案";
    } else{
        //已经有密码了
        self.alertLabel.text = @"请绘制解锁密码";
        self.originPasswordString = password;
    }
    
    //初始化数组
    self.nineDotViewArray = [NSMutableArray arrayWithCapacity:9];
    self.allLineTagsArray = [NSMutableArray arrayWithCapacity:20];
    self.passwordString = [NSMutableString string];
    self.allSelectedViewsArray = [NSMutableArray array];
    
    //6根横线
    [self initAcrossLine];
    //6根竖线
    [self initVerticalLine];
    //添加斜线
    [self initSlopeLine];

    //添加9个点
    [self initNineDot];
    
}

//1 2 3
//4 5 6
//7 8 9
- (void)initNineDot{
    int index = 1;
    for (int i = 0; i < 3; i++) {
        CGFloat startX = 63;
        for (int j = 0; j < 3; j++){
            ChangableImageView *dotView = [Factory imageViewWithFrame:CGRectMake(startX + j*99, 250+i*99, 52, 52) normalName:@"Unlock_DotLock1_Selected" wrongName:@"Unlock_DotLock_Wrong1" tag:index hidden:kHidden container:self];
            [self.nineDotViewArray addObject:dotView];
            index++;
        }
    }
    //NSLog(@"%@", self.nineDotViewArray);
}

/*
 12 23
 45 56
 78 89
 */
- (void)initAcrossLine{
    int index = 12;
    for (int i = 0; i < 3; i++) {
        CGFloat startX = 70;
        for (int j = 0; j < 2; j++){
            ChangableImageView *lineImageView = [Factory imageViewWithFrame:CGRectMake(startX + j*99, 255+i*99, 120, 37) normalName:@"Unlock_DotLock1_Normal_Highlight1" wrongName:@"Unlock_DotLock1_Wrong_Highlight1" tag:index hidden:kHidden container:self];
            [self.allLineTagsArray addObject:[NSNumber numberWithInteger:lineImageView.tag]];
            index += 11;
        }
        
        index += 11;
    }
}

/*
 14 25 36
 47 58 69
 */
- (void)initVerticalLine{
    int index = 14;
    for (int i = 0; i < 2; i++) {
        CGFloat startX = 70;
        for (int j = 0; j < 3; j++){
            ChangableImageView *lineImageView = [Factory imageViewWithFrame:CGRectMake(startX + j*99, 255+i*99, 37, 120) normalName:@"Unlock_DotLock1_Normal_Highlight2" wrongName:@"Unlock_DotLock1_Wrong_Highlight2" tag:index hidden:kHidden container:self];
            [self.allLineTagsArray addObject:[NSNumber numberWithInteger:lineImageView.tag]];
            index += 11;
        }
    }
}

/*
 15 26
 48 59
 
 24 35
 57 68
 */
- (void)initSlopeLine{
    int rigthIndex = 15;
    int leftIndex = 24;
    for (int i = 0; i < 2; i++){
        CGFloat startX = 70;
        for(int j = 0; j < 2; j++){
            ChangableImageView *rightLineImageView = [Factory imageViewWithFrame:CGRectMake(startX + j*99, 255+i*99, 120, 120) normalName:@"Unlock_DotLock1_Normal_Highlight3" wrongName:@"Unlock_DotLock1_Wrong_Highlight3" tag:rigthIndex hidden:kHidden container:self];
            [self.allLineTagsArray addObject:[NSNumber numberWithInteger:rightLineImageView.tag]];
            rigthIndex += 11;

            ChangableImageView *leftLineImageView = [Factory imageViewWithFrame:CGRectMake(startX+14 + j*99, 255+i*99, 120, 120) normalName:@"Unlock_DotLock1_Normal_Highlight4" wrongName:@"Unlock_DotLock1_Wrong_Highlight4" tag:leftIndex hidden:kHidden container:self];
            [self.allLineTagsArray addObject:[NSNumber numberWithInteger:leftLineImageView.tag]];
            leftIndex += 11;
            
        }
        rigthIndex += 11;
        leftIndex += 11;
    }
}

#pragma mark ------- 处理触摸事件 ---------
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //获取触摸点的坐标
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self];
    
    //判断location是否在某一个dotview上
    for (ChangableImageView *dotView in self.nineDotViewArray) {
        if (CGRectContainsPoint(dotView.frame, location)) {
            //点亮第一个点
            dotView.hidden = NO;
            //记录这个点的tag
            self.lastSelectedDotTag = dotView.tag;
            //记录密码
            [self.passwordString appendFormat:@"%ld",dotView.tag];
            //记录点亮的视图
            [self.allSelectedViewsArray addObject:dotView];
        }
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //获取触摸点的坐标
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self];
    
    //判断location是否在某一个dotview上
    for (ChangableImageView *dotView in self.nineDotViewArray) {
        if (CGRectContainsPoint(dotView.frame, location)) {
            //判断是不是第一个点
            if (self.lastSelectedDotTag == 0){
                //第一个点 直接点亮
                dotView.hidden = NO;
                self.lastSelectedDotTag = dotView.tag;
                //记录密码
                [self.passwordString appendFormat:@"%ld",dotView.tag];
                //记录点亮的视图
                [self.allSelectedViewsArray addObject:dotView];
            } else{
                //判断路径是否可达 两个点的tag值来判断 small * 10 + big
                NSInteger lineTag = _lastSelectedDotTag > dotView.tag ? dotView.tag*10+_lastSelectedDotTag : _lastSelectedDotTag*10 + dotView.tag;
                
                if ([self.allLineTagsArray containsObject:[NSNumber numberWithInteger:lineTag]]) {
                    UIImageView *lineView = [self viewWithTag:lineTag];
                    if (dotView.hidden == YES) {
                        //路径可达
                        //点亮点 点亮线
                        dotView.hidden = NO;
                        
                        
                        lineView.hidden = NO;
                        
                        _lastSelectedDotTag = dotView.tag;
                        
                        //记录密码
                        [self.passwordString appendFormat:@"%ld",dotView.tag];
                        //记录点亮的视图
                        [self.allSelectedViewsArray addObject:dotView];
                        [self.allSelectedViewsArray addObject:lineView];
                    }
                }
            }
        }
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //判断之前有没有设置过密码
    if (self.originPasswordString.length == 0){
        //开始设置密码
        //判断是不是设置密码的第一次
        if (self.firtTimePasswordString.length == 0){
            //第一次
            self.firtTimePasswordString = [NSString stringWithString:self.passwordString];
            //提示用户确认图案
            self.alertLabel.text = @"请确认密码图案";
            //隐藏点亮的视图
            [self hideAllSelectedView];
        } else{
            //判断第一次和第二次是否一致
            if ([self.passwordString isEqualToString:self.firtTimePasswordString]){
                self.alertLabel.text = @"密码设置成功";
                
                //保存密码
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                [userDefaults setObject:self.passwordString forKey:@"password"];
                [userDefaults synchronize];
                
                //隐藏第阿娘的视图
                [self hideAllSelectedView];
            } else{
                self.alertLabel.text = @"密码不一致 请再次绘制";
                self.firtTimePasswordString = @"";
                [self changeToWrongImage];
            }
        }
    } else{
        if ([self.originPasswordString isEqualToString:self.passwordString]) {
            self.alertLabel.text = @"解锁成功";
            [self hideAllSelectedView];
            //进入主界面
        } else{
            self.alertLabel.text = @"解锁失败 重新绘制";
            [self changeToWrongImage];
        }
    }
    
}

- (void)changeToWrongImage{
    for (ChangableImageView *selectImageView in self.allSelectedViewsArray) {
        [selectImageView showWrongImage];
    }
    
    //过几秒再消失
    [self performSelector:@selector(hideAllSelectedView) withObject:nil afterDelay:1];
}

//隐藏所有点亮的视图
- (void)hideAllSelectedView{
    for (ChangableImageView *selectedView in self.allSelectedViewsArray) {
        selectedView.hidden = YES;
        [selectedView showNormalImage];
    }
    [self.passwordString setString:@""];
    self.lastSelectedDotTag = 0;
}
@end









