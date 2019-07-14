//
//  IsOnGowithViewController.m
//  
//
//  Created by zhundao on 2017/9/18.
//
//

#import "IsOnGowithViewController.h"
#import "AllAccountViewController.h"
#import "UITextField+textCenter.h"
#import "IsOnGowithViewModel.h"
static NSString *CellID = @"isOnGowith";
@interface IsOnGowithViewController ()<UITableViewDelegate,UITableViewDataSource,AllAccountDelegate>{
    UILabel *amountLabel;
    UITextField *textf;
    UIImageView *imageView;
}
@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)IsOnGowithViewModel *viewModel;
/*! 账户ID */
@property(nonatomic,assign)NSInteger ID;
/*! 银行类别 */
@property(nonatomic,strong)NSString *bankName;

@end

@implementation IsOnGowithViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"提现";
    _viewModel = [[IsOnGowithViewModel alloc]init];
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view from its nib.
}
#pragma mark 懒加载

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64)];
        _tableView.delegate =self;
        _tableView.dataSource =self;
        _tableView.backgroundColor = zhundaoBackgroundColor;
    }
    return _tableView;
}

#pragma mark -------UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:CellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    while (cell.contentView.subviews.lastObject!=nil) {
        [cell.contentView.subviews.lastObject removeFromSuperview];
    }
    if (indexPath.row==0) {
        amountLabel = [MyLabel initWithLabelFrame:CGRectMake(50, 0, kScreenWidth-50, 44) Text:@"请选择提现账号" textColor:KplaceHolderColor font:[UIFont systemFontOfSize:17] textAlignment:NSTextAlignmentLeft cornerRadius:0 masksToBounds:0];
        imageView = [MyImage initWithImageFrame:CGRectMake(12, 12, 20, 20) imageName:@"钱包" cornerRadius:0 masksToBounds:0];
        [cell.contentView addSubview:imageView];
        [cell.contentView addSubview:amountLabel];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if ([[NSUserDefaults standardUserDefaults]objectForKey:@"account1"]) {
            NSDictionary *dic = [[NSUserDefaults standardUserDefaults]objectForKey:@"account1"];
            [self addAccount:dic[@"account"] BankName:@"bankName"];
            _ID = [dic[@"accountId"] integerValue];
            _bankName = dic[@"bankName"];
        }
    }else if (indexPath.row==1){
        UILabel *leftLabel = [MyLabel initWithLabelFrame:CGRectMake(10, 0, 70, 44) Text:@"提现金额" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:17] textAlignment:NSTextAlignmentLeft cornerRadius:0 masksToBounds:0];
        [cell.contentView addSubview:leftLabel];
        textf = [myTextField initWithFrame:CGRectMake(85, 0, kScreenWidth-90, 44) placeholder:@"请输入提现金额" font:[UIFont systemFontOfSize:17] TextAlignment:NSTextAlignmentLeft textColor:[UIColor blackColor]];
        textf.keyboardType = UIKeyboardTypeDecimalPad;
        [textf initWithString:@"请输入提现金额" font:[UIFont systemFontOfSize:17]];
        [cell.contentView addSubview:textf];
    }else{
        UIView *View = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 128)];
        View.backgroundColor = zhundaoBackgroundColor;
        UILabel *leftLabel =[MyLabel initWithLabelFrame:CGRectMake(10, 0, 1000, 44) Text:[NSString stringWithFormat:@"余额 ¥%@",_allMoney] textColor:kheaderTitleColor font:[UIFont systemFontOfSize:12] textAlignment:NSTextAlignmentLeft cornerRadius:0 masksToBounds:0];
        [leftLabel sizeToFit];
        leftLabel.frame = CGRectMake(10, 0, leftLabel.frame.size.width, 44);
        UIButton *rightButton = [MyButton initWithButtonFrame:CGRectMake(CGRectGetMaxX(leftLabel.frame)+5, 0, 60, 44) title:@"全部提现" textcolor:kColorA(27, 164, 247, 1) Target:self action:@selector(GowithAll) BackgroundColor:nil cornerRadius:0 masksToBounds:0];
        rightButton.titleLabel.font = [UIFont systemFontOfSize:12];
        UIButton *withdrawButton = [MyButton initWithButtonFrame:CGRectMake(10, 44, kScreenWidth-20, 44) title:@"确认" textcolor:[UIColor whiteColor] Target:self action:@selector(withdraw:) BackgroundColor: zhundaoGreenColor cornerRadius:5 masksToBounds:YES];
        UILabel *alertLabel =[MyLabel initWithLabelFrame:CGRectMake(10, 88, kScreenWidth-20, 44) Text:[NSString stringWithFormat:@"提现金额不得低于50元，提现手续费为%.1f%%",_factorageRate * 100] textColor:kheaderTitleColor font:[UIFont systemFontOfSize:12] textAlignment:NSTextAlignmentCenter cornerRadius:0 masksToBounds:0];
        [View addSubview:leftLabel];
        [View addSubview:rightButton];
        [View addSubview:withdrawButton];
        [View addSubview:alertLabel];
        [cell.contentView addSubview:View];
    }
    return cell;
    
}
#pragma mark -------UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *View = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
    View.backgroundColor = [UIColor clearColor];
    return View;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath.row==2?128:44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        AllAccountViewController *all = [[AllAccountViewController alloc]init];
        [self setHidesBottomBarWhenPushed:YES];
        all.AllAccountDelegate = self;
        [self.navigationController pushViewController:all animated:YES];
    }
}
#pragma mark ---AllAccountDelegate 

- (void)post:(NSString *)account BankName:(NSString *)BankName ID:(NSInteger)ID {
    [self addAccount:account BankName:BankName];
    _ID = ID;
    _bankName = BankName;
}

- (void)addAccount:(NSString *)account BankName:(NSString *)BankName{
    amountLabel.text = account;
    amountLabel.textColor = [UIColor blackColor];
    if ([BankName isEqualToString:@"支付宝"]) {
        imageView.image = [UIImage imageNamed:@"支付宝"];
    } else if([BankName isEqualToString:@"微信钱包"]) {
        imageView.image = [UIImage imageNamed:@"wechatWithDraw"];
    } else{
        imageView.image = [UIImage imageNamed:@"银行卡"];
    }
}

#pragma mark ---全部提现

- (void)GowithAll{
    textf.text = _allMoney ;
}

#pragma mark --- 提交

- (void)withdraw:(NSString *)account{
    [self.view endEditing:YES];
    if (textf.text.length==0) {
        [self showMask:@"金额不能为空"];
    }
//    else if([textf.text floatValue]<50.0){
//        [self showMask:@"提现金额低于50"];
//    }
//    else if ([textf.text floatValue]>[_allMoney floatValue]) {
//        [self showMask:@"提现金额超过余额"];
//    }
//    else if ([_bankName isEqualToString:@"支付宝"] &&[textf.text floatValue]>10000){
//        [self showMask:@"支付宝提现最高支持10000元"];
//    }else if (!_ID){
//        [self showMask:@"请选择提现账号"];
//    }
    else{
        MBProgressHUD *hud = [MyHud initWithAnimationType:MBProgressHUDAnimationFade showAnimated:YES UIView:self.view];
        [_viewModel Withdraw:textf.text accountId:_ID isonGowithBlock:^(NSString *success) {
            [hud hideAnimated:YES];
            if ([success isEqualToString:@"提现成功"]) {
                MBProgressHUD *hud = [MyHud initWithMode:MBProgressHUDModeText labelText:@"申请提现成功" showAnimated:YES UIView:self.view imageName:nil];
                [hud hideAnimated:YES afterDelay:1.5];
                NSDictionary *mudic = [NSDictionary dictionaryWithObjectsAndKeys:amountLabel.text,@"account",@(_ID),@"accountId",_bankName,@"bankName",nil];
                [[NSUserDefaults standardUserDefaults]setObject:mudic forKey:@"account1"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:YES];
                });

            } else {
                [self showMask:success];
            }
        }];
    }
}
- (void)showMask:(NSString *)str{
    maskLabel *label = [[maskLabel alloc]initWithTitle:str];
    [label labelAnimationWithViewlong:self.view];
}



- (void)dealloc{
    NSLog(@"%@", [NSString stringWithFormat:@"%@dealloc",self.title]);
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
