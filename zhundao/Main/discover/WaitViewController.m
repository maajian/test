//
//  WaitViewController.m
//  zhundao
//
//  Created by zhundao on 2017/3/22.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "WaitViewController.h"
#import "muliSignViewController.h"
#import "LoadallsignModel.h"
#import "GZActionSheet.h"
#import "muliPostData.h"
static NSString *reUseID = @"moreSignReuseID";
@interface WaitViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    JQIndicatorView *indicator;
    NSInteger leftNumber;
    NSInteger centerNumber ;
    NSInteger rightNumber;
    Reachability *r;
}
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *vcodeLabel;
@property (weak, nonatomic) IBOutlet UILabel *peopleLabel;
@property (weak, nonatomic) IBOutlet UILabel *placeLabel;
@property(nonatomic,strong)UITableView                 *tableview;
@property (weak, nonatomic) IBOutlet UIImageView *topSaoImageview;
@property(nonatomic,strong)NSMutableArray             *dataArray;  // 左边标题的数组
@property(nonatomic,strong)NSMutableArray             *dataArray1; // 右边结果的数组
@property(nonatomic,strong)UILabel                      *leftLabel ;  //头视图左边标签
@property(nonatomic,strong)UILabel                      *centerLabel ;  //头视图左边标签
@property(nonatomic,strong)UILabel                      *rightLabel ;  //头视图左边标签
@property(nonatomic,strong)UILabel                      *nullLabel ;  //空数据label
@property(nonatomic,strong)UILabel                      *cellLeftLabel ;  //空数据label
@property(nonatomic,strong)UILabel                      *cellRightLabel ;  //空数据label
@property(nonatomic,strong)UIButton                      *bottonSaoButton;   //扫码按钮
@property(nonatomic,strong)UIImageView                   *saoImageView;  //扫码中心图片
@property(nonatomic,strong)UIImageView                   *nullImageView;  //扫码中心图片
@property(nonatomic,strong)UIProgressView                *progressView;
@end

@implementation WaitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"准到多点签到";
    [self isHaveNet];
    [self setLabelData];
    [self createTableView];
    [self rightButton];
     [self shownull:_dataArray];   //是否显示空数据
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.hidesBackButton = YES;
    [self customBack];
}
#pragma mark  mark  mark 基础设置
-(void)customBack
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(-8, 20, 80, 44)];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backpop)];
    UIImageView *imageview = [MyImage initWithImageFrame:CGRectMake(-8, 10, 25, 25) imageName:@"nav_back" cornerRadius:0 masksToBounds:NO];
    UILabel *button = [MyLabel initWithLabelFrame:CGRectMake(15, 0, 40,45) Text:@"返回" textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:17] textAlignment:NSTextAlignmentLeft cornerRadius:0 masksToBounds:NO];
    [view addSubview:imageview];
    [view addSubview:button];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:view];
    self.navigationItem.leftBarButtonItem = item;
    [view addGestureRecognizer:tap];
}
- (void)backpop
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)shownull :(NSArray *)nullArray
{
    if (nullArray.count==0&&_nullLabel==nil) {   //么有数据 且不存在label
          [self.view insertSubview:self.nullLabel belowSubview:_tableview];
         [self.view insertSubview:self.nullImageView belowSubview:_tableview];
    }
}
- (void)setLabelData
{
    NSArray *arr = [[NSUserDefaults standardUserDefaults]objectForKey:@"muliData"];
    _placeLabel.text = arr.firstObject;
    _peopleLabel.text = [arr objectAtIndex:1];
    _titleLabel.text= [arr objectAtIndex:2];
    if ([[arr lastObject]integerValue]==1) {
        _statusLabel.text =@"进行中";
        _topSaoImageview.hidden = NO;
        [self addGes];
    }
    else{
        _statusLabel.text = @"已关闭";
        _topSaoImageview.hidden = YES;
    }
}
- (void)addGes
{
    _topSaoImageview.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushSAO)];
    [_topSaoImageview addGestureRecognizer:tap];
}

#pragma mark  mark 懒加载模块
- (NSMutableArray *)dataArray  //标题
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (NSMutableArray *)dataArray1
{
    if (!_dataArray1) {
        _dataArray1 = [NSMutableArray array];
    }
    return _dataArray1;
}
- (UILabel *)leftLabel{
    if (!_leftLabel) {
        _leftLabel = [MyLabel initWithLabelFrame:CGRectMake(10, 0, 80, 35) Text:[NSString stringWithFormat:@"全部"] textColor: [UIColor grayColor] font:[UIFont systemFontOfSize:12] textAlignment:NSTextAlignmentLeft cornerRadius:0 masksToBounds:NO];
    }
    return _leftLabel;
}
- (UILabel *)centerLabel
{
    if (!_centerLabel) {
        _centerLabel = [MyLabel initWithLabelFrame:CGRectMake(kScreenWidth/2-40, 0, 80, 35) Text:[NSString stringWithFormat:@"已签"] textColor: [UIColor grayColor] font:[UIFont systemFontOfSize:12] textAlignment:NSTextAlignmentCenter cornerRadius:0 masksToBounds:NO];
    }
    return _centerLabel;
}
-(UILabel *)rightLabel
{
    if (!_rightLabel) {
        _rightLabel = [MyLabel initWithLabelFrame:CGRectMake(kScreenWidth-90, 0, 80, 35) Text:[NSString stringWithFormat:@"未签"] textColor: [UIColor grayColor] font:[UIFont systemFontOfSize:12] textAlignment:NSTextAlignmentRight cornerRadius:0 masksToBounds:NO];
    }
    return _rightLabel;
}
- (UIButton *)bottonSaoButton
{
    if (!_bottonSaoButton) {
        NSArray *arr = [[NSUserDefaults standardUserDefaults]objectForKey:@"muliData"];
        if ([[arr lastObject]integerValue]) {
            _bottonSaoButton = [MyButton initWithButtonFrame:CGRectMake(20, kScreenHeight-150-138, kScreenWidth-40, 44) title:@"扫码" textcolor:[UIColor whiteColor] Target:self action:@selector(pushSAO) BackgroundColor:zhundaoGreenColor cornerRadius:5 masksToBounds:YES];
            _bottonSaoButton.titleEdgeInsets = UIEdgeInsetsMake(0, 32, 0, 0);
        }
        else{
            _bottonSaoButton = [MyButton initWithButtonFrame:CGRectMake(20, kScreenHeight-150-138, kScreenWidth-40, 44) title:@"扫码" textcolor:[UIColor whiteColor] Target:self action:@selector(pushSAO) BackgroundColor:zhundaoGrayColor cornerRadius:5 masksToBounds:YES];
            _bottonSaoButton.titleEdgeInsets = UIEdgeInsetsMake(0, 32, 0, 0);
            _bottonSaoButton.userInteractionEnabled =NO;
        }
    }
    return _bottonSaoButton;
}
- (UIImageView *)saoImageView
{
    if (!_saoImageView) {
        _saoImageView = [MyImage initWithImageFrame:CGRectMake(kScreenWidth/2-32, kScreenHeight-150-128, 25, 25) imageName:@"sign_scan" cornerRadius:0 masksToBounds:NO];
    }
    return _saoImageView;
}
- (UIImageView *)nullImageView
{
    if (!_nullImageView) {
        _nullImageView =  [MyImage initWithImageFrame:CGRectMake(kScreenWidth/2-60 , kScreenHeight/2-60, 120, 120) imageName:@"空数据-5" cornerRadius:0 masksToBounds:NO];
    }
    return _nullImageView;
}
- (UILabel *)nullLabel
{
    if (!_nullLabel) {
        _nullLabel = [MyLabel initWithLabelFrame:CGRectMake(kScreenWidth/2-100 , kScreenHeight/2+100, 200, 40) Text:@"暂时没有签到^^" textColor:[UIColor lightGrayColor] font:[UIFont systemFontOfSize:18] textAlignment:NSTextAlignmentCenter cornerRadius:0 masksToBounds:NO];
    }
    return _nullLabel;
}

- (UIProgressView *)progressView
{
    if (!_progressView) {
       _progressView= [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
      _progressView.frame = CGRectMake(0, 0,kScreenWidth, 10);
        _progressView.progress = 0;
        _progressView.trackTintColor = [UIColor redColor];
         _progressView.progressTintColor = [UIColor greenColor];
    }
    return  _progressView;
}
#pragma mark  mark 网络请求模块
- (void)isHaveNet   //判断是否有网
{
    r = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([r currentReachabilityStatus]) {
        case NotReachable:
            [self dataBaseSeacrhData];
            break;
        case ReachableViaWWAN:
            // 使用3G网
            [self netWorkWithIndicator:YES];
            break;
        case ReachableViaWiFi:
            // 使用WiFi网络
            [self netWorkWithIndicator:YES];
            break;
    }
    
}
- (void)showindicator
{
    indicator = [[JQIndicatorView alloc]initWithType:2 tintColor: [UIColor colorWithRed:9.00f/255.0f green:187.00f/255.0f blue:7.00f/255.0f alpha:1] size:CGSizeMake(70, 70)];
    indicator.center = _tableview.center;
    [_tableview addSubview:indicator];
    [indicator startAnimating];
}


- (void)netWorkWithIndicator :(BOOL )isShow
{
    NSString *listurl = [NSString stringWithFormat:@"%@api/CheckIn/PostCheckInList?accessKey=%@",zhundaoApi,_acckey];
    NSDictionary *dic = @{@"Type":@"0",
                          @"ID":[NSString stringWithFormat:@"%li",(long)self.signID],
                          @"pageSize":@"200000",
                          @"curPage":@"1"};
    [self createDataTable];
    if (isShow) {
        [self showindicator];
    }
    [self postdataWithListurl:listurl WithDic:dic indicator:isShow];
}
- (void)postdataWithListurl:(NSString *)listurl WithDic :(NSDictionary *)dic indicator :(BOOL )isShow
{
    [ZD_NetWorkM postDataWithMethod:listurl parameters:dic succ:^(NSDictionary *obj) {
        if ([obj[@"Res"] integerValue] == 0) {
            NSDictionary *result = [NSDictionary dictionaryWithDictionary:obj];
            [self savaDataWithResult:result indicator:isShow];   //保存数据进数据库
            [self dataBaseSeacrhData];          //从数据库中搜索数据
            [_tableview reloadData];
        } else {
            maskLabel *label = [[maskLabel alloc] initWithTitle:obj[@"Msg"]];
            [label labelAnimationWithViewlong:self.view];
        }
    } fail:^(NSError *error) {
        if (isShow) {
            [indicator stopAnimating];
        }
        NSLog(@"error =%@",error);
    }];
}

#pragma mark  mark 数据库操作
- (void)savaDataWithResult :(NSDictionary *)dic   indicator :(BOOL )isShow   //保存数据进数据库
{
    NSArray *array1 = dic[@"Data"];
    if ([[SignManager shareManager].dataBase open]) {
        [self transactionwithArray1:array1];
        [[SignManager shareManager].dataBase close];
    }
    if (isShow) {
        [indicator stopAnimating];
         [self showHudWitharray:array1];
    }
}
- (void)showHudWitharray :(NSArray *)array1  //数据下载成功hud
{
    MBProgressHUD *hud = [MyHud initWithMode:MBProgressHUDModeCustomView labelText:[NSString stringWithFormat:@"已下载%lu人到本地",(unsigned long)array1.count] showAnimated:YES UIView:self.view imageName:@"签到打勾"];
    [hud hideAnimated:YES afterDelay:1];
}
-(void)transactionwithArray1 :(NSArray *)array1 {   //事务封装插入
    // 开启事务
    [[SignManager shareManager].dataBase beginTransaction];
    BOOL isRollBack = NO;
    @try {
        for (NSDictionary *acdic in array1) {
            LoadallsignModel *model = [LoadallsignModel yy_modelWithJSON:acdic];
            NSString *insertSql =[NSString stringWithFormat:@"replace INTO muliSignList(vcode, signID,Status,AdminRemark,FeeName,Fee,phone,trueName)VALUES('%@',%li,%li,'%@','%@',%f,'%@','%@')",model.VCode,(long)self.signID,(long)model.Status,model.AdminRemark,model.FeeName,model.Fee,model.Mobile,model.TrueName];
            BOOL res = [[SignManager shareManager].dataBase executeUpdate:insertSql];
            if (res) {
                NSLog(@"数据表插入成功");
            }
            else
            {
                NSLog(@"数据表插入失败");
            }
        }
    }
    @catch (NSException *exception) {
        isRollBack = YES;
        // 事务回退
        [[SignManager shareManager].dataBase rollback];
    }
    @finally {
        if (!isRollBack) {
            //事务提交
            [[SignManager shareManager].dataBase commit];
        }
    }
}

- (void)createDataTable  //创建数据表
{
    SignManager *datamanager = [SignManager shareManager];
    [datamanager createDatabase];
    if ([datamanager.dataBase open]) {
//                    NSString *updateSql = [NSString stringWithFormat:@"DROP TABLE muliSignList"];
//                    BOOL res = [datamanager.dataBase executeUpdate:updateSql];
        bool result = [datamanager.dataBase executeUpdate:@"CREATE TABLE IF NOT EXISTS muliSignList(vcode TEXT NOT NULL,signID integer NOT NULL,trueName TEXT,Status integer,post integer DEFAULT 2,AdminRemark TEXT,phone TEXT,Fee DOUBLE,addTime TEXT,FeeName TEXT, PRIMARY KEY(vcode, signID));"];
        if (result) {
            NSLog(@"成功创建table");
        }
        else
        {
            NSLog(@"创建table失败");
        }
        [datamanager.dataBase close];
    }

}
- (void)dataBaseSeacrhData   //搜索数据库 
{   leftNumber = centerNumber = rightNumber= 0;
    [self numberCount];
}
- (void)numberCount
{
    SignManager *datamanager = [SignManager shareManager];
    [datamanager createDatabase];
    if ([datamanager.dataBase open]) {
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM muliSignList WHERE signID = %li",(long)self.signID];
        FMResultSet *rs = [datamanager.dataBase executeQuery:sql];
        while ([rs next]) {
            leftNumber+=1;
            if ([rs intForColumn:@"Status"]==1) {
                centerNumber+=1;
            }
            else
            {
                rightNumber+=1;
            }
        }
        [datamanager.dataBase close];
    }
}

#pragma mark  mark 按钮点击事件
- (void)pushSAO { //扫码按钮
    muliSignViewController *muli = [[muliSignViewController alloc]init];
    muli.signID = self.signID;
    muli.acckey = self.acckey;
    [self presentViewController:muli animated:YES completion:nil];
    muli.signStatusBlock = ^(NSInteger status,FMResultSet *rs)
    {
        [self settextWithstatus:status WithFMResultSet:rs];
     
    };
    muli.haveNetBlock = ^(NSInteger status,NSDictionary *dic)
    {

        [self haveNetWithStatus:status WithDic:dic];
    };
}

- (void)settextWithstatus :(NSInteger )status WithFMResultSet :(FMResultSet *)rs   //没网的回调bolck
{
    switch (status) {
        case 0:
            NSLog(@"已经签到");
            [self errorCaseWithStr:@"该用户已经签到!" WithStatus:0];
            [self getDataFromRs:rs];
            break;
        case 1:
            NSLog(@"签到成功");
             [self errorCaseWithStr:@"签到成功!" WithStatus:1];
            [self getDataFromRs:rs];
            break;
        case 2:
        {
            NSLog(@"无效");
              [self errorCaseWithStr:@"签到失败,凭证码无效!" WithStatus:2];
            _vcodeLabel.text = @"签到失败,凭证码无效";
        }
            break;
        default:
            break;
    }
}
- (void)errorCaseWithStr :(NSString *)str WithStatus :(NSInteger)status
{
    [self removeData];
    [_tableview reloadData];
    _nullLabel.text = str;
    switch (status) {
        case 0:
            _nullImageView.image =nil;
            _nullLabel.text = str;
            break;
        case 1:
            _nullImageView.image = nil;
            _nullLabel.text = str;
            break;
        case 2:
             _nullImageView.image = [UIImage imageNamed:@"空数据-5"];
            _nullLabel.text = str;
            break;
            
        default:
            break;
    }
  
}
- (void)haveNetWithStatus :(NSInteger) status WithDic :(NSDictionary *)dic
{
    switch (status) {
        case 0:
            NSLog(@"已经签到");
      [self errorCaseWithStr:@"该用户已经签到!" WithStatus:0];
            [self getdataFromDic:dic];
            break;
        case 1:
            NSLog(@"签到成功!");
              [self errorCaseWithStr:@"签到成功!" WithStatus:1];
            [self getdataFromDic:dic];
            break;
        case 2:
        {
     [self errorCaseWithStr:@"签到失败,凭证码无效!" WithStatus:2];
            _vcodeLabel.text = @"签到失败,凭证码无效";
        }
            break;
        default:
            break;
    }
}
#pragma mark  mark  block   回调刷新
//[NSString stringWithFormat:@"%@\n姓名 : %@\n手机 : %@\n备注 : %@\n费用名称 : %@\n费用 : %.2f",str,name,phone,adminStr,feeName,fee]
//[feeName isEqualToString:@"(null)"]
- (void)getDataFromRs:(FMResultSet *)rs  //没网有数据的返回
{
    [self removeData];
        if (![[rs stringForColumn:@"trueName"] isEqualToString:@"(null)"]) {
            [_dataArray addObject:@"姓名"];
            [_dataArray1 addObject:[rs stringForColumn:@"trueName"]];
        }
        if (![[rs stringForColumn:@"phone"] isEqualToString:@"(null)"]) {
             NSString *Mobile =[rs stringForColumn:@"phone"];
            [_dataArray addObject:@"手机"];
            [_dataArray1 addObject:[self getPhoneStr:Mobile]];
        }
    if (![[rs stringForColumn:@"feeName"] isEqualToString:@"(null)"]) {
        [_dataArray addObject:@"费用名称"];
        [_dataArray1 addObject:[rs stringForColumn:@"feeName"]];
        [_dataArray addObject:@"费用"];
        [_dataArray1 addObject:[rs stringForColumn:@"fee"]];
    }
    if (![[rs stringForColumn:@"AdminRemark"] isEqualToString:@"(null)"]) {
        [_dataArray addObject:@"备注"];
         [_dataArray1 addObject:[rs stringForColumn:@"AdminRemark"]];
    }
    _vcodeLabel.text = [rs stringForColumn:@"VCode"];
    [self shownull:_dataArray];   //是否清除空数据
    [self dataBaseSeacrhData];    //修改头视图的数据
    [_tableview reloadData];
}
- (NSString *)getPhoneStr :(NSString *)str
{
    NSString *phone = nil;
   
    if (str.length>7) {
        phone = [str stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    }
    return phone;
}
- (void)removeData   //移除所有数据
{
    [self.dataArray removeAllObjects];
    [self.dataArray1 removeAllObjects];
}
- (void)getdataFromDic :(NSDictionary *)dic  //有网有数据的返回

{
    [self removeData];
    [_dataArray addObject:@"姓名"];
    [_dataArray addObject:@"手机"];
    [_dataArray1 addObject:[dic valueForKey:@"Name"]];
    [_dataArray1 addObject:[self getPhoneStr:[dic valueForKey:@"Phone"]]];
    if (![[dic valueForKey:@"FeeName"] isEqual:[NSNull null]]) {
        [_dataArray addObject:@"费用名称"];
        [_dataArray1 addObject:[dic valueForKey:@"FeeName"]];
        [_dataArray addObject:@"费用"];
        [_dataArray1 addObject:[dic valueForKey:@"Fee"]];
    }
    if (![[dic valueForKey:@"AdminRemark"] isEqual:[NSNull null]]) {
        [_dataArray addObject:@"备注"];
        [_dataArray1 addObject:[dic valueForKey:@"AdminRemark"]];
    }
    _vcodeLabel.text = [dic valueForKey:@"VCode"];
    [self shownull:_dataArray];
    [self dataBaseSeacrhData];
    [_tableview reloadData];
    
}
#pragma mark  mark  TableView   模块
- (void)createTableView  //创建tableview
{
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 150, kScreenWidth, kScreenHeight-150-64) style:UITableViewStylePlain];
    _tableview.dataSource =self;
    _tableview.delegate =self;
    _tableview.rowHeight = 44;
    [self.view addSubview:_tableview];
    _tableview.backgroundColor = [ UIColor clearColor];
    [_tableview addSubview:self.bottonSaoButton];
    [_tableview addSubview:self.saoImageView];
    _tableview.tableFooterView = [[UIView alloc] init];
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reUseID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reUseID];
    }
    else//当页面拉动的时候 当cell存在并且最后一个存在 把它进行删除就出来一个独特的cell我们在进行数据配置即可避免
    {
        for (UIView *view in cell.contentView.subviews) {
            if ([view isKindOfClass:[UILabel class]]) {
                [view removeFromSuperview];
            }
        }
    }
    cell.backgroundColor = [UIColor clearColor];
    _cellLeftLabel = [MyLabel initWithLabelFrame:CGRectMake(10, 0, 80, 44) Text:@"1" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:13] textAlignment:NSTextAlignmentLeft cornerRadius:0 masksToBounds:NO];
    [cell.contentView addSubview:_cellLeftLabel];
    _cellRightLabel = [MyLabel initWithLabelFrame:CGRectMake(90, 0, kScreenWidth-95, 44) Text:@"1" textColor:[UIColor lightGrayColor] font:[UIFont systemFontOfSize:13] textAlignment:NSTextAlignmentRight cornerRadius:0 masksToBounds:NO];
    [cell.contentView addSubview:_cellRightLabel];
    _cellLeftLabel.text = self.dataArray[indexPath.row];
    _cellRightLabel.text = self.dataArray1[indexPath.row];
    return  cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 35)];
    view.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    [view addSubview:self.leftLabel];
    [view addSubview:self.centerLabel];
    [view addSubview:self.rightLabel];
    _leftLabel.text = [NSString stringWithFormat:@"全部[%li]",(long)leftNumber];
    _centerLabel.text = [NSString stringWithFormat:@"已签[%li]",(long)centerNumber];
    _rightLabel.text = [NSString stringWithFormat:@"未签[%li]",(long)rightNumber];
    [self colorSTRWithStr:_leftLabel];
    [self colorSTRWithStr:_rightLabel];
    [self colorSTRWithStr:_centerLabel];
    
     return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
#pragma mark  创建其他视图 
- (void)colorSTRWithStr :(UILabel *)label
{
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc]initWithString:label.text];
    [string addAttribute:NSForegroundColorAttributeName value: kColorA(255, 169, 11, 1) range:NSMakeRange(3, label.text.length-4)];
    label.attributedText = string;
}
- (UILabel *)createCellLeftLabelWithTitle:(NSString *)title
{
    UILabel *label = [MyLabel initWithLabelFrame:CGRectMake(10, 0, 40, 44) Text:title textColor:[UIColor blackColor] font: [UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft cornerRadius:0 masksToBounds:NO];
    return  label;
}
- (UILabel *)createCellRightLabelWithTitle:(NSString *)title
{
    UILabel *label = [MyLabel initWithLabelFrame:CGRectMake(kScreenWidth/2, 0, kScreenWidth/2, 44) Text:title textColor:[UIColor blackColor] font: [UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentRight cornerRadius:0 masksToBounds:NO];
    return  label;
}
#pragma mark  右上角更多选项

- (void)showPost  //sheet显示
{
    NSArray *array = @[@"同步离线人员名单"];
    GZActionSheet *sheet = [[GZActionSheet alloc]initWithTitleArray:array WithRedIndex:1 andShowCancel:YES];
    // 2. Block 方式
    __weak typeof(self) weakSelf = self;
    sheet.ClickIndex = ^(NSInteger index){
        NSLog(@"Show Index %zi",index); //取消0
        
        if (index==1) {   //删除
            [weakSelf postData];
        }
        
    };
    
    [self.view.window addSubview:sheet];
}
- (void)rightButton   // 添加rightbutton
{
     [UIButton initCreateButtonWithFrame:CGRectMake(0, 0, 25, 25) WithImageName:@"nav_more" Withtarget:self Selector:@selector(showPost)];
}
#pragma mark  GZActionSheet action 响应事件
- (void)postData // 发送离线数据
{
    muliPostData *muli = [[muliPostData alloc]init];
    [muli postWithView:self.view isShow:YES acckey:_acckey];
    muli.updataBlock = ^(BOOL isSuccess)
    {
        if (isSuccess) {
            MBProgressHUD *hud = [MyHud initWithMode:MBProgressHUDModeCustomView labelText:@"上传成功" showAnimated:YES UIView:self.view imageName:@"签到打勾"];
            [hud hideAnimated:YES afterDelay:2];
            [self netWorkWithIndicator:NO];
        }
        else
        {
            [[SignManager shareManager]showNotHaveNet:self.view];
        }
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//- (void)dealloc
//{
//    NSLog(@"dealloc");
//}
/*
#pragma mark  mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
