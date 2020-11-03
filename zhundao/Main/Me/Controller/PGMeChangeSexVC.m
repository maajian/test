#import "PGBytesFromData.h"
#import "PGMeChangeSexVC.h"
#import "PGMeChangeInfoViewModel.h"
@interface PGMeChangeSexVC ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)PGMeChangeInfoViewModel *viewModel;
@end
@implementation PGMeChangeSexVC
- (void)viewDidLoad {
    [super viewDidLoad];
    _viewModel = [[PGMeChangeInfoViewModel alloc]init];
    [self.view addSubview:self.tableView];
    [self customBack];
    [self rightButton];
    self.title = @"修改性别";
}
#pragma mark 懒加载
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64)];
        _tableView.delegate =self;
        _tableView.dataSource =self;
        _tableView.backgroundColor = ZDBackgroundColor;
        _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 15)];
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.1)];
    }
    return _tableView;
}
#pragma mark --- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"sexCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.tintColor = ZDMainColor;
        cell.textLabel.font = [UIFont systemFontOfSize:14];
    }
    if (indexPath.row==0) {
        cell.textLabel.text = @"男";
        if (_Sex==1)
        {cell.accessoryType = UITableViewCellAccessoryCheckmark;}
        else{
            cell.accessoryType = UITableViewCellAccessoryNone;
        };
    }else{
        cell.textLabel.text = @"女";
        if (_Sex!=1) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }else{
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0 ]];
        cell.accessoryType = UITableViewCellAccessoryNone;
        _Sex = 1;
    }else{
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0 ]];
        cell.accessoryType = UITableViewCellAccessoryNone;
        _Sex = 2;
    }
    UITableViewCell *currentCell = [tableView cellForRowAtIndexPath:indexPath];
    currentCell.accessoryType = UITableViewCellAccessoryCheckmark;
}
-(void)customBack
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(-8, 20, 80, 44)];
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backpop)];
    UILabel *button = [MyLabel initWithLabelFrame:CGRectMake(0, 0, 40,45) Text:@"取消" textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:17] textAlignment:NSTextAlignmentLeft cornerRadius:0 masksToBounds:NO];
    [view addSubview:button];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:view];
    self.navigationItem.leftBarButtonItem = item;
    [view addGestureRecognizer:tap3];
}
-(void)rightButton
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(save)];
    NSDictionary *dic = @{NSFontAttributeName : KHeitiSCMedium(17),
                          NSForegroundColorAttributeName:ZDMainColor};
    [item setTitleTextAttributes:dic forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = item;
}
- (void)backpop{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)save{
dispatch_async(dispatch_get_main_queue(), ^{
    CGRect passWordWithC8 = CGRectZero;
        UITextFieldViewMode metersTimeLabelc5 = UITextFieldViewModeAlways; 
    PGBytesFromData *userModelFrom= [[PGBytesFromData alloc] init];
[userModelFrom maskViewFlagWithgroupPurchaseTable:passWordWithC8 circleItemShare:metersTimeLabelc5 ];
});
    NSDictionary *sexDic = @{@"sex":@(_Sex)};
    MBProgressHUD *hud = [PGMyHud initWithAnimationType:MBProgressHUDAnimationFade showAnimated:YES UIView:self.view];
    hud.label.text = @"正在加载";
    __weak typeof(self) weakSelf = self;
    [_viewModel UpdateUserInfo:sexDic successBlock:^(id responseObject) {
        [hud hideAnimated:YES afterDelay:0.5];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
             [weakSelf.navigationController popViewControllerAnimated:YES];
        });
    } errorBlock:^(NSError *error) {
        [hud hideAnimated:YES];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end