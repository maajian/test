//
//  AllAccountViewController.m
//  zhundao
//
//  Created by zhundao on 2017/9/18.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "AllAccountViewController.h"
#import "AllAccountViewModel.h"
#import "AllAccountTableViewCell.h"
#import "AllAccountModel.h"
#import "AuthViewController.h"
#import "AddAccountViewController.h"
static NSString *cellID = @"AllAccountID";
@interface AllAccountViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,copy)NSArray *dataArray;

@property(nonatomic,strong)AllAccountViewModel *allViewModel;

@end

@implementation AllAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"提现账号";
    _allViewModel = [[AllAccountViewModel alloc]init];
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view.
}

#pragma mark 懒加载

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64)];
        _tableView.delegate =self;
        _tableView.dataSource =self;
        _tableView.backgroundColor = ZDBackgroundColor;
    }
    return _tableView;
}

#pragma mark --- 网络请求

- (void)networkGetAccount{
    [_allViewModel GetCreditCards:^(BOOL isSuccess, NSArray *Array) {
        if (isSuccess) {
            NSMutableArray *muarray = [NSMutableArray array];
            for (NSDictionary *dic in Array) {
                AllAccountModel *model = [AllAccountModel yy_modelWithJSON:dic];
                [muarray addObject:model];
            }
            
            AllAccountModel *wechatModel = [[AllAccountModel alloc] initWithAccount:@"微信钱包" bankName:@"微信钱包" iD:0];
            [muarray addObject:wechatModel];
            
            _dataArray = muarray;
            [_tableView reloadData];
        }else{
            [[SignManager shareManager]showNotHaveNet:self.view];
        }
    }];
}

#pragma mark -------UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AllAccountTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[AllAccountTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.model = _dataArray[indexPath.row];
    return cell;
    
}
#pragma mark -------UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 64;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *View = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    View.backgroundColor = ZDBackgroundColor;
    UIButton *addAccountButton = [MyButton initWithButtonFrame:CGRectMake(10, 20, kScreenWidth-20, 44) title:@"添加提现账户" textcolor:[UIColor whiteColor] Target:self action:@selector(addAccount) BackgroundColor: ZDGreenColor cornerRadius:5 masksToBounds:YES];
    [View addSubview:addAccountButton];
    return  View;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *View = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
    View.backgroundColor = [UIColor clearColor];
    return View;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AllAccountModel *model =_dataArray[indexPath.row];
    [_AllAccountDelegate post:model.Account BankName:model.BankName ID:model.ID];
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    AllAccountModel *model = _dataArray[indexPath.row];
    __weak typeof(self) weakSelf = self;
    [_allViewModel deleteCreadCard:model.ID successBlock:^(id responseObject) {
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:responseObject];
        if ([dic[@"Res"] integerValue]==0) {
           [weakSelf networkGetAccount];
        }
    }];
}


#pragma mark ---  添加账号

- (void)addAccount{
    /*! 如果未认证 前往认证*/
    
    if (![[NSUserDefaults standardUserDefaults]boolForKey:@"Authentication"]) {
        ZD_WeakSelf
        [ZDAlertView alertWithTitle:@"操作提醒" message:@"请先完成实名认证再添加提现账号" sureBlock:^{
            AuthViewController *auth  = [[AuthViewController alloc]init];
            [weakSelf setHidesBottomBarWhenPushed:YES];
            [weakSelf.navigationController pushViewController:auth animated:YES];
        } cancelBlock:^{
            
        }];
    }else{
        NSDictionary *authdic = [NSDictionary dictionaryWithContentsOfFile:[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"auth.plist"]];
        if ([authdic[@"status"] integerValue]!=1) {
            AuthViewController *auth  = [[AuthViewController alloc]init];
            [self setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:auth animated:YES];
            auth.authdic = authdic;
        }else{
            AddAccountViewController *add = [[AddAccountViewController alloc]init];
            [self setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:add animated:YES];
        }
        
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self networkGetAccount];
}

- (void)dealloc{
    DDLogVerbose(@"%@", [NSString stringWithFormat:@"%@dealloc",self.title]);
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
