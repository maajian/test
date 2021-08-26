//
//  FaceDetailViewController.m
//  zhundao
//
//  Created by zhundao on 2017/7/27.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "FaceDetailViewController.h"
#import "FaceDetailTableViewCell.h"
#import "FaceDetailViewModel.h"
#import "AJPickerView.h"
#import "GZActionSheet.h"
@interface FaceDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)FaceDetailViewModel *VM;

@property(nonatomic,strong)NSMutableArray *titleArray;

@property(nonatomic,strong)NSMutableArray *IDArray;

@property(nonatomic,strong)AJPickerView *pickerView ;

@property(nonatomic,strong)NSMutableArray *signTitleArray;

@property(nonatomic,strong)NSMutableArray *signIDArray;

@property(nonatomic,strong)UIProgressView *progressView;

@property(nonatomic,strong)UILabel *progressLabel;
@end

@implementation FaceDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self createRight];
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

- (FaceDetailViewModel *)VM
{
    if (!_VM) {
        _VM = [[FaceDetailViewModel alloc]init];
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
        _progressView.progressTintColor = ZDGreenColor;
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
    FaceDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:FaceDetailID];
    if (!cell) {
        cell = [[FaceDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FaceDetailID];
        
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
    MBProgressHUD *hud = [MyHud initWithAnimationType:MBProgressHUDAnimationFade showAnimated:YES UIView:self.view];
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
    MBProgressHUD *hud1 = [MyHud initWithAnimationType:MBProgressHUDAnimationFade showAnimated:YES UIView:self.view];
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
    
    _pickerView = [[AJPickerView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) dataArray:array currentStr:nil backBlock:^(NSString *str) {
        NSString *idstr = [_signIDArray objectAtIndex:[_signTitleArray indexOfObject:str]];
        [self bindSignWithStr:idstr];
    }];
    [self.view addSubview:_pickerView];
    [_pickerView fadeIn];
}

- (void)showActivityPick:(NSArray *)array
{
    _pickerView = [[AJPickerView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) dataArray:array currentStr:nil backBlock:^(NSString *str) {
        [self signWithStr:str];
    }];
    [self.view addSubview:_pickerView];
    [_pickerView fadeIn];
}

#pragma mark -----绑定签到

- (void)bindSignWithStr:(NSString *)str
{
    [ZDAlertView alertWithTitle:@"同步将消耗一定时间" message:@"是否继续" sureBlock:^{
        dispatch_source_t timer= dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
        dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 2* NSEC_PER_SEC, 0);
        dispatch_source_set_event_handler(timer, ^{
            DDLogVerbose(@"调用了定时器");
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
        MBProgressHUD *hud2 = [MyHud initWithAnimationType:MBProgressHUDAnimationFade showAnimated:YES UIView:self.view];
        hud2.label.text = @"绑定中...";
        [self.VM BindDeviceWithID:str deviceKey:_model.deviceKey bindBlock:^(BOOL isSuccess) {
            [hud2 hideAnimated:YES];
            if (isSuccess) {
                MBProgressHUD *hud3 = [MyHud initWithMode:MBProgressHUDModeCustomView labelText:@"绑定成功" showAnimated:YES UIView:self
                                       .view imageName:@"签到打勾"];
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

- (void)showPost  //sheet显示
{
    NSArray *array = @[@"全部同步"];
    GZActionSheet *sheet = [[GZActionSheet alloc]initWithTitleArray:array WithRedIndex:5 andShowCancel:YES];
    // 2. Block 方式
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
    maskLabel *label = [[maskLabel alloc]initWithTitle:str];
    [label labelAnimationWithViewlong:self.view];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (_pickerView) {
        _pickerView = nil;
    }
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
