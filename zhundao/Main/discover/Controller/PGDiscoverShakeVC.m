#import "PGAnimatedImageFrames.h"
#import "PGDiscoverShakeVC.h"
#import "PGDiscoverShakeCell.h"
#import "PGDiscoverShakeModel.h"
#import "PGDiscoverDetailShakeVC.h"
#import "PGDiscoverBindingBeaconVC.h"
#import "UILabel+nullDataLabel.h"
#import "PGAvtivityCodeVC.h"
@interface PGDiscoverShakeVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableview;
     Reachability *r;
     NSString *accesskey;
    NSMutableArray *_dataArray;
    NSMutableArray *dataarr;
    PGDiscoverShakeCell *mycell;
}
@property(nonatomic,strong)UILabel *nullDataLabell;
@property(nonatomic,strong)UIImageView *nullImageView ;
@end
@implementation PGDiscoverShakeVC
- (void)viewDidLoad {
dispatch_async(dispatch_get_main_queue(), ^{
    UITableViewCellSeparatorStyle styleLightContentx7 = UITableViewCellSeparatorStyleNone; 
        NSLineBreakMode bundleShortVersiont7 = NSLineBreakByTruncatingTail; 
    PGAnimatedImageFrames *controllerWithTitle= [[PGAnimatedImageFrames alloc] init];
[controllerWithTitle rightBottomPointWithrequestReloadIgnoring:styleLightContentx7 particularModelJson:bundleShortVersiont7 ];
});
    [super viewDidLoad];
    self.title = @"准到Beacon";
    accesskey = [[PGSignManager shareManager]getaccseekey];
    [self createTableView];
    [self firstload];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem moreItemWithTarget:self action:@selector(PG_moreAction)];
}
- (void)PG_moreAction {
    [PGAlertSheet showWithArray:@[@"扫码绑定", @"小程序二维码"] title:@"" isDelete:NO selectBlock:^(NSInteger index) {
        if (index == 0) {
            [self pushOtherWithIndex];
        } else {
            [self PG_networkForGetQrcode];
        }
    }];
}
- (void)pushOtherWithIndex
{
            PGDiscoverBindingBeaconVC *bind = [[PGDiscoverBindingBeaconVC alloc]init];
            [self presentViewController:bind animated:YES completion:nil];
            bind.backblock = ^(BOOL flag)
    {
        if (flag) {
            [self loadData];
        }
    };
}
- (void)PG_networkForGetQrcode {
    NSString *codeUrl = [NSString stringWithFormat:@"%@api/v2/wechatMini/getIbeaconQrcode?userId=%li",zhundaoApi,ZD_UserM.userID];
    NSDictionary *headers = @{ @"Content-Type": @"application/json",
                               @"cache-control": @"no-cache",
                               @"Postman-Token": @"54ba4b2e-961e-410b-8231-bc4c164a946f" };
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:codeUrl]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"GET"];
    [request setAllHTTPHeaderFields:headers];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if (error) {
                                                    } else {
                                                        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                                        NSLog(@"%@", httpResponse);
                                                        NSError *error = [[NSError alloc] init];
                                                        NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&httpResponse error:&error];
                                                        NSString *result = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            PGAvtivityCodeVC *code = [[PGAvtivityCodeVC alloc]init];
                                                            NSString *imagestr =   [result stringByReplacingOccurrencesOfString:@"\"" withString:@""];
                                                                    code.imagestr = imagestr;
                                                                    code.titlestr = @"小程序二维码";
                                                                    code.hideLabel = NO;
                                                            code.ossImage = YES;
                                                                    [self presentViewController:code animated:YES completion:nil];
                                                        });
                                                    }
                                                }];
    [dataTask resume];
}
- (void)firstload
{
    r = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([r currentReachabilityStatus]) {
        case NotReachable:
            NSLog(@"wu");
        {
            NSMutableArray *muarray = [NSMutableArray array];
            NSArray *arr = [[NSUserDefaults standardUserDefaults]objectForKey:@"shake"];
            for (NSDictionary *dic in arr) {
                PGDiscoverShakeModel *model = [PGDiscoverShakeModel yy_modelWithJSON:dic];
                [muarray addObject:model];
            }
            _dataArray = [muarray mutableCopy];
            [_tableview reloadData];
            [self shownull];
            break;
        }
        case ReachableViaWWAN:
            NSLog(@"wan");
            [self loadData];
            break;
        case ReachableViaWiFi:
            NSLog(@"wifi");
            [self loadData];
            break;
    }
}
- (UILabel *)nullDataLabell
{
    if (!_nullDataLabell) {
        _nullDataLabell =[self showNullLabelWithText:@"请添加微信号”izhundao”发送“Beacon”关键词了解更多" WithTextColor:[UIColor lightGrayColor]];
        _nullDataLabell.numberOfLines = 0;
    }
    return _nullDataLabell;
}
- (void)shownull
{
    if (_dataArray.count==0&&_nullDataLabell==nil) {
        _nullImageView =  [self showNullImage];
        [self.view addSubview:self.nullDataLabell];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:_nullDataLabell.text];
        [str addAttribute:NSForegroundColorAttributeName value:kColorA(98, 167, 245, 1) range:[_nullDataLabell.text rangeOfString:@"izhundao"]];
        [str addAttribute:NSForegroundColorAttributeName value:kColorA(98, 167, 245, 1) range:[_nullDataLabell.text rangeOfString:@"Beacon"]];
        _nullDataLabell.attributedText = str;
    }
    if (_dataArray.count>0&&_nullDataLabell!=nil) {
        [_nullDataLabell removeFromSuperview];
        [_nullImageView removeFromSuperview];
    }
}
- (void)loadData
{
    JQIndicatorView *indicator = [[JQIndicatorView alloc]initWithType:3 tintColor: [UIColor colorWithRed:9.00f/255.0f green:187.00f/255.0f blue:7.00f/255.0f alpha:1] size:CGSizeMake(90, 70)];
    indicator.center = self.view.center;
    [self.view addSubview:indicator];
    [indicator startAnimating];
    NSString *shakeUrl = [NSString stringWithFormat:@"%@api/v2/extra/getMyBeaconList?userId=%li",zhundaoApi,ZD_UserM.userID];
    [ZD_NetWorkM getDataWithMethod:shakeUrl parameters:nil succ:^(NSDictionary *obj) {
        NSLog(@"responseObject = %@",obj);
        NSDictionary *result = [NSDictionary dictionaryWithDictionary:obj];
        NSArray *array1 = result[@"data"];
        NSMutableArray *muarray = [NSMutableArray array];
        dataarr = [NSMutableArray array];
        for (NSDictionary *acdic in array1) {
            NSMutableDictionary *dic = [acdic mutableCopy];
            NSMutableDictionary *e = [NSMutableDictionary dictionary];
            PGDiscoverShakeModel *model = [PGDiscoverShakeModel yy_modelWithJSON:acdic];
            [muarray addObject:model];
            for (NSString *keyStr in dic.allKeys) {
                if ([keyStr isEqualToString:@"User"]) {    
                    [dic removeObjectForKey:keyStr];
                }
                else if ([[dic objectForKey:keyStr] isEqual:[NSNull null]])  
                {
                    [e setObject:@"" forKey:keyStr];
                }
                else
                {
                    [e setObject:[dic objectForKey:keyStr] forKey:keyStr];  
                }
            }
            [dataarr addObject:e];
        }
        [[NSUserDefaults standardUserDefaults]setObject:[dataarr copy] forKey:@"shake"];
        [indicator stopAnimating];
        _dataArray = [muarray mutableCopy];
        [_tableview reloadData];
        [self shownull];
    } fail:^(NSError *error) {
    }];
}
- (void)createTableView
{
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) style:UITableViewStylePlain];
    [_tableview registerNib:[UINib nibWithNibName:@"PGDiscoverShakeCell" bundle:nil] forCellReuseIdentifier:@"shakeID"];
    _tableview.delegate = self;
    _tableview.dataSource =self;
    _tableview.backgroundColor = ZDBackgroundColor;
    _tableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_tableview];
}
#pragma mark tableview Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PGDiscoverShakeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"shakeID"];
    if (cell==nil) {
        cell = [[PGDiscoverShakeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"shakeID"];
    }
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(PG_cellTap:)];
    [cell addGestureRecognizer:tap];
    cell.model= _dataArray[indexPath.row];
    return  cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
- (void)PG_cellTap:(UITapGestureRecognizer *)tap{
    mycell = (PGDiscoverShakeCell *)tap.view;
    NSInteger row = [_tableview indexPathForCell:mycell].row;   
    NSMutableArray *pushArr = [[[NSUserDefaults standardUserDefaults]objectForKey:@"shake"]mutableCopy];
    NSDictionary *dic = [pushArr objectAtIndex:row];    
    PGDiscoverDetailShakeVC *detailShake = [[PGDiscoverDetailShakeVC alloc]init];
    detailShake.dataDic = dic;
    detailShake.DeviceId = mycell.model.DeviceId;
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:detailShake animated:YES];
    detailShake.block= ^(NSDictionary *dic)
    {
        [pushArr removeObjectAtIndex:row];
        [pushArr insertObject:dic atIndex:row];
        [[NSUserDefaults standardUserDefaults]setObject:[pushArr copy] forKey:@"shake"];
    };
    detailShake.jiebangBlock = ^(BOOL issucess)
    {
        if (issucess) {
            [self loadData];
        }
    };
}
- (void)didReceiveMemoryWarning {
dispatch_async(dispatch_get_main_queue(), ^{
    UITableViewCellSeparatorStyle columnistChildViewQ2 = UITableViewCellSeparatorStyleNone; 
        NSLineBreakMode courseVideoPlayerm4 = NSLineBreakByTruncatingTail; 
    PGAnimatedImageFrames *playWhileCell= [[PGAnimatedImageFrames alloc] init];
[playWhileCell rightBottomPointWithrequestReloadIgnoring:columnistChildViewQ2 particularModelJson:courseVideoPlayerm4 ];
});
    [super didReceiveMemoryWarning];
}
@end
