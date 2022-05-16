//
//  ZDActivityMoreChioceVC.m
//  zhundao
//
//  Created by maj on 2021/3/30.
//  Copyright © 2021 zhundao. All rights reserved.
//

#import "ZDActivityMoreChioceVC.h"

#import "ZDActivityMoreChioceVC+MoveItem.h"
#import "ZDActivityMoreChioceCell.h"
#import "ZDActivityMoreChioceOptionCell.h"
#import "ZDActivityMoreChioceSuccessCell.h"
#import "BDImagePicker.h"
#import "NewOrEditMV.h"

@interface ZDActivityMoreChioceVC ()<UITableViewDataSource, UITableViewDelegate, ZDActivityMoreChioceCellDelegate, ZDActivityMoreChioceSuccessCellDelegate>
@property (nonatomic, copy) NSString *imageUrl; // 分享图片URL
@property (nonatomic, assign) BOOL alert;
@property (nonatomic, assign) NSInteger showList;
@property (nonatomic, assign) BOOL isEditActivity; // 是否是编辑活动，不是发起活动
@property (nonatomic, assign) BOOL expand; // 是否展开
@property (nonatomic, strong) ZDActivityConfigModel *configModel;

@property (nonatomic, copy) ZDChioceBlock chioceBlock;

@end

@implementation ZDActivityMoreChioceVC
ZDGetter_MutableArray(dataSource)

- (instancetype)initWithImageUrl:(NSString *)imageUrl
                           alert:(BOOL)alert
                        showList:(NSInteger)showList
                  isEditActivity:(BOOL)isEditActivity
                     configModel:(ZDActivityConfigModel *)configModel
                     chioceBlock:(nonnull ZDChioceBlock)chioceBlock {
    if (self = [super init]) {
        self.imageUrl = imageUrl;
        self.alert = alert;
        self.showList = showList;
        self.chioceBlock = chioceBlock;
        _configModel = configModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSet];
    [self initLayout];
}

#pragma mark --- initSet
- (void)initSet {
    self.title = @"更多选项";
    ZDActivityMoreChioceModel *imageModel = [ZDActivityMoreChioceModel imageModelWithUrl:self.imageUrl];
    ZDActivityMoreChioceModel *optionModel = [ZDActivityMoreChioceModel optionModel];
    optionModel.optionType = ZDActivityOptionTypeUser;
    ZDActivityMoreChioceModel *alertModel = [ZDActivityMoreChioceModel alertModel:self.alert];
    ZDActivityMoreChioceModel *showListModel = [ZDActivityMoreChioceModel showListModel:self.showList];
    ZDActivityMoreChioceModel *successModel = [ZDActivityMoreChioceModel successModel:self.configModel.ad.adtype];
    if (ZD_UserM.gradeId >= 3) {
        [self.dataSource addObjectsFromArray:@[imageModel, optionModel, alertModel, showListModel, successModel]];
    } else {
        [self.dataSource addObjectsFromArray:@[imageModel, optionModel, alertModel, showListModel]];
    }
    [self.view addSubview:self.tableView];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem cancelTextItemWithTarget:self action:@selector(popAction:)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem saveText2ItemWithTarget:self action:@selector(saveAction:)];
    [self addlongPressToMoveGes];
}
- (void)initLayout {
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}

#pragma mark --- UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    ZDActivityMoreChioceModel *model = self.dataSource[section];
    if (model.optionType == ZDActivityOptionTypeUser) {
        return model.userInfoOptionArray.count + 1;
    } else if (model.optionType == ZDActivityOptionTypeExtra) {
        return model.extraInfoOptionArray.count;
    } else {
        return 1;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZDActivityMoreChioceModel *model = self.dataSource[indexPath.section];
    if ((model.optionType == ZDActivityOptionTypeUser && indexPath.row != 0) || model.optionType == ZDActivityOptionTypeExtra) {
        ZDActivityMoreChioceOptionCell *cell = [tableView dequeueReusableCellWithIdentifier:ZD_ClassName(ZDActivityMoreChioceOptionCell)];
        if (model.optionType == ZDActivityOptionTypeUser) {
            cell.model = model.userInfoOptionArray[indexPath.row - 1];
        } else {
            cell.model = model.extraInfoOptionArray[indexPath.row];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else if (model.moreChioceType == ZDActivityMoreChioceTypeSuccess) {
        ZDActivityMoreChioceSuccessCell *cell = [tableView dequeueReusableCellWithIdentifier:ZD_ClassName([ZDActivityMoreChioceSuccessCell class])];
        cell.adModel = self.configModel.ad;
        cell.activityMoreChioceSuccessCellDelegate = self;
        return cell;
    } else {
        ZDActivityMoreChioceCell *cell = [tableView dequeueReusableCellWithIdentifier:ZD_ClassName(ZDActivityMoreChioceCell)];
        cell.moreChioceCellDelegate = self;
        cell.model = self.dataSource[indexPath.section];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

#pragma mark --- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZDActivityMoreChioceModel *model = self.dataSource[indexPath.section];
    if (model.moreChioceType == ZDActivityMoreChioceTypeSuccess) {
        if (self.configModel.ad.adtype == ZDActivityADTypeNone) {
            return 44;
        } else if (self.configModel.ad.adtype == ZDActivityADTypeImage) {
            return 140;
        } else {
            return 110;
        }
    } else if (model.moreChioceType == ZDActivityMoreChioceTypeImage) {
        return 120;
    } else {
        return 44;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    ZDActivityMoreChioceModel *model = self.dataSource[section];
    return model.optionType == ZDActivityOptionTypeExtra ? 10 : 34;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    ZDActivityMoreChioceModel *model = self.dataSource[section];
    if (model.optionType == ZDActivityOptionTypeExtra) {
        return [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    } else {
        ZDActivityMoreChioceModel *model = self.dataSource[section];
        UIView *view = [UIView viewWithHeaderFooterTitle:model.headerStr labelMargin:16 alignment:NSTextAlignmentLeft];
        view.backgroundColor = [UIColor clearColor];
        return view;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZDActivityMoreChioceModel *model = self.dataSource[indexPath.section];
    if (model.moreChioceType == ZDActivityMoreChioceTypeShowList) {
        [self selectShowList:model];
    } else if (model.optionType == ZDActivityOptionTypeUser && indexPath.row == 0) {
        [self expandAction:self.expand];
    } else if (model.optionType == ZDActivityOptionTypeUser && indexPath.row != 0) {
        ZDActivityOptionModel *optionModel = model.userInfoOptionArray[indexPath.row - 1];
        // 姓名和手机默认选择 无法修改
        if ([optionModel.Title isEqualToString:@"姓名"] || [optionModel.Title isEqualToString:@"手机"]) {
            return;
        }
        optionModel.IsCheck = !optionModel.IsCheck;
        [self.tableView reloadData];
    } else if (model.optionType == ZDActivityOptionTypeExtra) {
        ZDActivityOptionModel *optionModel = model.extraInfoOptionArray[indexPath.row];
        optionModel.IsCheck = !optionModel.IsCheck;
        [self.tableView reloadData];
    } else if (model.moreChioceType == ZDActivityMoreChioceTypeSuccess) {
        [self selectSuccessSetList];
    }
}

#pragma mark --- ZDActivityMoreChioceCellDelegate
- (void)moreChioceCell:(ZDActivityMoreChioceCell *)moreChioceCell didChangeAlertSwitch:(UISwitch *)alertSwitch {
    [self.tableView reloadData];
}
- (void)moreChioceCell:(ZDActivityMoreChioceCell *)moreChioceCell didChangeImage:(UIImageView *)addImageView {
    [BDImagePicker showImagePickerFromViewController:self allowsEditing:YES finishAction:^(UIImage *image) {
        if (image) {
            ZD_HUD_SHOW_WAITING
            [NewOrEditMV changeToNetImage:image block:^(NSString *str) {
                ZD_HUD_DISMISS
                moreChioceCell.model.imageUrl = str;
                [self.tableView reloadData];
            }];
        }
    }];
}

#pragma mark --- ZDActivityMoreChioceSuccessCellDelegate
- (void)ZDActivityMoreChioceSuccessCellSelectImage:(ZDActivityMoreChioceSuccessCell *)successCell {
    [BDImagePicker showImagePickerFromViewController:self allowsEditing:YES finishAction:^(UIImage *image) {
        if (image) {
            ZD_HUD_SHOW_WAITING
            [NewOrEditMV changeToNetImage:image block:^(NSString *str) {
                ZD_HUD_DISMISS
                self.configModel.ad.adurl = str;
                [self.tableView reloadData];
            }];
        }
    }];
}

#pragma mark --- Action
- (void)popAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)saveAction:(id)sender {
    if (ZD_UserM.gradeId >= 3) {
        if (self.configModel.ad.adtype == ZDActivityADTypeLink) {
            if (![self.configModel.ad.adurl containsString:@"http://"] && ![self.configModel.ad.adurl containsString:@"https://"]) {
                ZD_HUD_SHOW_ERROR_STATUS(@"报名成功后设置： 请填写正确的跳转地址!")
                return;
            }
        } else if (self.configModel.ad.adtype == ZDActivityADTypeImage && !self.configModel.ad.adimg.length) {
            ZD_HUD_SHOW_ERROR_STATUS(@"报名成功后设置： 缺少图片!")
            return;
        }
    }
    ZD_WeakSelf
    if (self.chioceBlock) {
        // 获取对象
        __block ZDActivityMoreChioceModel *imageModel, *alertModel, *showListModel;
        [self.dataSource enumerateObjectsUsingBlock:^(ZDActivityMoreChioceModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.moreChioceType == ZDActivityMoreChioceTypeImage) {
                imageModel = obj;
            } else if (obj.moreChioceType == ZDActivityMoreChioceTypeAlert) {
                alertModel = obj;
            } else if (obj.moreChioceType == ZDActivityMoreChioceTypeShowList) {
                showListModel = obj;
            }
        }];
        
        self.chioceBlock(imageModel.imageUrl,
                         self.userInfoOptionArray,
                         self.extraInfoOptionArray,
                         alertModel.isAlert,
                         showListModel ? showListModel.showListType : ZDActivityShowListTypeNone );
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        });
    }
}
// 选择
- (void)selectShowList:(ZDActivityMoreChioceModel *)model {
    [AJAlertSheet showWithArray:@[@"显示人数和头像姓名职位公司",@"显示人数和头像姓名", @"显示人数和头像昵称", @"显示人数", @"隐藏"] title:@"报名名单设置" isDelete:NO selectBlock:^(NSInteger index) {
        if (index == 0) {
            model.showListType = 4;
        } else if (index == 1) {
            model.showListType = 3;
        } else if (index == 2) {
            model.showListType = 0;
        } else if (index == 2) {
            model.showListType = 1;
        } else {
            model.showListType = 2;
        }
        [self.tableView reloadData];
    }];
}
// 报名成功后设置
- (void)selectSuccessSetList {
    [AJAlertSheet showWithArray:@[@"系统默认",@"跳转链接", @"显示图片(如微信群二维码)"] title:@"报名成功后设置" isDelete:NO selectBlock:^(NSInteger index) {
        if (index == 0) {
            self.configModel.ad.adtype = ZDActivityADTypeNone;
        } else if (index == 1) {
            self.configModel.ad.adtype = ZDActivityADTypeLink;
        } else {
            self.configModel.ad.adtype = ZDActivityADTypeImage;
        }
        [self.tableView reloadData];
    }];
}

// 点击展开
- (void)expandAction:(BOOL)expand {
    self.expand = !self.expand;
    if (self.expand) {
        ZDActivityMoreChioceModel *optionModel1 = [ZDActivityMoreChioceModel optionModel];
        optionModel1.userInfoOptionArray = self.userInfoOptionArray;
        optionModel1.optionType = ZDActivityOptionTypeUser;
        ZDActivityMoreChioceModel *optionModel2 = [ZDActivityMoreChioceModel optionModel];
        optionModel2.extraInfoOptionArray = self.extraInfoOptionArray;
        optionModel2.optionType = ZDActivityOptionTypeExtra;
        
        NSMutableArray *temp = self.dataSource.mutableCopy;
        [temp enumerateObjectsUsingBlock:^(ZDActivityMoreChioceModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.moreChioceType == ZDActivityMoreChioceTypeOption) {
                [self.dataSource removeObject:obj];
            }
        }];
        [self.dataSource insertObject:optionModel1 atIndex:1];
        [self.dataSource insertObject:optionModel2 atIndex:2];
    } else {
        ZDActivityMoreChioceModel *optionModel = [ZDActivityMoreChioceModel optionModel];
        optionModel.optionType = ZDActivityOptionTypeUser;
        NSMutableArray *temp = self.dataSource.mutableCopy;
        [temp enumerateObjectsUsingBlock:^(ZDActivityMoreChioceModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.moreChioceType == ZDActivityMoreChioceTypeOption) {
                [self.dataSource removeObject:obj];
            }
        }];
        [self.dataSource insertObject:optionModel atIndex:1];
    }
    [self.tableView reloadData];
}

#pragma mark --- Lazyload
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - ZD_TopBar_H)
                      style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.1)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerClass:[ZDActivityMoreChioceCell class] forCellReuseIdentifier:ZD_ClassName(ZDActivityMoreChioceCell)];
        [_tableView registerClass:[ZDActivityMoreChioceOptionCell class] forCellReuseIdentifier:ZD_ClassName(ZDActivityMoreChioceOptionCell)];
        [_tableView registerClass:[ZDActivityMoreChioceSuccessCell class] forCellReuseIdentifier:ZD_ClassName([ZDActivityMoreChioceSuccessCell class])];
    }
    return _tableView;
}

@end
