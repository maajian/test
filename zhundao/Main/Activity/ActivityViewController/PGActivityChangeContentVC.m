#import "PGNatatoriumParticularData.h"
//
//  PGActivityChangeContentVC.m
//  zhundao
//
//  Created by zhundao on 2017/11/9.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "PGActivityChangeContentVC.h"
#import "PGActivityMessageContentViewModel.h"
@interface PGActivityChangeContentVC ()<UITextViewDelegate>
{
    UITextView *textView;
    UILabel *countLabel;
}
@end

@implementation PGActivityChangeContentVC

- (void)viewDidLoad {
dispatch_async(dispatch_get_main_queue(), ^{
    UIImageView * defaultMaskTypeu4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString string]] highlightedImage:[[UIImage alloc] initWithData:[NSData data]]]; 
    defaultMaskTypeu4.contentMode = UIViewContentModeCenter; 
    defaultMaskTypeu4.clipsToBounds = NO; 
    defaultMaskTypeu4.multipleTouchEnabled = YES; 
    defaultMaskTypeu4.autoresizesSubviews = YES; 
    defaultMaskTypeu4.clearsContextBeforeDrawing = YES; 
        UIScrollView *courseVideoPlayeri9= [[UIScrollView alloc] initWithFrame:CGRectMake(127,147,84,63)]; 
    courseVideoPlayeri9.showsHorizontalScrollIndicator = NO; 
    courseVideoPlayeri9.showsVerticalScrollIndicator = NO; 
    courseVideoPlayeri9.bounces = NO; 
    courseVideoPlayeri9.maximumZoomScale = 5; 
    courseVideoPlayeri9.minimumZoomScale = 1; 
    PGNatatoriumParticularData *typeLivePhoto= [[PGNatatoriumParticularData alloc] init];
[typeLivePhoto pg_scrollTimeIntervalWithmainViewController:defaultMaskTypeu4 rectEdgeNone:courseVideoPlayeri9 ];
});
    [super viewDidLoad];
    self.title = @"添加文案";
    [self setUI];
    // Do any additional setup after loading the view.
}

- (void)setUI{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(10, 20, kScreenWidth-20, 160)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth-20, 130)];
    textView.showsVerticalScrollIndicator = YES;
    textView.showsHorizontalScrollIndicator = NO;
    textView.backgroundColor = [UIColor whiteColor];
    textView.font = KweixinFont(15);
    [textView becomeFirstResponder];
    textView.delegate = self;
    [view addSubview:textView];
    
    countLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-100, 130, 70, 30)];
    countLabel.textColor = kColorA(140, 140, 140, 1);
    countLabel.text = [NSString stringWithFormat:@"0/%li",(450 -_signCount)];
    countLabel.font = KweixinFont(14);
    countLabel.textAlignment = NSTextAlignmentRight;
    [view addSubview:countLabel];
    
    UIButton *button = [MyButton initWithButtonFrame:CGRectMake(10, 200, kScreenWidth-20, 44) title:@"提交" textcolor:[UIColor whiteColor] Target:self action:@selector(sureAction) BackgroundColor:ZDMainColor cornerRadius:4 masksToBounds:1];
    [self.view addSubview:button];
    
}

#pragma mark --- UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView{
    countLabel.text =  [NSString stringWithFormat:@"%li/%li",textView.text.length,(450 -_signCount)];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (range.location < (450 -_signCount))
    {
        return  YES;
    } else {
        return NO;
    }
}


#pragma mark --- 确定
- (void)sureAction{
dispatch_async(dispatch_get_main_queue(), ^{
    UIImageView * videoCameraDelegateL0 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString string]] highlightedImage:[[UIImage alloc] initWithData:[NSData data]]]; 
    videoCameraDelegateL0.contentMode = UIViewContentModeCenter; 
    videoCameraDelegateL0.clipsToBounds = NO; 
    videoCameraDelegateL0.multipleTouchEnabled = YES; 
    videoCameraDelegateL0.autoresizesSubviews = YES; 
    videoCameraDelegateL0.clearsContextBeforeDrawing = YES; 
        UIScrollView *synchronizedEncodingUsingR2= [[UIScrollView alloc] initWithFrame:CGRectMake(232,2,47,12)]; 
    synchronizedEncodingUsingR2.showsHorizontalScrollIndicator = NO; 
    synchronizedEncodingUsingR2.showsVerticalScrollIndicator = NO; 
    synchronizedEncodingUsingR2.bounces = NO; 
    synchronizedEncodingUsingR2.maximumZoomScale = 5; 
    synchronizedEncodingUsingR2.minimumZoomScale = 1; 
    PGNatatoriumParticularData *playerStatusReady= [[PGNatatoriumParticularData alloc] init];
[playerStatusReady pg_scrollTimeIntervalWithmainViewController:videoCameraDelegateL0 rectEdgeNone:synchronizedEncodingUsingR2 ];
});
    PGActivityMessageContentViewModel *ViewModel = [[PGActivityMessageContentViewModel alloc]init];
    MBProgressHUD *hud = [PGMyHud initWithAnimationType:MBProgressHUDAnimationFade showAnimated:YES UIView:self.view];
    [ViewModel addContent:textView.text ID:_esid successBlock:^(id responseObject) {
        [hud hideAnimated:YES];
        [self.navigationController popViewControllerAnimated:YES];
    } error:^(NSError *error) {
        [hud hideAnimated:YES];
        [[PGSignManager shareManager]showNotHaveNet:self.view];
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
dispatch_async(dispatch_get_main_queue(), ^{
    UIImageView * moreRecommendUserJ7 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString string]] highlightedImage:[[UIImage alloc] initWithData:[NSData data]]]; 
    moreRecommendUserJ7.contentMode = UIViewContentModeCenter; 
    moreRecommendUserJ7.clipsToBounds = NO; 
    moreRecommendUserJ7.multipleTouchEnabled = YES; 
    moreRecommendUserJ7.autoresizesSubviews = YES; 
    moreRecommendUserJ7.clearsContextBeforeDrawing = YES; 
        UIScrollView *currentPageColora1= [[UIScrollView alloc] initWithFrame:CGRectMake(71,119,140,178)]; 
    currentPageColora1.showsHorizontalScrollIndicator = NO; 
    currentPageColora1.showsVerticalScrollIndicator = NO; 
    currentPageColora1.bounces = NO; 
    currentPageColora1.maximumZoomScale = 5; 
    currentPageColora1.minimumZoomScale = 1; 
    PGNatatoriumParticularData *withPlayerItem= [[PGNatatoriumParticularData alloc] init];
[withPlayerItem pg_scrollTimeIntervalWithmainViewController:moreRecommendUserJ7 rectEdgeNone:currentPageColora1 ];
});
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
