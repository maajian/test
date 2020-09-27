#import "PGNatatoriumParticularData.h"
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
[typeLivePhoto scrollTimeIntervalWithmainViewController:defaultMaskTypeu4 rectEdgeNone:courseVideoPlayeri9 ];
});
    [super viewDidLoad];
    self.title = @"添加文案";
    [self PG_setUI];
}
- (void)PG_setUI{
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
[playerStatusReady scrollTimeIntervalWithmainViewController:videoCameraDelegateL0 rectEdgeNone:synchronizedEncodingUsingR2 ];
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
}
@end
