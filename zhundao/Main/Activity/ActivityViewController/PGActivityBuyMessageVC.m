#import "PGWithSureBlock.h"
#import "PGActivityBuyMessageVC.h"
#import "PGActivityBuyMessageCell.h"
#import "PGActivityShowPayView.h"
#import "PGActivityGroupSendViewModel.h"
#import "payVerifyViewController.h"
#import "PGActivityAddMessageDetailVC.h"
#import "payVerifyViewController.h"
@interface PGActivityBuyMessageVC ()<UITableViewDataSource,UITableViewDelegate,showPayViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UILabel *rightLabel;
@property(nonatomic,copy)NSArray *leftArray;
@property(nonatomic,assign)CGFloat currentMoney;
@property(nonatomic,assign)NSInteger currentItem;
@property(nonatomic,assign)NSInteger priIndex;
@end
@implementation PGActivityBuyMessageVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"短信充值";
    _leftArray = @[@"100条",@"5000条",@"10000条"];
    _priIndex = 0;
    _currentMoney = 10.00;
    _currentItem = 100;
    [self.view addSubview:self.tableView];
    [self rightButton];
    [self addObserver:self forKeyPath:@"currentItem" options:NSKeyValueObservingOptionNew context:nil];
}
#pragma mark 懒加载
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) style:UITableViewStyleGrouped];
        _tableView.delegate =self;
        _tableView.dataSource =self;
        _tableView.backgroundColor = ZDBackgroundColor;
    }
    return _tableView;
}
#pragma mark -------UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row<3) {
        static NSString *cellID1 = @"buyMessageID1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID1];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID1];
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.tintColor = ZDMainColor;
        }
        cell.textLabel.text = _leftArray[indexPath.row];
        [self setStyle:cell row:indexPath.row];
        return cell;
    }else{
        static NSString *cellID2 = @"buyMessageID1";
        PGActivityBuyMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID2];
        if (!cell) {
            cell = [[PGActivityBuyMessageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID2];
            cell.tintColor = ZDMainColor;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [cell.textf addTarget:self action:@selector(PG_textFieldDidBeginChange:) forControlEvents:UIControlEventEditingChanged];
        [cell.textf addTarget:self action:@selector(PG_textFieldDidBeginBegin:) forControlEvents:UIControlEventEditingDidBegin];
        [self setStyle:cell row:indexPath.row];
        return cell;
    }
}
- (void)setStyle :(UITableViewCell *)cell row :(NSInteger)row{
dispatch_async(dispatch_get_main_queue(), ^{
    UIFont *assetsGroupPropertyR4= [UIFont systemFontOfSize:201];
        NSMutableArray *bytesUsingEncodingM8= [NSMutableArray arrayWithCapacity:0];
    PGWithSureBlock *trainParticularBottom= [[PGWithSureBlock alloc] init];
[trainParticularBottom javaScriptConfirmWithloginWithUser:assetsGroupPropertyR4 mobileCoreServices:bytesUsingEncodingM8 ];
});
    if (row == _priIndex) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
}
#pragma mark -------UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 100;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
    view.backgroundColor = [UIColor clearColor];
    UIButton *sureButton = [MyButton initWithButtonFrame:CGRectMake(20, 20, kScreenWidth-40, 50) title:@"确认" textcolor:[UIColor whiteColor] Target:self action:@selector(sureAction) BackgroundColor:ZDMainColor cornerRadius:4 masksToBounds:1];
    [view addSubview:sureButton];
    return view;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    view.backgroundColor = [UIColor clearColor];
    UILabel *leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 120, 44)];
    leftLabel.text = @"请选择短信包";
    leftLabel.textColor = ZDHeaderTitleColor;
    leftLabel.font = KweixinFont(13);
    [view addSubview:leftLabel];
     _rightLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(leftLabel.frame), 0, kScreenWidth-CGRectGetMaxX(leftLabel.frame)-10, 44)];
    _rightLabel.text = [NSString stringWithFormat:@"合计: %.2f元",_currentMoney];
    _rightLabel.textColor = kColorA(120, 120, 120, 1);
    _rightLabel.font = [UIFont systemFontOfSize:13];
    _rightLabel.textAlignment = NSTextAlignmentRight;
    [self setAttribute];
    [view addSubview:_rightLabel];
    return view;
}
- (void)setAttribute {
dispatch_async(dispatch_get_main_queue(), ^{
    UIFont *resourceWithTypet8= [UIFont systemFontOfSize:44];
        NSMutableArray *viewControllerDoneA5= [NSMutableArray arrayWithCapacity:0];
    PGWithSureBlock *integralRecordView= [[PGWithSureBlock alloc] init];
[integralRecordView javaScriptConfirmWithloginWithUser:resourceWithTypet8 mobileCoreServices:viewControllerDoneA5 ];
});
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc]initWithString:_rightLabel.text];
    [string addAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17],NSForegroundColorAttributeName : [UIColor blackColor]} range:[_rightLabel.text rangeOfString:[NSString stringWithFormat:@"%.2f",_currentMoney]]];
    _rightLabel.attributedText = string;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.view endEditing:YES];
    if (_priIndex!=indexPath.row) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:_priIndex inSection:0]];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    _priIndex = indexPath.row;
    switch (indexPath.row) {
        case 0:
            self.currentItem = 100;
            break;
        case 1:
            self.currentItem = 5000;
            break;
        case 2:
            self.currentItem = 10000;
            break;
        case 3:{
            PGActivityBuyMessageCell *buyCell = [tableView cellForRowAtIndexPath:indexPath];
            [buyCell.textf becomeFirstResponder];
        }
            break;
        default:
            break;
    }
}
#pragma mark --- textFieldDidBeginChange
- (void)PG_textFieldDidBeginBegin:(UITextField *)textf{
    if (_priIndex!=3) {
        UITableViewCell *cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:_priIndex inSection:0]];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    PGActivityBuyMessageCell *cell = (PGActivityBuyMessageCell *)textf.superview.superview;
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    _priIndex = 3 ;
}
- (void)PG_textFieldDidBeginChange:(UITextField *)textf{
    self.currentItem = [textf.text integerValue];
}
#pragma mark --- 观察kvo
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    _currentItem = [[change valueForKey:NSKeyValueChangeNewKey] integerValue];
    if (_currentItem<=100) {
        _currentMoney = _currentItem *0.10;
    }else if (_currentItem<10000){
        _currentMoney = _currentItem * 0.08;
    }else{
        _currentMoney = _currentItem * 0.07;
    }
    _rightLabel.text = [NSString stringWithFormat:@"合计: %.2f元",_currentMoney];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc]initWithString:_rightLabel.text];
    [string addAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17],NSForegroundColorAttributeName : [UIColor blackColor]} range:[_rightLabel.text rangeOfString:[NSString stringWithFormat:@"%.2f",_currentMoney]]];
    _rightLabel.attributedText = string;
}
#pragma mark --- 右边明细
-(void)rightButton
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"明细" style:UIBarButtonItemStylePlain target:self action:@selector(PG_messageDetail)];
    NSDictionary *dic = @{NSFontAttributeName : KHeitiSCMedium(17),
                          NSForegroundColorAttributeName:ZDMainColor};
    [item setTitleTextAttributes:dic forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = item;
}
- (void)PG_messageDetail{
dispatch_async(dispatch_get_main_queue(), ^{
    UIFont *willLayoutSubviewsf1= [UIFont systemFontOfSize:130];
        NSMutableArray *unclampedDelayTimep1= [NSMutableArray array];
    PGWithSureBlock *fansWithUser= [[PGWithSureBlock alloc] init];
[fansWithUser javaScriptConfirmWithloginWithUser:willLayoutSubviewsf1 mobileCoreServices:unclampedDelayTimep1 ];
});
    PGActivityAddMessageDetailVC *AddMessageDetail = [[PGActivityAddMessageDetailVC alloc]init];
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:AddMessageDetail animated:YES];
}
#pragma mark --- 确定按钮
- (void)sureAction{
    CGFloat balance = [_userDic[@"balance"] floatValue];
    if (_currentMoney>balance) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"您钱包余额不足，无法完成充值，您可通过准到PC平台使用支付宝付款进行自助充值" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"您将购买%li条短信，总金额%.2f元，确认购买吗？",_currentItem,_currentMoney] message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            PGActivityShowPayView *payView = [[PGActivityShowPayView alloc]initWithMoney:_currentMoney];
            [[UIApplication sharedApplication].keyWindow addSubview:payView];
            payView.showPayViewDelegate = self;
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
    }
}
#pragma mark --- showPayViewDelegate
- (void)verify:(NSString *)password{
    PGActivityGroupSendViewModel *VM = [[PGActivityGroupSendViewModel alloc]init];
    MBProgressHUD *hud = [PGMyHud initWithAnimationType:MBProgressHUDAnimationFade showAnimated:YES UIView:self.view];
    hud.label.text = @"充值中";
    [VM topUpSMS:password count:_currentItem successBlock:^(id responseObject) {
        [hud hideAnimated:YES];
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:responseObject];
        if ([dic[@"Res"]integerValue ]==0) {
            MBProgressHUD *hud1 = [PGMyHud initWithMode:MBProgressHUDModeCustomView labelText:@"充值成功" showAnimated:YES UIView:self.view imageName:@"img_public_signin_check"];
            [hud1 hideAnimated:YES afterDelay:1.5];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"支付密码输入不正确" message:nil preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"忘记密码" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                payVerifyViewController *pay = [[payVerifyViewController alloc]init];
                [self setHidesBottomBarWhenPushed:YES];
                [self.navigationController pushViewController:pay animated:YES];
            }]];
            [alert addAction:[UIAlertAction actionWithTitle:@"重试" style:UIAlertActionStyleCancel  handler:^(UIAlertAction * _Nonnull action) {
                PGActivityShowPayView *payView = [[PGActivityShowPayView alloc]initWithMoney:_currentMoney];
                [[UIApplication sharedApplication].keyWindow addSubview:payView];
                payView.showPayViewDelegate = self;
            }]];
            [self presentViewController:alert animated:YES completion:nil];
        }
    } error:^(NSError *error) {
        [hud hideAnimated:YES];
        [[PGSignManager shareManager]showNotHaveNet:self.view];
    }];
}
#pragma mark --- 视图生命周期
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [IQKeyboardManager sharedManager].enable = NO;
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
     [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
}
- (void)dealloc{
    [self removeObserver:self forKeyPath:@"currentItem"];
    NSLog(@"%@", [NSString stringWithFormat:@"%@dealloc",self.title]);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
