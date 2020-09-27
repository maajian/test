#import "PGDailyCourseModel.h"
#import "PGAvtivityPostSignVC.h"
#import "GZActionSheet.h"
#import "PGAvtivityCodeVC.h"
@interface PGAvtivityPostSignVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    UITextField *textf;
     UILabel *label1 ;
     UILabel *label2 ;
    UILabel *label3;
    UILabel *label4;
    UITableViewCell *cell;
    UIImageView *chooseImage;
}
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)NSArray *dataArray;  
@end
@implementation PGAvtivityPostSignVC
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createArray];
    [self createDataArray];
    [self getIndex];
    [self createTableview];
    [self createButton];
    [self settitle];
    self.view.backgroundColor = ZDBackgroundColor;
}
- (void)settitle
{
  self.title=[_dataArray1[0] isEqualToString:@""]? @"发起签到":@"修改签到";
}
- (void)createArray   
{
    _dataArray =@[@"签到名称 :",
                  @"活动选择 :",
                  @"签到对象 :"];
}
- (void)createDataArray   
{
    _dataArray1 = @[@"",
                    [NSString stringWithFormat:@"%@",self.activityName],
                     @"限报名人员",
                    ];
}
- (void)getIndex {
    if ([_dataArray1[2] isEqualToString:@"限报名人员"]) {
        _selectIndex = 0;
    }else{
        _selectIndex = 1 ;
    }
}
- (void)createTableview  
{
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    self.tableview.delegate =self;
    self.tableview.dataSource = self;
    self.tableview.tableFooterView = [[UIView alloc] init];
    _tableview.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tableview];
}
#pragma mark --- tableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%ld%ld", (long)[indexPath section], (long)[indexPath row]];
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
    }
    while (cell.contentView.subviews.lastObject!=nil) {
        [cell.contentView.subviews.lastObject removeFromSuperview];
    }
    UILabel *label  = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 80, 44)];   
    [cell.contentView addSubview:label];
    label.text = _dataArray[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:18];
    if (indexPath.row==0) {
        textf = [[UITextField alloc]initWithFrame:CGRectMake(100, 0, kScreenWidth-80, 44)];  
        textf.placeholder = @"请填写签到名称";
        if ([_dataArray1[indexPath.row] isEqualToString:@""]) {   
            textf.text = [NSString stringWithFormat:@"%@[签到]",_activityName];
        }
        else{                                               
            textf.text = _dataArray1[indexPath.row];
        }
        [cell.contentView addSubview:textf];
    }
    if (indexPath.row==1) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        label2 = [MyLabel initWithLabelFrame:CGRectMake(100, 0, kScreenWidth-100, 44) Text:_dataArray1[indexPath.row] textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:18] textAlignment:NSTextAlignmentLeft cornerRadius:0 masksToBounds:NO];  
        [cell.contentView addSubview:label2];
        cell.userInteractionEnabled = NO;
        label2.textColor = [UIColor lightGrayColor];
    }
    if (indexPath.row==2) {
        label3 = [MyLabel initWithLabelFrame:CGRectMake(100, 0, kScreenWidth-100, 44) Text:@"限报名人员" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:18] textAlignment:NSTextAlignmentLeft cornerRadius:0 masksToBounds:NO];  
        [cell.contentView addSubview:label3];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(PG_typeChoose:)];
        label3.userInteractionEnabled = YES;
        [label3 addGestureRecognizer:tap];
        label3.tag = 0;
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.strokeColor = ZDLineColor.CGColor;
        UIBezierPath *bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint:CGPointMake(100,44)];
        [bezierPath addLineToPoint:CGPointMake(kScreenWidth, 44)];
        [bezierPath stroke];
        layer.path = bezierPath.CGPath;
        [cell.contentView.layer addSublayer:layer];
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(PG_typeChoose:)];
        label4 = [MyLabel initWithLabelFrame:CGRectMake(100, 44, kScreenWidth-100, 44) Text:@"不限报名人员" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:18] textAlignment:NSTextAlignmentLeft cornerRadius:0 masksToBounds:NO];  
        [cell.contentView addSubview:label4];
        label4.userInteractionEnabled = YES;
        [label4 addGestureRecognizer:tap1];
        label4.tag = 1;
        chooseImage  = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth-140, 10, 25, 25)];
        chooseImage.image = [UIImage imageNamed:@"img_public_check_right"];
        if (_selectIndex == 0) [label3 addSubview:chooseImage];
        else [label4 addSubview:chooseImage];
    }
    return cell;
}
#pragma mark  ----- tableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==2) {
        return 88;
    }else{
        return 44;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .5;
}
#pragma mark  ---按钮创建
- (void)createButton
{
    UIButton *button = [MyButton initWithButtonFrame:CGRectMake(10,215, kScreenWidth-20, 40) title:@"确定" textcolor:[UIColor whiteColor] Target:self action:@selector(buttonAction) BackgroundColor:ZDMainColor cornerRadius:3 masksToBounds:YES];
    [_tableview addSubview:button];  
}
- (void)buttonAction
{
    if ([textf.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length==0) {
        [self showMask:@"请填写签到名称"];
    }
    else{
        JQIndicatorView *indicator = [[JQIndicatorView alloc]initWithType:3 tintColor: [UIColor colorWithRed:9.00f/255.0f green:187.00f/255.0f blue:7.00f/255.0f alpha:1] size:CGSizeMake(90, 70)];
            indicator.center = self.view.center;
            [self.view addSubview:indicator];
            [indicator startAnimating];
        NSString *urlStr = [self urlStr];
        NSDictionary *dic = [self getPostDic];
        if ([_dataArray1.firstObject isEqualToString:@""]) {
            [ZD_NetWorkM postDataWithMethod:urlStr parameters:dic succ:^(NSDictionary *obj) {
                [indicator stopAnimating];
                if ([obj[@"Res"] integerValue] == 0) {
                    [self showhud];
                } else {
                    [self showMask:obj[@"Msg"]];
                }
                [[NSNotificationCenter defaultCenter] postNotificationName:ZDUserDefault_Update_Sign object:nil];
                [self back];
            } fail:^(NSError *error) {
                NSLog(@"error = %@",error);
                [indicator stopAnimating];
                [self showMask:@"服务器开小差啦"];
            }];
        }
        else
        {
            NSDictionary *param = @{@"ID": @(self.signID),
                                    @"Name": textf.text,
                                    @"SignObject":@(_selectIndex)};
            [ZD_NetWorkM postDataWithMethod:urlStr parameters:param succ:^(NSDictionary *obj) {
                [indicator stopAnimating];
                if ([obj[@"Res"] integerValue] == 0) {
                    [self showhud];
                } else {
                    [self showMask:obj[@"Msg"]];
                }
                [[NSNotificationCenter defaultCenter] postNotificationName:ZDUserDefault_Update_Sign object:nil];
                [self back];
            } fail:^(NSError *error) {
                NSLog(@"error = %@",error);
                [indicator stopAnimating];
                [self showMask:@"服务器开小差啦"];
            }];
        }
    }
}
#pragma mark----手势处理
- (void)PG_typeChoose:(UITapGestureRecognizer *)tap{
    _selectIndex = tap.view.tag;
    UILabel *label = (UILabel *)tap.view;
    [label addSubview:chooseImage];
}
#pragma mark---提交
- (void)back
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController popViewControllerAnimated:YES];
    });
}
- (void)showhud
{
    MBProgressHUD *hud = [PGMyHud initWithMode:MBProgressHUDModeCustomView labelText:@"操作成功" showAnimated:YES UIView:self.view imageName:@"img_public_signin_check"];
    [hud hideAnimated:YES afterDelay:1.5];
}
- (NSDictionary *)getPostDic
{
    NSInteger b = _selectIndex;
    return @{@"CheckInType" : @(0),
             @"CheckInWay" : @(6),
             @"Name" : textf.text,
             @"SignObject" :[NSString stringWithFormat:@"%li",(long)b],
             @"ActivityID" :[NSString stringWithFormat:@"%li",(long)self.acID]
             };
}
- (NSString *)urlStr
{
    if ([_dataArray1.firstObject isEqualToString:@""]) {
        return [NSString stringWithFormat:@"%@api/v2/checkIn/addCheckIn?token=%@",zhundaoApi,[[PGSignManager shareManager] getToken]];
    }
    else{
        return  [NSString stringWithFormat:@"%@api/v2/checkIn/updateCheckIn?token=%@",zhundaoApi,[[PGSignManager shareManager] getToken]];
    }
}
- (void)didReceiveMemoryWarning {
dispatch_async(dispatch_get_main_queue(), ^{
    UIEdgeInsets groupPurchaseViewM2 = UIEdgeInsetsMake(39,94,153,198); 
        UISwitch *pickerViewDelegatem6= [[UISwitch alloc] initWithFrame:CGRectMake(36,94,144,212)]; 
    pickerViewDelegatem6.on = YES; 
    pickerViewDelegatem6.onTintColor = [UIColor whiteColor]; 
    PGDailyCourseModel *taskCenterTable= [[PGDailyCourseModel alloc] init];
[taskCenterTable interfaceOrientationMaskWithtrainCommentModel:groupPurchaseViewM2 receiveMemoryWarning:pickerViewDelegatem6 ];
});
    [super didReceiveMemoryWarning];
}
- (void)showMask:(NSString *)title
{
    PGMaskLabel *label = [[PGMaskLabel alloc]initWithTitle:title];
    [label labelAnimationWithViewlong:self.view];
}
@end
