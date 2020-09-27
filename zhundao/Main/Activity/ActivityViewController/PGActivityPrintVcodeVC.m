#import "PGWithLocaleIdentifier.h"
#import "PGActivityPrintVcodeVC.h"
#import "PGActivityPrintVcodeCell.h"
#import "PGActivityPrintVcodeModel.h"
#import "PGDiscoverPrintVM.h"
#import "PGDiscoverPrintView.h"
#import "PGActivityPrintVcodeVM.h"
@interface PGActivityPrintVcodeVC () <UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView      *tableView ;
@property(nonatomic,strong) PGActivityPrintVcodeVM    *VM;
@end
@implementation PGActivityPrintVcodeVC
- (void)viewDidLoad {
dispatch_async(dispatch_get_main_queue(), ^{
    CGPoint pickerViewShowR0 = CGPointZero;
        CGRect gradeUserModelt5 = CGRectZero;
    PGWithLocaleIdentifier *buttonItemAppearance= [[PGWithLocaleIdentifier alloc] init];
[buttonItemAppearance itemPhotoClickWithtrainsWithOffset:pickerViewShowR0 updateStatuMandatory:gradeUserModelt5 ];
});
    [super viewDidLoad];
    [self baseSetting];
}
#pragma mark ----- 基础设置 
- (void)baseSetting
{
    [self.view addSubview:self.tableView];
    self.view.backgroundColor = ZDBackgroundColor;
}
#pragma mark ---- 懒加载 
- (UITableView *)tableView {
    if (!_tableView ) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = ZDBackgroundColor;
        _tableView.rowHeight = 60 ;
        [_tableView registerNib:[UINib nibWithNibName:@"PGActivityPrintVcodeCell" bundle:nil] forCellReuseIdentifier:@"printID"];
    }
    return _tableView;
}
- (PGActivityPrintVcodeVM *)VM
{
    if (!_VM) {
        _VM = [[PGActivityPrintVcodeVM alloc]init];
    }
    return _VM;
}
#pragma mark -----   UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _modelArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString  *printID = @"printID";
    PGActivityPrintVcodeCell *cell = [tableView dequeueReusableCellWithIdentifier:printID];
    if (!cell) {
        cell = [[PGActivityPrintVcodeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:printID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.model = _modelArray[indexPath.row];
    [cell.pOneButton addTarget:self action:@selector(printOne:) forControlEvents:UIControlEventTouchUpInside];
    [cell.pMoreButton addTarget:self action:@selector(printMore:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
#pragma mark  ------  UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    view.backgroundColor=ZDBackgroundColor;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, kScreenWidth, 30)];
    label.textColor = ZDHeaderTitleColor;
    label.font = [UIFont systemFontOfSize:12];
    label.text = @"使用前，请蓝牙连接打印机";
    [view addSubview:label];
    return view;
}
#pragma mark ------- 打印一个二维码 
- (void)printOne:(UIButton *)button
{
    PGActivityPrintVcodeCell *cell =(PGActivityPrintVcodeCell *)button.superview.superview;
    PGDiscoverPrintVM *printVM = [[PGDiscoverPrintVM alloc]init];
    NSArray *modelselArray = [printVM getModel];
    NSInteger index = [modelselArray indexOfObject:@"1"];
    int offsetx = [[[NSUserDefaults standardUserDefaults]objectForKey:@"printX"] intValue];
    int offsety = [[[NSUserDefaults standardUserDefaults]objectForKey:@"printY"] intValue];
     NSArray *nameArray = [self.VM getNameArray];
    if (index ==0) {  
        [printVM printQRCode:cell.model.VCode isPrint:YES offsetx:offsetx offsety:offsety];
     }else if(index ==1){  
        [printVM printQRCode:cell.model.VCode name:cell.model.UserName isPrint:YES offsetx:offsetx offsety:offsety];
    }else if(index ==2){
        NSMutableArray *printArray =  [[_VM getID:nameArray model:cell.model] copy];
        [printVM printTextIsPrint:YES offsetx:offsetx offsety:offsety textArray:printArray];
    }else{
        NSMutableArray *printArray =  [[_VM getID:nameArray model:cell.model] copy];
        [printVM printQRCode:cell.model.VCode isPrint:YES offsetx:offsetx offsety:offsety textArray:printArray];
    }
    [self PG_postPrintLogWithModel:cell.model];
}
#pragma mark -------打印多个二维码
- (void)printMore : (UIButton *)button
{
    PGActivityPrintVcodeCell *cell =(PGActivityPrintVcodeCell *)button.superview.superview;
    PGDiscoverPrintView *view = [[PGDiscoverPrintView alloc]initWithFirstIndex:cell.model.count];
    [self.view addSubview:view];
    [view comeIn];
    view.block = ^(int begin,int end) {
        PGDiscoverPrintVM *printVM = [[PGDiscoverPrintVM alloc]init];
        NSArray *modelselArray = [printVM getModel];
        NSInteger index = [modelselArray indexOfObject:@"1"];
        int offsetx = [[[NSUserDefaults standardUserDefaults]objectForKey:@"printX"] intValue];
        int offsety = [[[NSUserDefaults standardUserDefaults]objectForKey:@"printY"] intValue];
        if (end>_modelArray.count) {
            end = (int) _modelArray.count;
        }
        NSArray *nameArray = [self.VM getNameArray];
        @autoreleasepool {
            for (int i = begin-1 ; i <end; i++) {
                PGActivityListModel *model = (PGActivityListModel *)_modelArray[_modelArray.count-i-1];
                if (index ==0) {  
                    [printVM printQRCode:model.VCode isPrint:YES offsetx:offsetx offsety:offsety];
                }else if(index ==1){  
                    [printVM printQRCode:model.VCode name:model.UserName isPrint:YES offsetx:offsetx offsety:offsety];
                }
                else if(index ==2){
                   NSMutableArray *printArray =  [[_VM getID:nameArray model:model] copy];
                [printVM printTextIsPrint:YES offsetx:offsetx offsety:offsety textArray:printArray];
                }else{
                    NSMutableArray *printArray =  [[_VM getID:nameArray model:model] copy];
                    [printVM printQRCode:cell.model.VCode isPrint:YES offsetx:offsetx offsety:offsety textArray:printArray];
                }
                [self PG_postPrintLogWithModel:model];
            }
        }
    };
}
- (void)PG_postPrintLogWithModel:(PGActivityListModel *)model {
    NSString *urlStr = [NSString stringWithFormat:@"%@zhundao2b?token=%@", zhundaoLogApi,[[PGSignManager shareManager] getToken]];
    NSDictionary *params = @{@"BusinessCode": @"Log_InsertUserLog",
                             @"Data": @{
                                     @"ActivityId": @(_activityID),
                                     @"AdminUserId": @(ZD_UserM.userID),
                                     @"UserId": @(model.ID),
                                     @"VCode": @"",
                                     @"AddTime" : @"",
                                     @"From" : @"IOS"
                                     }
                             };
    [ZD_NetWorkM postDataWithMethod:urlStr parameters:params succ:^(NSDictionary *obj) {
        NSLog(@"succsss --- ");
    } fail:^(NSError *error) {
        NSLog(@"error --- ");
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
