//
//  ZDMeDetailWithDrawViewController.m
//  zhundao
//
//  Created by zhundao on 2017/9/13.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "ZDMeDetailWithDrawViewController.h"
#import "ZDMeMyWalletViewModel.h"
#import "Time.h"
@interface ZDMeDetailWithDrawViewController ()
/*! 顶部图片 */
@property (weak, nonatomic) IBOutlet UIImageView *topImageView;
/*! 到账时间 */
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
/*! 账户标签 */
@property (weak, nonatomic) IBOutlet UILabel *accountLabel;
/*! 提现金额 */
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
/*! 确定按钮 */
@property (weak, nonatomic) IBOutlet UIButton *comfirmButton;
/*!  */
@end

@implementation ZDMeDetailWithDrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    
}

- (void)setUI{
    self.title = @"提现详情";
    self.comfirmButton.layer.cornerRadius = 5;
    self.comfirmButton.layer.masksToBounds = YES;
    ZDMeMyWalletViewModel *viewModel = [[ZDMeMyWalletViewModel alloc]init];
    NSDictionary *dic = [viewModel readWithdraw];
    _timeLabel.text = [NSString stringWithFormat:@"%@(最晚24:00)",[[Time alloc]getReciverStr:dic[@"AddTime"]]];
    _accountLabel.text =[NSString stringWithFormat:@"%@ %@",dic[@"BankName"],dic[@"Account"]];
    _moneyLabel.text = [NSString stringWithFormat:@"¥%.2f",[dic[@"Amount"] floatValue]];
}



- (IBAction)comfirmAction:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
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
