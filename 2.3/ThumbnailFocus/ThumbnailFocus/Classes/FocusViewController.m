//
//  FocusViewController.m
//  ThumbnailFocus
//
//  Created by 鄭 基旭 on 2013/04/18.
//  Copyright (c) 2013年 鄭 基旭. All rights reserved..
//

#import "FocusViewController.h"

static NSTimeInterval const kDefaultOrientationAnimationDuration = 0.4;

@interface FocusViewController ()
@property (nonatomic, assign) UIDeviceOrientation previousOrientation;
@end

#warning 「⬇ Answer：」マークがあるラインにコメントで簡単な解説文を書いてください。

@implementation FocusViewController

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.mainImageView = nil;
    self.contentView = nil;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // ⬇Answer：NSNotificationCenterに向きの変化感知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(orientationDidChangeNotification:)
                                                 name:UIDeviceOrientationDidChangeNotification object:nil];
    // ⬇Answer： 向きの変化感知
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // ⬇Answer：通知受信停止
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
    // ⬇Answer：回転無効化
    [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
}

- (NSUInteger)supportedInterfaceOrientations
{
    // ⬇Answer：縦表示
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)isParentSupportingInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    switch(toInterfaceOrientation)
    {
        case UIInterfaceOrientationPortrait:
            return [self.parentViewController supportedInterfaceOrientations] & UIInterfaceOrientationMaskPortrait;

        case UIInterfaceOrientationPortraitUpsideDown:
            return [self.parentViewController supportedInterfaceOrientations] & UIInterfaceOrientationMaskPortraitUpsideDown;

        case UIInterfaceOrientationLandscapeLeft:
            return [self.parentViewController supportedInterfaceOrientations] & UIInterfaceOrientationMaskLandscapeLeft;

        case UIInterfaceOrientationLandscapeRight:
            return [self.parentViewController supportedInterfaceOrientations] & UIInterfaceOrientationMaskLandscapeRight;
    }
}


//////////////////////////////////////////////////////////////
// ⬇Answer： 次の関数は回転時のアニメーションを担当しています。
//　82ラインから140ラインまで、すべてのラインにコメントを書いてください。
//////////////////////////////////////////////////////////////
- (void)updateOrientationAnimated:(BOOL)animated
{
    //Affine変換
    CGAffineTransform transform;
    //秒数表示
    NSTimeInterval duration = kDefaultOrientationAnimationDuration;

    //同方向の場合何もせず
    
    if([UIDevice currentDevice].orientation == self.previousOrientation)
        return;

    //アニメーション時間を倍にすることで、２コマ分の処理を施す
    if((UIInterfaceOrientationIsLandscape([UIDevice currentDevice].orientation) && UIInterfaceOrientationIsLandscape(self.previousOrientation))
       || (UIInterfaceOrientationIsPortrait([UIDevice currentDevice].orientation) && UIInterfaceOrientationIsPortrait(self.previousOrientation)))
    {
        duration *= 2;
    }

    
    //画面が縦及び親クラスが画像回転許可している場合に画像を初期状態に戻す
    if(([UIDevice currentDevice].orientation == UIInterfaceOrientationPortrait)
       || [self isParentSupportingInterfaceOrientation:(UIInterfaceOrientation)[UIDevice currentDevice].orientation]) {
        //初期画面化
        transform = CGAffineTransformIdentity;
    }else {
        //　画面依存処理
        switch ([UIDevice currentDevice].orientation){
            //ホームボタンの位置が左の場合
            case UIInterfaceOrientationLandscapeLeft:
                if(self.parentViewController.interfaceOrientation == UIInterfaceOrientationPortrait) {
                    //現在の設定から反時計周り90°回転
                    transform = CGAffineTransformMakeRotation(-M_PI_2);
                }else {
                    //現在の設定から時計回りに90°回転
                    transform = CGAffineTransformMakeRotation(M_PI_2);
                }
                break;
            // ホームボタンの位置が右の場合
            case UIInterfaceOrientationLandscapeRight:
                //状態が、ホームボタンが下にある場合
                if(self.parentViewController.interfaceOrientation == UIInterfaceOrientationPortrait) {
                    //現在の設定から時計回り90°回転
                    transform = CGAffineTransformMakeRotation(M_PI_2);
                }else {
                    //現在の設定から反時計回り90°回転
                    transform = CGAffineTransformMakeRotation(-M_PI_2);
                }
                break;
            // ホームボタンの位置が下の場合
            case UIInterfaceOrientationPortrait:
                //画面を元に戻す
                transform = CGAffineTransformIdentity;
                break;
            // ホームボタンの位置が上の場合
            case UIInterfaceOrientationPortraitUpsideDown:
                //時計周りに１８０°回転
                transform = CGAffineTransformMakeRotation(M_PI);
                break;
            //画面が下向きの場合
            case UIDeviceOrientationFaceDown:
            //画面が上向きの場合
            case UIDeviceOrientationFaceUp:
            //向きが取得出来ない場合
            case UIDeviceOrientationUnknown:
                return;
        }
    }
    // frameに初期値(0,0)を設定
    CGRect frame = CGRectZero;
    
    //updateOrientationAnimatedが、YESで発火されたとき
    if(animated) {
        
        //現在の状態をframeに格納
        frame = self.contentView.frame;
        
        //アニメーション実行
        
        [UIView animateWithDuration:duration
                        animations:^{
                             self.contentView.transform = transform;
                             self.contentView.frame = frame;
                         }];
    }else {
        //アニメーションなし
        frame = self.contentView.frame;
        self.contentView.transform = transform;
        self.contentView.frame = frame;
    }
    //比較のため、画面保持
    self.previousOrientation = [UIDevice currentDevice].orientation;
}

#pragma mark - Notifications
// ⬇Answer：画面の向き変更時
- (void)orientationDidChangeNotification:(NSNotification *)notification
{
    //updateOrientationAnimatedを発火
    [self updateOrientationAnimated:YES];
}
@end