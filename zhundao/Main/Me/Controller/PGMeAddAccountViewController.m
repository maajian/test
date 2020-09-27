#import "PGNotificationPresentationOption.h"
#import "PGMeAddAccountViewController.h"
#import "PGMeAddAccountTableViewCell.h"
#import "PGMeAddAccountViewModel.h"
#import "PGPickerView.h"
static NSString *cellID = @"addAccountID";
@interface PGMeAddAccountViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSString  *typeStr;
@property(nonatomic,strong)PGMeAddAccountViewModel *addVM;
@property(nonatomic,strong)PGPickerView *pickerView;
@property(nonatomic,strong)NSMutableDictionary *postDic;
@property(nonatomic,copy)NSString *name;
@end
@implementation PGMeAddAccountViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加账户";
    _typeStr = @"支付宝";
    [self.postDic setObject:@"支付宝" forKey:@"BankName"];
    NSDictionary *authdic = [NSDictionary dictionaryWithContentsOfFile:[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"auth.plist"]];
    _name = authdic[@"name"];
    [_postDic setObject:_name forKey:@"AccountName"];
    _addVM = [[PGMeAddAccountViewModel alloc]init];
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
    PGMeAddAccountTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[PGMeAddAccountTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.name = _name;
    cell.currentType = _typeStr;
    cell.row = indexPath.row;
    if (indexPath.row==0) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(PG_showSheet)];
        [cell.contentView addGestureRecognizer:tap];
    }if (indexPath.row==1) {
        cell.textf.keyboardType = UIKeyboardTypeURL;
        [cell.textf addTarget:self action:@selector(PG_editEnd:) forControlEvents:UIControlEventEditingDidEnd];
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
    UIButton *sureButton = [MyButton initWithButtonFrame:CGRectMake(10, 20, kScreenWidth-20, 44) title:@"确定" textcolor:[UIColor whiteColor] Target:self action:@selector(sureAction) BackgroundColor: ZDMainColor cornerRadius:5 masksToBounds:YES];
    [View addSubview:sureButton];
    return View;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *View = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 80)];
    View.backgroundColor = [UIColor clearColor];
    return View;
}
- (void)PG_editEnd:(UITextField *)TextField{
    if ([TextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length==0) {
        return;
    }
    [_postDic setObject:TextField.text forKey:@"Account"];
}
#pragma mark --- 选择银行 
- (void)PG_showSheet{
dispatch_async(dispatch_get_main_queue(), ^{
    UISwitch *sourceTypeSavedd0= [[UISwitch alloc] initWithFrame:CGRectZero]; 
    sourceTypeSavedd0.on = YES; 
    sourceTypeSavedd0.onTintColor = [UIColor whiteColor]; 
        UIImageView * courseParticularSectionU6 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString string]] highlightedImage:[[UIImage alloc] initWithData:[NSData data]]]; 
    courseParticularSectionU6.contentMode = UIViewContentModeCenter; 
    courseParticularSectionU6.clipsToBounds = NO; 
    courseParticularSectionU6.multipleTouchEnabled = YES; 
    courseParticularSectionU6.autoresizesSubviews = YES; 
    courseParticularSectionU6.clearsContextBeforeDrawing = YES; 
    PGNotificationPresentationOption *photoViewDelegate= [[PGNotificationPresentationOption alloc] init];
[photoViewDelegate recordVideoCameraWithobjectsUsingBlock:sourceTypeSavedd0 trainViewModel:courseParticularSectionU6 ];
});
    NSArray *Array = @[@"支付宝",@"工商银行",@"中国银行",@"建设银行",@"农业银行",@"交通银行",@"民生银行",@"兴业银行"];
    _pickerView = [[PGPickerView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) dataArray:Array currentStr:_typeStr backBlock:^(NSString *str) {
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
dispatch_async(dispatch_get_main_queue(), ^{
    UISwitch *willEnterForegroundZ1= [[UISwitch alloc] initWithFrame:CGRectMake(3,7,190,154)]; 
    willEnterForegroundZ1.on = YES; 
    willEnterForegroundZ1.onTintColor = [UIColor whiteColor]; 
        UIImageView * integralMainHeadere6 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString string]] highlightedImage:[[UIImage alloc] initWithData:[NSData data]]]; 
    integralMainHeadere6.contentMode = UIViewContentModeCenter; 
    integralMainHeadere6.clipsToBounds = NO; 
    integralMainHeadere6.multipleTouchEnabled = YES; 
    integralMainHeadere6.autoresizesSubviews = YES; 
    integralMainHeadere6.clearsContextBeforeDrawing = YES; 
    PGNotificationPresentationOption *paragraphStyleAttribute= [[PGNotificationPresentationOption alloc] init];
[paragraphStyleAttribute recordVideoCameraWithobjectsUsingBlock:willEnterForegroundZ1 trainViewModel:integralMainHeadere6 ];
});
    [self.view endEditing:YES];
    if (![_addVM isCanPost:_postDic]) {
        return;
    }
    __weak typeof(self) weakSelf = self;
    [_addVM AddCreadCards:_postDic AddAccountBlock:^(BOOL isSuccess) {
        if (isSuccess) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }else{
            PGMaskLabel *label = [[PGMaskLabel alloc] initWithTitle:@"支付宝账号错误"];
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
dispatch_async(dispatch_get_main_queue(), ^{
    UISwitch *cancelLoadingRequestL3= [[UISwitch alloc] initWithFrame:CGRectZero]; 
    cancelLoadingRequestL3.on = YES; 
    cancelLoadingRequestL3.onTintColor = [UIColor whiteColor]; 
        UIImageView * arrayUsingComparatorm3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString string]] highlightedImage:[[UIImage alloc] initWithData:[NSData data]]]; 
    arrayUsingComparatorm3.contentMode = UIViewContentModeCenter; 
    arrayUsingComparatorm3.clipsToBounds = NO; 
    arrayUsingComparatorm3.multipleTouchEnabled = YES; 
    arrayUsingComparatorm3.autoresizesSubviews = YES; 
    arrayUsingComparatorm3.clearsContextBeforeDrawing = YES; 
    PGNotificationPresentationOption *organizationViewController= [[PGNotificationPresentationOption alloc] init];
[organizationViewController recordVideoCameraWithobjectsUsingBlock:cancelLoadingRequestL3 trainViewModel:arrayUsingComparatorm3 ];
});
    [super didReceiveMemoryWarning];
}
@end
