#import "PGAlbumPickerController.h"
#import "PGDiscoverFaceDetailVC.h"
#import "PGDiscoverFaceDetailCell.h"
#import "PGDiscoverFaceDetailViewModel.h"
#import "PGPickerView.h"
#import "GZActionSheet.h"
@interface PGDiscoverFaceDetailVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)PGDiscoverFaceDetailViewModel *VM;
@property(nonatomic,strong)NSMutableArray *titleArray;
@property(nonatomic,strong)NSMutableArray *IDArray;
@property(nonatomic,strong)PGPickerView *pickerView ;
@property(nonatomic,strong)NSMutableArray *signTitleArray;
@property(nonatomic,strong)NSMutableArray *signIDArray;
@property(nonatomic,strong)UIProgressView *progressView;
@property(nonatomic,strong)UILabel *progressLabel;
@end
@implementation PGDiscoverFaceDetailVC
- (void)viewDidLoad {
dispatch_async(dispatch_get_main_queue(), ^{
    NSMutableArray *videoCameraInterfacem0= [NSMutableArray arrayWithCapacity:0];
        UITableViewStyle reusableSupplementaryViewg7 = UITableViewStylePlain; 
    PGAlbumPickerController *zoneWithAbbreviation= [[PGAlbumPickerController alloc] init];
[zoneWithAbbreviation routeSearchResponseWithshareImageObject:videoCameraInterfacem0 orderStepView:reusableSupplementaryViewg7 ];
});
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self createRight];
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
- (PGDiscoverFaceDetailViewModel *)VM
{
    if (!_VM) {
        _VM = [[PGDiscoverFaceDetailViewModel alloc]init];
    }
    return _VM;
}
- (NSMutableArray *)signIDArray
{
    if (!_signIDArray) {
        _signIDArray = [NSMutableArray array];
    }
    return _signIDArray;
}
- (NSMutableArray *)signTitleArray
{
    if (!_signTitleArray) {
        _signTitleArray = [NSMutableArray array];
    }
    return _signTitleArray;
}
- (UIProgressView *)progressView{
    if (!_progressView) {
        _progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(5, 3, kScreenWidth-10, 5)];
        _progressView.progressViewStyle = UIProgressViewStyleDefault;
        _progressView.trackTintColor = [UIColor lightGrayColor];
        _progressView.progressTintColor = ZDMainColor;
        [_progressView setProgress:0.0 animated:YES];
    }
    return _progressView;
}
-(UILabel *)progressLabel{
    if (!_progressLabel) {
        _progressLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 6, kScreenWidth-10, 20)];
        _progressLabel.textAlignment = NSTextAlignmentCenter;
        _progressLabel.font = [UIFont systemFontOfSize:11];
    }
    return _progressLabel;
}
#pragma mark -------UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *FaceDetailID = @"FaceDetailID";
    PGDiscoverFaceDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:FaceDetailID];
    if (!cell) {
        cell = [[PGDiscoverFaceDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FaceDetailID];
    }
    cell.tag = indexPath.row;
    cell.model = self.model;
    if (indexPath.row==3){
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(activity)];
        [cell addGestureRecognizer:tap];
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}
#pragma mark -------UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}
#pragma mark ------选择活动和签到
- (void)activity
{
    __weak typeof(self) weakSelf = self;
    [self.titleArray removeAllObjects];
    [self.IDArray removeAllObjects];
    MBProgressHUD *hud = [PGMyHud initWithAnimationType:MBProgressHUDAnimationFade showAnimated:YES UIView:self.view];
    [self.VM activityListDataWithBlock:^(NSArray *titleArray, NSArray *IDArray) {
        [hud hideAnimated:YES];
            _titleArray = [titleArray mutableCopy];
            _IDArray = [IDArray mutableCopy];
        if (_titleArray.count==0) {
            [self showMaskWithTitle:@"请先创建人脸活动"];
        }else{
            [weakSelf showActivityPick:titleArray];
        }
    }];
}
- (void)signWithStr :(NSString *)str
{
    [self.signIDArray removeAllObjects];
    [self.signTitleArray removeAllObjects];
    NSString *acid = [_IDArray objectAtIndex:[_titleArray indexOfObject:str]];
    NSDictionary *dic = @{@"Type":@"0",
                          @"pageSize":@"1000",
                          @"curPage":@"1",
                          @"ID":acid};
    MBProgressHUD *hud1 = [PGMyHud initWithAnimationType:MBProgressHUDAnimationFade showAnimated:YES UIView:self.view];
    [_VM signListDataWithdic:dic Block:^(NSArray *array) {
        [hud1 hideAnimated:YES];
        if (array.count==0) {
            [self showMaskWithTitle:@"该活动没有签到"];
        }else{
            for (NSDictionary *datadic in array) {
                [self.signTitleArray addObject:datadic[@"Name"]];
                [self.signIDArray addObject:datadic[@"ID"]];
            }
            [self showSignPick:self.signTitleArray];
        }
    }];
}
- (void)showSignPick:(NSArray *)array
{
    _pickerView = [[PGPickerView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) dataArray:array currentStr:nil backBlock:^(NSString *str) {
        NSString *idstr = [_signIDArray objectAtIndex:[_signTitleArray indexOfObject:str]];
        [self bindSignWithStr:idstr];
    }];
    [self.view addSubview:_pickerView];
    [_pickerView fadeIn];
}
- (void)showActivityPick:(NSArray *)array
{
    _pickerView = [[PGPickerView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) dataArray:array currentStr:nil backBlock:^(NSString *str) {
        [self signWithStr:str];
    }];
    [self.view addSubview:_pickerView];
    [_pickerView fadeIn];
}
#pragma mark -----绑定签到
- (void)bindSignWithStr:(NSString *)str
{
    [PGAlertView alertWithTitle:@"同步将消耗一定时间" message:@"是否继续" sureBlock:^{
        dispatch_source_t timer= dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
        dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 2* NSEC_PER_SEC, 0);
        dispatch_source_set_event_handler(timer, ^{
            NSLog(@"调用了定时器");
            [self.VM getProgressWithDeviceKey:_model.deviceKey progressBlock:^(NSInteger index, NSInteger total) {
                float status  = (float) index/total;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.progressView setProgress:status animated:YES];
                    self.progressLabel.text = [NSString stringWithFormat:@"同步%.1f%%",status*100];
                    if (index ==total) {
                        dispatch_source_cancel(timer);
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [_progressLabel removeFromSuperview];
                            [_progressView removeFromSuperview];
                        });
                    }
                });
            }];
        });
        dispatch_resume(timer);
        [self.view addSubview:self.progressLabel];
        [self.view addSubview:self.progressView];
        MBProgressHUD *hud2 = [PGMyHud initWithAnimationType:MBProgressHUDAnimationFade showAnimated:YES UIView:self.view];
        hud2.label.text = @"绑定中...";
        [self.VM BindDeviceWithID:str deviceKey:_model.deviceKey bindBlock:^(BOOL isSuccess) {
            [hud2 hideAnimated:YES];
            if (isSuccess) {
                MBProgressHUD *hud3 = [PGMyHud initWithMode:MBProgressHUDModeCustomView labelText:@"绑定成功" showAnimated:YES UIView:self
                                       .view imageName:@"img_public_signin_check"];
                [hud3 hideAnimated:YES afterDelay:1.5];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:YES];
                    _faceBlock(1);
                });
            }else{
                [self showMaskWithTitle:@"绑定失败"];
                if (timer) {
                    dispatch_source_cancel(timer);
                    [_progressLabel removeFromSuperview];
                    [_progressView removeFromSuperview];
                }
            }
        }];
    } cancelBlock:^{
    }];
}
#pragma mark ----右上角更多
- (void)createRight
{
    [UIButton initCreateButtonWithFrame:CGRectMake(0, 0, 25, 25) WithImageName:@"nav_more" Withtarget:self Selector:@selector(showPost)];
}
- (void)showPost  
{
    NSArray *array = @[@"全部同步"];
    GZActionSheet *sheet = [[GZActionSheet alloc]initWithTitleArray:array WithRedIndex:5 andShowCancel:YES];
    __weak typeof(self) weakSelf = self;
    sheet.ClickIndex = ^(NSInteger index){
        if (index==1) {
            [weakSelf bindSignWithStr:[NSString stringWithFormat:@"%li",(long)_model.checkInId]];
        }
    };
    [self.view.window addSubview:sheet];
}
- (void)showMaskWithTitle :(NSString *)str
{
    PGMaskLabel *label = [[PGMaskLabel alloc]initWithTitle:str];
    [label labelAnimationWithViewlong:self.view];
}
- (void)viewWillDisappear:(BOOL)animated{
dispatch_async(dispatch_get_main_queue(), ^{
    NSMutableArray *textAlignmentCenterK7= [NSMutableArray arrayWithCapacity:0];
        UITableViewStyle dailyTrainChapterU7 = UITableViewStylePlain; 
    PGAlbumPickerController *cellWithIndex= [[PGAlbumPickerController alloc] init];
[cellWithIndex routeSearchResponseWithshareImageObject:textAlignmentCenterK7 orderStepView:dailyTrainChapterU7 ];
});
    [super viewWillDisappear:animated];
    if (_pickerView) {
        _pickerView = nil;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end