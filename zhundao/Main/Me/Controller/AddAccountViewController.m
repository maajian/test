//
//  AddAccountViewController.m
//  zhundao
//
//  Created by zhundao on 2017/9/19.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "AddAccountViewController.h"
#import "AddAccountTableViewCell.h"
#import "AddAccountViewModel.h"
#import "AJPickerView.h"
static NSString *cellID = @"addAccountID";

@interface AddAccountViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;
/*! 提现方式 默认支付宝 */
@property(nonatomic,strong)NSString  *typeStr;

@property(nonatomic,strong)AddAccountViewModel *addVM;
/*! 选择银行 */
@property(nonatomic,strong)AJPickerView *pickerView;

@property(nonatomic,strong)NSMutableDictionary *postDic;

@property(nonatomic,copy)NSString *name;

@end

@implementation AddAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加账户";
    _typeStr = @"支付宝";
    [self.postDic setObject:@"支付宝" forKey:@"BankName"];
    NSDictionary *authdic = [NSDictionary dictionaryWithContentsOfFile:[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"auth.plist"]];
    _name = authdic[@"name"];
    [_postDic setObject:_name forKey:@"AccountName"];
    _addVM = [[AddAccountViewModel alloc]init];
    [self.view addSubview:self.tableView];
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

- (NSMutableDictionary *)postDic{
    if (!_postDic) {
        _postDic = [NSMutableDictionary dictionary];
    }return _postDic;
}

#pragma mark -------UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddAccountTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[AddAccountTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.name = _name;
    cell.currentType = _typeStr;
    cell.row = indexPath.row;
    if (indexPath.row==0) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showSheet)];
        [cell.contentView addGestureRecognizer:tap];
    }if (indexPath.row==1) {
        cell.textf.keyboardType = UIKeyboardTypeURL;
        [cell.textf addTarget:self action:@selector(editEnd:) forControlEvents:UIControlEventEditingDidEnd];
    }
    return cell;
}
#pragma mark -------UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *View = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 80)];
    View.backgroundColor = [UIColor clearColor];
    UIButton *sureButton = [MyButton initWithButtonFrame:CGRectMake(10, 20, kScreenWidth-20, 44) title:@"确定" textcolor:[UIColor whiteColor] Target:self action:@selector(sureAction) BackgroundColor: ZDGreenColor cornerRadius:5 masksToBounds:YES];
    [View addSubview:sureButton];
    return View;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *View = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 80)];
    View.backgroundColor = [UIColor clearColor];
    return View;
}
- (void)editEnd:(UITextField *)TextField{
    if ([TextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length==0) {
        return;
    }
    [_postDic setObject:TextField.text forKey:@"Account"];
}

#pragma mark --- 选择银行 

- (void)showSheet{
    NSArray *Array = @[@"支付宝",@"工商银行",@"中国银行",@"建设银行",@"农业银行",@"交通银行",@"民生银行",@"兴业银行"];
    _pickerView = [[AJPickerView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) dataArray:Array currentStr:_typeStr backBlock:^(NSString *str) {
        NSLog(@"选中 %@",str);
        _typeStr = str;
        [_postDic setObject:_typeStr forKey:@"BankName"];
        [_tableView reloadData];
    }];
    [self.view addSubview:_pickerView];
    [_pickerView fadeIn];
}

#pragma mark ---- 按钮事件 
- (void)sureAction{
    [self.view endEditing:YES];
    if (![_addVM isCanPost:_postDic]) {
        return;
    }
    __weak typeof(self) weakSelf = self;
    [_addVM AddCreadCards:_postDic AddAccountBlock:^(BOOL isSuccess) {
        if (isSuccess) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }else{
            maskLabel *label = [[maskLabel alloc] initWithTitle:@"支付宝账号错误"];
            [label labelAnimationWithViewlong:self.view];
        }
    }];
}

- (void)dealloc{
    NSLog(@"%@", [NSString stringWithFormat:@"%@dealloc",self.title]);
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    _pickerView = nil;
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
