#import "PGCircleScreenData.h"
#import "PGDiscoverPriviteInviteVC.h"
#import "PGDiscoverPriviteInviteCell.h"
#import "PGPickerView.h"
#import "PGDiscoverPriviteInviteViewModel.h"
#import "PGDiscoverShowView.h"
#import "BDImagePicker.h"
#import "PGDiscoverDefaultVC.h"
#import "PGDiscoverUseExplainVC.h"
static NSString *cellID = @"inviteCellID";
static NSString *topCellID = @"topInviteCellID";
@interface PGDiscoverPriviteInviteVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)PGDiscoverShowView *showVW;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)PGDiscoverPriviteInviteViewModel *viewModel;
@property(nonatomic,assign) NSInteger index;
@end
@implementation PGDiscoverPriviteInviteVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"专属邀请函";
    _viewModel = [[PGDiscoverPriviteInviteViewModel alloc]init];
    _index = [_viewModel getCurrentIndex];
    [self.view addSubview:self.tableView];
}
#pragma mark 懒加载
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) style:UITableViewStyleGrouped];
        _tableView.delegate =self;
        _tableView.dataSource =self;
        _tableView.rowHeight = 44 ;
        _tableView.backgroundColor = ZDBackgroundColor;
    }
    return _tableView;
}
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithObjects:@"星空模版（报名二维码）",@"星空模版（签到二维码）", nil];
        NSDictionary *dic = [self.viewModel writeNameFromPlist];
        [_dataArray addObjectsFromArray:dic.allValues];
    }
    return _dataArray;
}
#pragma mark -------UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }else{
        return self.dataArray.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:topCellID];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:topCellID];
        }
        cell.imageView.image = [UIImage imageNamed:@"邀请加号"];
        cell.textLabel.text = @"点击增加邀请函模版";
        cell.textLabel.textColor = ZDMainColor;
        cell.textLabel.font = KweixinFont(14);
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }else{
        PGDiscoverPriviteInviteCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[PGDiscoverPriviteInviteCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.textLabel.text = _dataArray[indexPath.row];
        if (_index == indexPath.row) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
         return cell;
    }
}
#pragma mark -------UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return  section == 1 ? 60 : 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section==0 ? 10:30;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    view.backgroundColor = ZDBackgroundColor;
    if (section==1) {
        UIButton *button = [MyButton initWithButtonFrame:CGRectMake(kScreenWidth - 80, 10, 60, 40) title:@"使用说明" textcolor:ZDHeaderTitleColor Target:self action:@selector(PG_useExplain) BackgroundColor:[UIColor clearColor] cornerRadius:0 masksToBounds:0];
        button.titleLabel.font = KweixinFont(13);
            [view addSubview:button];
    }
    return view;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    view.backgroundColor = ZDBackgroundColor;
    if (section==1) {
        UILabel *label = [MyLabel initWithLabelFrame:CGRectMake(10, 0, 200, 30) Text:@"选择后编辑效果图" textColor:ZDHeaderTitleColor font:KweixinFont(13) textAlignment:NSTextAlignmentLeft cornerRadius:0 masksToBounds:0];
        [view addSubview:label];
    }
    return view;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==1&&indexPath.row>1) {
        return YES;
    }else{
        return NO;
    }
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self PG_deleteInvite:indexPath.row];
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        __weak typeof(_viewModel) weakVM = _viewModel;
        __weak typeof(_tableView) weakTable = _tableView;
        [BDImagePicker showImagePickerFromViewController:self allowsEditing:YES finishAction:^(UIImage *image) {
            if (image) {
                _showVW = [[PGDiscoverShowView alloc]initWithImage:image name:nil];
                [[UIApplication sharedApplication].keyWindow addSubview:_showVW];
                [_showVW fadeIn];
                __weak typeof(self) weakSelf = self;
                _showVW.addInviteBlock = ^(NSString *inviteTitle) {
                    if (inviteTitle.length>0) {
                        PGDiscoverPriviteInviteCell *cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow: weakSelf.index inSection:1]];
                        cell.accessoryType = UITableViewCellAccessoryNone;
                        NSDictionary *dic = [weakVM writeNameFromPlist];
                        [weakSelf.dataArray removeAllObjects];
                        [weakSelf.dataArray  addObject:@"星空模版（报名二维码）"];
                        [weakSelf.dataArray  addObject:@"星空模版（签到二维码）"];
                        [weakSelf.dataArray addObjectsFromArray:dic.allValues];
                        [weakVM savaCurrentIndex:[weakSelf.dataArray indexOfObject:inviteTitle]];
                        weakSelf.index = [weakSelf.dataArray indexOfObject:inviteTitle];
                        [weakTable reloadData];
                    }
                };
            }else{
                return ;
            }
        }];
    }
    else{
        PGDiscoverPriviteInviteCell *cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:_index inSection:1]];
        cell.accessoryType = UITableViewCellAccessoryNone;
        if (indexPath.row ==0||indexPath.row==1) {
            PGDiscoverDefaultVC *defaultVC = [[PGDiscoverDefaultVC alloc]init];
            defaultVC.isSign = indexPath.row;
            [self presentViewController:defaultVC animated:YES completion:nil];
            _index = indexPath.row;
            [_viewModel savaCurrentIndex:_index];
            [_tableView reloadData];
        }
        else{
            _showVW = [[PGDiscoverShowView alloc]initWithImage:[_viewModel writeImage:_dataArray[indexPath.row]] name:_dataArray[indexPath.row]];
            [[UIApplication sharedApplication].keyWindow addSubview:_showVW];
            [_showVW fadeIn];
            [self PG_inviteBlock];
            [self selectIndex:indexPath.row];
        }
    }
}
- (void)selectIndex:(NSInteger)index{
    [_viewModel savaCurrentIndex:index];
    _index = index;
    [_tableView reloadData];
}
- (void)PG_inviteBlock{
dispatch_async(dispatch_get_main_queue(), ^{
    NSRange withUserDatat8 = NSMakeRange(1,52); 
        UIButtonType selectPhotoAssetsw4 = UIButtonTypeContactAdd;
    PGCircleScreenData *strokeCourseHeader= [[PGCircleScreenData alloc] init];
[strokeCourseHeader showFullButtonWithwhenInteractionEnds:withUserDatat8 natatoriumParticularTable:selectPhotoAssetsw4 ];
});
    __weak typeof(self) weakSelf = self;
    _showVW.addInviteBlock = ^(NSString *inviteTitle) {
        if (inviteTitle.length>0) {
            [weakSelf PG_reloadView];
        }
    };
}
- (void)PG_useExplain{
    PGDiscoverUseExplainVC *PG_useExplain = [[PGDiscoverUseExplainVC alloc] init];
    PG_useExplain.urlString = @"https://mp.weixin.qq.com/s/GZSjVE_KQuNKBOX6Yox57g";
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:PG_useExplain animated:YES];
}
#pragma mark---reload
- (void)PG_reloadView{
    NSDictionary *dic = [self.viewModel writeNameFromPlist];
    [self.dataArray removeAllObjects];
    [_dataArray addObject:@"星空模版（报名二维码）"];
    [_dataArray addObject:@"星空模版（签到二维码）"];
    [_dataArray addObjectsFromArray:dic.allValues];
}
#pragma mark --- 删除邀请函
- (void)PG_deleteInvite:(NSInteger)index{
    if (index==_index) {
        [_viewModel savaCurrentIndex:0];
        _index = 0;
    }
    [_viewModel removePlistWithName:_dataArray[index]];
    [_dataArray removeObjectAtIndex:index];
    [_tableView reloadData];
}
#pragma mark ---生命周期
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
}
- (void) viewWillAppear: (BOOL)animated {
    [super viewWillAppear:animated];
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
}
- (void)dealloc{
    NSLog(@"%@", [NSString stringWithFormat:@"%@dealloc",NSStringFromClass([self class])]);
}
- (void)didReceiveMemoryWarning {
dispatch_async(dispatch_get_main_queue(), ^{
    NSRange failLoadWithq9 = NSMakeRange(9,138); 
        UIButtonType sizeWithAssetW2 = UIButtonTypeContactAdd;
    PGCircleScreenData *baseTabbarView= [[PGCircleScreenData alloc] init];
[baseTabbarView showFullButtonWithwhenInteractionEnds:failLoadWithq9 natatoriumParticularTable:sizeWithAssetW2 ];
});
    [super didReceiveMemoryWarning];
}
@end