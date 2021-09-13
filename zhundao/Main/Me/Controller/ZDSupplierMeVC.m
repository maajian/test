//
//  ZDSupplierMeVC.m
//  zhundao
//
//  Created by maj on 2021/9/2.
//  Copyright © 2021 zhundao. All rights reserved.
//

#import "ZDSupplierMeVC.h"

#import "ZDSupplierMeCell.h"

#import "ZDSupplierMeModel.h"

@interface ZDSupplierMeVC ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation ZDSupplierMeVC
ZDGetter_MutableArray(dataSource)

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSet];
    [self initLayout];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self networkForGetInfo];
}

#pragma mark --- Init
- (void)initSet {
    self.navigationItem.title = @"我";
    [self.view addSubview:self.tableView];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem backImageItemWithTarget:self action:@selector(popBack)];
    if(ZD_UserM.identifierType == ZDIdentifierTypeSupplier)  {
        self.navigationItem.rightBarButtonItem = [UIBarButtonItem textBarButtonItemWithText:@"当前身份:供应商" color:ZDGrayColor2 Target:self action:nil];
    } else {
        self.navigationItem.rightBarButtonItem = [UIBarButtonItem textBarButtonItemWithText:@"当前身份:会务公司" color:ZDGrayColor2 Target:self action:nil];
    }
}
- (void)initLayout {
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}

#pragma mark --- network
- (void)networkForGetInfo {
    ZD_WeakSelf
    if (ZD_UserM.identifierType == ZDIdentifierTypeSupplier) {
        NSString *url = @"https://settlement.zhundaoyun.com/api/supplier/get_supplier_info";
        [ZDNetWorkManager.shareHTTPSessionManager.requestSerializer setValue:ZD_UserM.supplier_access_token forHTTPHeaderField:@"supplier_access_token"];
        [ZD_NetWorkM getDataWithMethod:url parameters:nil succ:^(NSDictionary *obj) {
            if ([obj[@"code"] integerValue] == 0) {
                ZDSupplierMeModel *model = [ZDSupplierMeModel yy_modelWithJSON:obj[@"data"]];
                [weakSelf.dataSource addObject:model];
                [weakSelf.tableView reloadData];
            } else {
                ZD_HUD_SHOW_ERROR_STATUS(obj[@"msg"])
            }
        } fail:^(NSError *error) {
            ZD_HUD_SHOW_ERROR(error);
        }];
    } else {
        NSString *url = @"https://corp.zhundaoyun.com/api/get_user_info";
        [ZDNetWorkManager.shareHTTPSessionManager.requestSerializer setValue:ZD_UserM.supplierMeModel.access_token forHTTPHeaderField:@"access_token"];
        [ZD_NetWorkM getDataWithMethod:url parameters:nil succ:^(NSDictionary *obj) {
            if ([obj[@"code"] integerValue] == 0) {
                ZDSupplierMeModel *model = [[ZDSupplierMeModel alloc] initWithConferenceInfoDic:obj[@"data"]];
                [weakSelf.dataSource addObject:model];
                [weakSelf.tableView reloadData];
            } else {
                ZD_HUD_SHOW_ERROR_STATUS(obj[@"msg"])
            }
        } fail:^(NSError *error) {
            ZD_HUD_SHOW_ERROR(error);
        }];
    }
}

#pragma mark --- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZDSupplierMeCell *cell = [tableView dequeueReusableCellWithIdentifier:ZD_ClassName([ZDSupplierMeCell class])];
    ZDSupplierMeModel *model = self.dataSource[indexPath.row];
    cell.model = model;
    return cell;
}

#pragma mark --- UITableViewDelegate

#pragma mark --- Lazyload
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.rowHeight = 70;
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
        [_tableView registerClass:[ZDSupplierMeCell class] forCellReuseIdentifier:ZD_ClassName([ZDSupplierMeCell class])];
    }
    return _tableView;
}

#pragma mark --- Action
- (void)popBack {
    ZD_UserM.identifierType = ZDIdentifierTypeSponsor;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ZDMainSupplierTabbarPop" object:nil];
}

@end
