//
//  ZDActivityAdminMarkVC.m
//  zhundao
//
//  Created by maj on 2021/1/8.
//  Copyright © 2021 zhundao. All rights reserved.
//

#import "ZDActivityAdminMarkVC.h"

#import "ZDActivityAdminMarkCell.h"

#import "ZDActivityAdminMarkModel.h"

@interface ZDActivityAdminMarkVC ()<UITableViewDataSource, UITableViewDelegate, ZDActivityAdminMarkCellDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<ZDActivityAdminMarkModel *> *dataSource;

@end

@implementation ZDActivityAdminMarkVC
ZDGetter_MutableArray(dataSource)

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSet];
    [self initLayout];
    self.view.backgroundColor = ZDBackgroundColor;
}

#pragma mark --- Lazyload
// 列表
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kTopBarHeight ) style:UITableViewStylePlain];
        [_tableView registerClass:[ZDActivityAdminMarkCell class] forCellReuseIdentifier:ZD_ClassName([ZDActivityAdminMarkCell class])];
        _tableView.rowHeight = 44;
        _tableView.backgroundColor = ZDBackgroundColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [UIView new];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

#pragma mark --- init
- (void)initSet {
    self.title = @"管理员备注";
    [self.view addSubview:self.tableView];
    
    ZDActivityAdminMarkModel *markModel = [ZDActivityAdminMarkModel markModelWithDic:self.dataDic];
    ZDActivityAdminMarkModel *guestTypeModel = [ZDActivityAdminMarkModel guestTypeModelWithDic:self.dataDic];
    ZDActivityAdminMarkModel *roomModel = [ZDActivityAdminMarkModel roomModelWithDic:self.dataDic];
    ZDActivityAdminMarkModel *seatModel = [ZDActivityAdminMarkModel seatModelWithDic:self.dataDic];
    ZDActivityAdminMarkModel *saveModel = [ZDActivityAdminMarkModel saveModel];
    [self.dataSource addObjectsFromArray:@[markModel, guestTypeModel, roomModel, seatModel, saveModel]];
    
    [self.tableView reloadData];
}
- (void)initLayout {
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

#pragma mark --- UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

#pragma mark --- UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZDActivityAdminMarkCell *cell = [tableView dequeueReusableCellWithIdentifier:ZD_ClassName([ZDActivityAdminMarkCell class])];
    cell.model = self.dataSource[indexPath.section];
    cell.activityAdminMarkCellDelegate = self;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZDActivityAdminMarkModel *model = self.dataSource[indexPath.section];
    return model.type == ZDAdminMarkTypeMark ? 100 : 60;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    ZDActivityAdminMarkModel *model = self.dataSource[section];
    if (model.type == ZDAdminMarkTypeSave) {
        return 30;
    } else {
        return [UIView heightForHeaderFooterTitle:model.headerTitle labelMargin:16];
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    ZDActivityAdminMarkModel *model = self.dataSource[section];
    if (model.type == ZDAdminMarkTypeSave) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
        view.backgroundColor = ZDBackgroundColor;
        return view;
    } else {
        return [UIView viewWithHeaderFooterTitle:model.headerTitle labelMargin:16 alignment:NSTextAlignmentLeft];
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

#pragma mark --- ZDActivityAdminMarkCellDelegate
- (void)activityAdminMarkCell:(ZDActivityAdminMarkCell *)activityAdminMarkCell didTapSaveButton:(UIButton *)saveButton {
    [self networkForSaveData];
}

#pragma mark --- network
- (void)networkForSaveData {
    [self.view endEditing:YES];
    ZD_WeakSelf
    NSString *str = [NSString stringWithFormat:@"%@api/v2/activity/updateActivityListAdmin?token=%@&from=ios",zhundaoApi,[[SignManager shareManager] getToken]];
    NSDictionary *params = @{@"AdminRemark": ZD_SafeStringValue(self.dataSource.firstObject.content),
                          @"GuestType": ZD_SafeStringValue(self.dataSource[1].content),
                          @"Room": ZD_SafeStringValue(self.dataSource[2].content),
                          @"Seat": ZD_SafeStringValue(self.dataSource[3].content),
                          @"ID": ZD_SafeStringValue(self.dataDic[@"ID"]),
    };
    [ZD_NetWorkM postDataWithMethod:str parameters:params succ:^(NSDictionary *obj) {
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:obj];
        if ([dic[@"res"] boolValue]) {
            self.dataDic[@"AdminRemark"] = params[@"AdminRemark"];
            self.dataDic[@"GuestType"] = params[@"GuestType"];
            self.dataDic[@"Room"] = params[@"Room"];
            self.dataDic[@"Seat"] = params[@"Seat"];
            ZD_HUD_SHOW_TOAST(@"设置成功");
            [weakSelf.navigationController popViewControllerAnimated:YES];
        } else {
            ZD_HUD_SHOW_TOAST(@"设置失败");
        }
    } fail:^(NSError *error) {
        ZD_HUD_SHOW_TOAST(@"请检查网络设置");
    }];
}

@end
