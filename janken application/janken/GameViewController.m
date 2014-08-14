//
//  GameViewController.m
//  janken
//
//  Created by a-ando on 2014/06/20.
//  Copyright (c) 2014年 a-ando. All rights reserved.
//

#import "GameViewController.h"

@interface GameViewController ()

@end

@implementation GameViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)jankenDidPush:(UIButton *)sender {
    
    int count = 0;
    
    
    //一度表示した文字を消去する
    self.gu.hidden = YES;
    self.choki.hidden = YES;
    self.pa.hidden = YES;
    self.kachi.hidden = YES;
    self.make.hidden = YES;
    self.aiko.hidden = YES;
    
    //相手の手をランダムに出す
    int aite_no_te = arc4random()%3;
    
    if(aite_no_te == 0){
        self.pa.hidden = NO;
        
    }
    
    else if(aite_no_te == 1){
        self.choki.hidden = NO;
        
    }else if(aite_no_te == 2){
            self.gu.hidden = NO;
    }
    
    int jibun_no_te = sender.tag;
    
    if( aite_no_te == jibun_no_te){
        self.aiko.hidden = NO;
        
    }else if (aite_no_te == 0 && jibun_no_te == 2){
        self.make.hidden = NO;
        
    }else if(aite_no_te == 1 && jibun_no_te ==0){
        self.make.hidden = NO;
        
    }else if(aite_no_te == 2 && jibun_no_te == 1){
        self.make.hidden = NO;
        
    }else{
        self.kachi.hidden = NO;
        count++;
    }

    if(count == 3)
        self.goal.hidden = NO;
    
    
    
}
@end
