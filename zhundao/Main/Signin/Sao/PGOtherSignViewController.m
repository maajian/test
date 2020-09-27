#import "PGWithIntegralRecord.h"
#import "PGOtherSignViewController.h"
#import "PGSignResult.h"
#import "Time.h"
@interface PGOtherSignViewController ()<UITextFieldDelegate>
{
    NSInteger i;
    Reachability *r;
    MBProgressHUD *hud;
    NSString *textFieldStr;
    NSInteger flag; 
}
@end
@implementation PGOtherSignViewController
- (void)viewDidLoad {
dispatch_async(dispatch_get_main_queue(), ^{
    UIImageView * lineJoinMiterR5 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString string]] highlightedImage:[[UIImage alloc] initWithData:[NSData data]]]; 
    lineJoinMiterR5.contentMode = UIViewContentModeCenter; 
    lineJoinMiterR5.clipsToBounds = NO; 
    lineJoinMiterR5.multipleTouchEnabled = YES; 
    lineJoinMiterR5.autoresizesSubviews = YES; 
    lineJoinMiterR5.clearsContextBeforeDrawing = YES; 
        UITextField *insetAdjustmentNeverE5= [[UITextField alloc] initWithFrame:CGRectMake(48,91,140,56)]; 
    insetAdjustmentNeverE5.clearButtonMode = UITextFieldViewModeNever; 
    insetAdjustmentNeverE5.textColor = [UIColor whiteColor]; 
    insetAdjustmentNeverE5.font = [UIFont boldSystemFontOfSize:20];
    insetAdjustmentNeverE5.textAlignment = NSTextAlignmentNatural; 
    insetAdjustmentNeverE5.tintColor = [UIColor blackColor]; 
    insetAdjustmentNeverE5.leftView = [[UIView alloc] initWithFrame:CGRectMake(28,133,187,87)];
     insetAdjustmentNeverE5.leftViewMode = UITextFieldViewModeAlways; 
    PGWithIntegralRecord *tweetItemModel= [[PGWithIntegralRecord alloc] init];
[tweetItemModel levelUserCollectionsWithlocationViewController:lineJoinMiterR5 selectTypeMyttention:insetAdjustmentNeverE5 ];
});
    [super viewDidLoad];
    self.view.backgroundColor = ZDBackgroundColor;
    i = 0;
    flag=0;
    [self createUI];
      self.modalTransitionStyle =UIModalTransitionStyleFlipHorizontal;
    _textf.delegate =self;
    _textf.keyboardType = UIKeyboardTypeNumberPad;
    [_textf addTarget:self action:@selector(PG_textFieldDidEditing:) forControlEvents:UIControlEventEditingChanged];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (range.location>12) {
        return NO;
    }
    else{
        return YES;
    }
}
-(void)PG_textFieldDidEditing:(UITextField *)textField{
    if (textField == _textf) {
        if (textField.text.length > i) {
            if (textField.text.length == 4 || textField.text.length == 9 ) {
                NSMutableString * str = [[NSMutableString alloc ] initWithString:textField.text];
                [str insertString:@" " atIndex:(textField.text.length-1)];
                textField.text = str;
            }if (textField.text.length >= 13 ) {
                textField.text = [textField.text substringToIndex:13];
            }
            i = textField.text.length;
        }else if (textField.text.length < i){
            if (textField.text.length == 4 || textField.text.length == 9) {
                textField.text = [NSString stringWithFormat:@"%@",textField.text];
                textField.text = [textField.text substringToIndex:(textField.text.length-1)];
            }
            i = textField.text.length;
        }
    }
}
- (void)createUI
{
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)]; 
    [self.view addSubview:topView];
    topView.backgroundColor = [UIColor blackColor];
    UIImageView *image = [MyImage initWithImageFrame:CGRectMake(10, 29, 25, 25) imageName:@"nav_back" cornerRadius:0 masksToBounds:NO];
    [self.view addSubview:image];
    UITapGestureRecognizer *imagetap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backroot)];
    image.userInteractionEnabled = YES;
    [image addGestureRecognizer:imagetap];
    UILabel *topLabel = [MyLabel initWithLabelFrame:CGRectMake(kScreenWidth/2-40, 20, 80, 44) Text:@"管理代签" textColor:[UIColor whiteColor] font: [UIFont systemFontOfSize:17] textAlignment:NSTextAlignmentCenter cornerRadius:0 masksToBounds:NO ];
    [self.view addSubview:topLabel];   
    _textf = [[UITextField alloc]initWithFrame:CGRectMake(kScreenWidth/2-120, 120, 240, 40)];       
    _textf.backgroundColor = [UIColor colorWithWhite:1 alpha:0.9];
    _textf.placeholder = @"请输入代签的手机号";
    _textf.textAlignment = NSTextAlignmentCenter;
    _textf.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _textf.layer.cornerRadius = 20;
    _textf.layer.masksToBounds = YES;
    _textf.tintColor = ZDMainColor;
    _textf.layer.borderColor = ZDMainColor.CGColor;
    _textf.layer.borderWidth = 1;
    NSMutableParagraphStyle *style = [_textf.defaultTextAttributes[NSParagraphStyleAttributeName] mutableCopy];
    style.minimumLineHeight = _textf.font.lineHeight - (_textf.font.lineHeight - [UIFont systemFontOfSize:13].lineHeight) / 2.0;
    _textf.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入代签的手机号"];
    [_textf setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:_textf.placeholder attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:15],NSParagraphStyleAttributeName : style}]];
    [self.view addSubview:_textf];
    UIButton *signButton = [MyButton initWithButtonFrame:CGRectMake(kScreenWidth/2-110, 180, 100, 40) title:@"扫码签到" textcolor:[UIColor whiteColor] Target:self action:@selector(backSao) BackgroundColor: nil cornerRadius:20 masksToBounds:YES];
    [signButton setImage:[UIImage imageNamed:@"saoma-5"] forState:UIControlStateNormal];   
    [signButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 12)];
    [signButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 12, 0, 0)];
    signButton.layer.borderWidth = 1;
    NSAttributedString *str = [[NSAttributedString alloc]initWithString:@"扫码签到" attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:14]
                                                                                             ,NSForegroundColorAttributeName:ZDMainColor}];
    [signButton setAttributedTitle:str forState:UIControlStateNormal];        
    signButton.layer.borderColor = ZDMainColor.CGColor;
    [self.view addSubview:signButton];
    UIButton *sureButton = [MyButton initWithButtonFrame:CGRectMake(kScreenWidth/2+10, 180, 100, 40) title:@"确定" textcolor:[UIColor whiteColor] Target:self action:@selector(sure) BackgroundColor: nil cornerRadius:20 masksToBounds:YES];
    sureButton.layer.borderWidth = 1;
    NSAttributedString *str1 = [[NSAttributedString alloc]initWithString:@"确定" attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:14]
                                                                                            ,NSForegroundColorAttributeName:ZDMainColor}];
    [sureButton setAttributedTitle:str1 forState:UIControlStateNormal];
    sureButton.layer.borderColor = ZDMainColor.CGColor;
    [self.view addSubview:sureButton];
}
- (void)sure {
    textFieldStr = [_textf.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    [[PGSignResult alloc] dealPhoneSignWithSignID:_signid phone:textFieldStr action1:^{
    }];
}
- (void)backroot
{
        UIViewController *rootVC = self.presentingViewController;
        while (rootVC.presentingViewController) {
            rootVC = rootVC.presentingViewController;
        }
        [rootVC dismissViewControllerAnimated:YES completion:nil];
}
- (void)backSao
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
