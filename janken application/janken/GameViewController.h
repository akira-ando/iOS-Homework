//
//  GameViewController.h
//  janken
//
//  Created by a-ando on 2014/06/20.
//  Copyright (c) 2014年 a-ando. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *pa;

@property (weak, nonatomic) IBOutlet UIImageView *choki;

@property (weak, nonatomic) IBOutlet UIImageView *gu;

@property (weak, nonatomic) IBOutlet UILabel *kachi;

@property (weak, nonatomic) IBOutlet UILabel *make;

@property (weak, nonatomic) IBOutlet UILabel *aiko;

@property (weak, nonatomic) IBOutlet UILabel *goal;

- (IBAction)jankenDidPush:(UIButton *)sender;

@end
