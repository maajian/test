#import "PGImageViewFrame.h"
#import "PGMeDetailWithDrawViewController.h"
#import "PGMeMyWalletViewModel.h"
#import "Time.h"
@interface PGMeDetailWithDrawViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *topImageView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *accountLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UIButton *comfirmButton;
@end
@implementation PGMeDetailWithDrawViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self PG_setUI];
}
- (void)PG_setUI{
    self.title = @"提现详情";
    self.comfirmButton.layer.cornerRadius = 5;
    self.comfirmButton.layer.masksToBounds = YES;
    PGMeMyWalletViewModel *viewModel = [[PGMeMyWalletViewModel alloc]init];
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
}
@end
