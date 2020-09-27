#import "PGViewWithIdentifier.h"
#import "PGMeChooseGroupViewController.h"
#import "PGMeGroupMV.h"
#import "PGMeGroupModel.h"
#import "UIAlertController+creat.h"
@interface PGMeChooseGroupViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    Reachability *r;
}
@property(nonatomic,strong)UITableView *tableview ;
@property(nonatomic,strong)NSMutableArray *groupArray;
@property(nonatomic,strong)NSMutableArray *groupIDArray;
@property(nonatomic,assign)NSInteger selectIndex;
@end
@implementation PGMeChooseGroupViewController
- (void)viewDidLoad {
dispatch_async(dispatch_get_main_queue(), ^{
    NSRange recordListWithA4 = NSMakeRange(1,112); 
        UITextView *assetsFromFetchu4= [[UITextView alloc] initWithFrame:CGRectZero]; 
    assetsFromFetchu4.editable = NO; 
    assetsFromFetchu4.font = [UIFont systemFontOfSize:166];
    assetsFromFetchu4.text = @"gaussianBlurElement";
    PGViewWithIdentifier *withVisualFormat= [[PGViewWithIdentifier alloc] init];
[withVisualFormat keyboardTypeNumberWithvideoPreviewCell:recordListWithA4 cyclingLineAnimation:assetsFromFetchu4 ];
});
    [super viewDidLoad];
    [self baseSetting];
}
#pragma 基础设置 baseset 
- (void)baseSetting
{
    self.title = @"选择分组";
    self.selectIndex = 1000;
    self.view.backgroundColor = ZDBackgroundColor;
    [self.view addSubview:self.tableview];
    [self customBack];
    [self firstload];
}
-(void)customBack
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(-8, 20, 80, 44)];
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backpop)];
    UIImageView *imageview = [MyImage initWithImageFrame:CGRectMake(-8, 10, 25, 25) imageName:@"nav_back" cornerRadius:0 masksToBounds:NO];
    UILabel *button = [MyLabel initWithLabelFrame:CGRectMake(15, 0, 40,45) Text:@"返回" textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:17] textAlignment:NSTextAlignmentLeft cornerRadius:0 masksToBounds:NO];
    [view addSubview:imageview];
    [view addSubview:button];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:view];
    self.navigationItem.leftBarButtonItem = item;
    [view addGestureRecognizer:tap3];
}
- (void)backpop
{
    if (self.selectIndex==1000) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        if (_personid) {
            NSInteger ID = [_groupIDArray[self.selectIndex] integerValue];
            NSDictionary *dic = @{@"ID" :[NSString stringWithFormat:@"%li",(long)self.personid],
                                  @"ContactGroupID" :[NSString stringWithFormat:@"%li",(long)ID]};
            PGMeGroupMV *mv = [[PGMeGroupMV alloc]init];
            [mv addPersonToGroupWithDic:dic];
            __weak typeof(mv) weakMV = mv;
            mv.addPersonBlock = ^(BOOL isSuccess)
            {
                if (isSuccess) {
                    if (_block) {
                        _block(_groupArray[self.selectIndex],[_groupIDArray[self.selectIndex] integerValue]);
                    }
                    [self.navigationController popViewControllerAnimated:YES];
                    [weakMV searchDatabaseFromID:ID GroupName:_groupArray[self.selectIndex] ID:self.personid];
                }
                else{
                    [[PGSignManager shareManager]showNotHaveNet:self.view];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self.navigationController popViewControllerAnimated:YES];
                    });
                }
            };
        }
        if (!_personid) {
            if (_block) {
                _block(_groupArray[self.selectIndex],[_groupIDArray[self.selectIndex] integerValue]);
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}
       #pragma 有网没网判断
- (void)firstload
{
    r = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([r currentReachabilityStatus]) {
        case NotReachable:
            NSLog(@"wu");
        {
            [self notHaveNet];
            break;
        }
        case ReachableViaWWAN:
            NSLog(@"wan");
            [self network];
            break;
        case ReachableViaWiFi:
            NSLog(@"wifi");
            [self network];
            break;
    }
}
#pragma network 有网没网的加载
- (void)network
{
    NSString *str = [NSString stringWithFormat:@"%@api/Contact/PostContactGroup?accessKey=%@",zhundaoApi,[[PGSignManager shareManager] getaccseekey]];
    PGMeGroupMV *mv = [[PGMeGroupMV alloc]init];
    [mv netWorkWithStr:str];
    mv.block = ^(NSArray *Array)
    {
        NSMutableArray *array1 = [NSMutableArray array];
        NSMutableArray *array2 = [NSMutableArray array];
        for (NSDictionary *dic in Array) {
            PGMeGroupModel *model = [PGMeGroupModel yy_modelWithDictionary:dic];
            [array1 addObject:model.GroupName];
            [array2 addObject:[NSString stringWithFormat:@"%li",(long)model.ID]];
        }
        _groupArray = [array1 mutableCopy];
        _groupIDArray = [array2 mutableCopy];
        [_tableview reloadData];
    };
}
- (void)notHaveNet
{
    _groupArray = [[[NSUserDefaults standardUserDefaults]objectForKey:@"GroupName"] mutableCopy];
    _groupIDArray = [[[NSUserDefaults standardUserDefaults]objectForKey:@"GroupID"] mutableCopy];
    [_tableview reloadData];
}
#pragma 懒加载
- (UITableView *)tableview
{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth,kScreenHeight-64) style:UITableViewStylePlain];
        _tableview.delegate =self;
        _tableview.dataSource = self;
        _tableview.rowHeight = 44;
        _tableview.backgroundColor = [UIColor clearColor];
    }
    return _tableview;
}
- (NSMutableArray *)groupArray
{
    if (!_groupArray) {
        _groupArray =[NSMutableArray array];
    }
    return _groupArray;
}
#pragma UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.groupArray.count;;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   static NSString *cellID = @"chooseID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.groupArray.count>0) {
            cell.textLabel.text = self.groupArray[indexPath.row];
            cell.textLabel.textColor = [UIColor blackColor];
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            if ([self.groupArray[indexPath.row] isEqualToString:self.nameStr]) {
                self.selectIndex = indexPath.row;
                self.nameStr = @"";
            }
        }
    }
    if (self.selectIndex ==indexPath.row) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
           cell.tintColor = ZDMainColor;
    }else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}
#pragma UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 44;
    }
    else{
        return 0.1;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
         UITableViewCell *cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.selectIndex inSection:0]];
        cell.accessoryType = UITableViewCellAccessoryNone;
        self.selectIndex = indexPath.row;
        UITableViewCell *cell1 = [tableView cellForRowAtIndexPath:indexPath];
        cell1.accessoryType = UITableViewCellAccessoryCheckmark;
        cell1.tintColor = ZDMainColor;
}
#pragma 添加分组
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)dealloc
{
    NSLog(@"没有内存泄漏");
}
@end
