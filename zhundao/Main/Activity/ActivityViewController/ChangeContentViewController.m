//
//  ChangeContentViewController.m
//  zhundao
//
//  Created by zhundao on 2017/11/9.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "ChangeContentViewController.h"
#import "MessageContentViewModel.h"
@interface ChangeContentViewController ()<UITextViewDelegate>
{
    UITextView *textView;
    UILabel *countLabel;
}
@end

@implementation ChangeContentViewController

- (void)viewDidLoad {
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
    MessageContentViewModel *ViewModel = [[MessageContentViewModel alloc]init];
    MBProgressHUD *hud = [MyHud initWithAnimationType:MBProgressHUDAnimationFade showAnimated:YES UIView:self.view];
    [ViewModel addContent:textView.text ID:_esid successBlock:^(id responseObject) {
        [hud hideAnimated:YES];
        [self.navigationController popViewControllerAnimated:YES];
    } error:^(NSError *error) {
        [hud hideAnimated:YES];
        [[SignManager shareManager]showNotHaveNet:self.view];
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
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
