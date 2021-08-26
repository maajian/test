//
//  CustomViewController.m
//  zhundao
//
//  Created by zhundao on 2017/1/16.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "CustomViewController.h"
#import "CustomModel.h"
#import "CustomTableViewCell.h"
#import "MultipleChoiceViewController.h"
#import "MorechoiceViewController.h"
#import "MoreInputViewController.h"
#import "InputFieldViewController.h"
#import "ImageViewController.h"
#import "pulldownViewController.h"
#import "ChangeInputViewController.h"
#import "ChooseViewController.h"
@interface CustomViewController ()<UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource,UISearchResultsUpdating,UISearchControllerDelegate>
{
    UITableView *_tableview;
    Reachability *r ;
    NSMutableArray *_dataArray;
    NSArray *_pickerArray;
    NSInteger flag;
    UIView *baseView;
    UIView *whiteView;
    NSMutableArray *daarr;
    NSArray *result;
}
@property(nonatomic,strong)UILabel                     *nullDataLabell ;
@property(nonatomic,strong)UIImageView                    *nullImageView;

@property (nonatomic, strong) UISearchController *searchController;
/*! 搜索名字 */
@property (nonatomic, strong) NSMutableArray *titleArray;
/*! 所有名字 */
@property (nonatomic, strong) NSMutableArray *allTitleArray;
// 指示器
@property (nonatomic, strong) JQIndicatorView *indicator;

@end

@implementation CustomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"自定义报名项";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem activityAddItemWithTarget:self action:@selector(createpicker)];
    [self createTableView];
    
    [self network];
    _pickerArray = @[@"输入框",@"多文本",@"单选框",@"多选框",@"图片",@"下拉框",@"日期",@"数字"];
     _tableview.tableFooterView = [[UIView alloc] initWithFrame: CGRectZero];
    self.definesPresentationContext = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
}
- (void)network
{
    r = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([r currentReachabilityStatus]) {
        case NotReachable:
        {   NSMutableArray *dataarr = [NSMutableArray array];
            NSArray *array1 = [[NSUserDefaults standardUserDefaults]objectForKey:@"Custom"];
            for (NSDictionary *dic in array1) {
                CustomModel *model = [CustomModel yy_modelWithJSON:dic];
                [dataarr addObject:model];
            }
            _dataArray = [dataarr copy];
            [_tableview reloadData];
             [self shownull];
        }
            
            break;
        case ReachableViaWWAN:
            // 使用3G网
            [self showIndicator];
            [self loadData];
            break;
        case ReachableViaWiFi:
            // 使用WiFi网络
            [self showIndicator];
            [self loadData];
            break;
    }
    

}
- (UILabel *)nullDataLabell
{
    if (!_nullDataLabell) {
        _nullDataLabell =[self showNullLabelWithText:@"如果系统默认报名选项不够,请点击右上角添加更多选项~" WithTextColor:[UIColor lightGrayColor]];
        _nullDataLabell.numberOfLines = 0;
    }
    return _nullDataLabell;
}
- (void)shownull
{
    if (_dataArray.count==0&&_nullDataLabell==nil) {   //么有数据 且不存在label
              _nullImageView =   [self showNullImage];
        [self.view addSubview:self.nullDataLabell];
    }
    if (_dataArray.count>0&&_nullDataLabell!=nil&&_nullImageView!=nil) {// 有数据 存在label
        [_nullDataLabell removeFromSuperview];
        [_nullImageView removeFromSuperview];
    }
}

- (NSMutableArray *)titleArray {
    if (!_titleArray) {
        _titleArray = [NSMutableArray array];
    }
    return _titleArray;
}

- (NSMutableArray *)allTitleArray {
    if (!_allTitleArray) {
        _allTitleArray = [NSMutableArray array];
    }
    return _allTitleArray;
}

- (void)showIndicator {
    _indicator = [[JQIndicatorView alloc]initWithType:3 tintColor: [UIColor colorWithRed:9.00f/255.0f green:187.00f/255.0f blue:7.00f/255.0f alpha:1] size:CGSizeMake(90, 70)];
    _indicator.center = self.view.center;
    [self.view addSubview:_indicator];
    [_indicator startAnimating];
}

- (void)loadData
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    NSString *urlStr = [NSString stringWithFormat:@"%@api/v2/activity/getActivityOptionList?token=%@",zhundaoApi,token];
    [ZD_NetWorkM getDataWithMethod:urlStr parameters:nil succ:^(NSDictionary *obj) {
        [_allTitleArray removeAllObjects];
        result = obj[@"data"];
        NSMutableArray *dataarr = [NSMutableArray array];
        
        NSMutableArray *earray = [NSMutableArray array];
        NSMutableArray *showArray = [NSMutableArray array];
        NSMutableArray *hideArray = [NSMutableArray array];
        for (NSDictionary *dic in result) {
            CustomModel *model = [[CustomModel alloc] initWithDic:dic];
            [self.allTitleArray addObject:model.Title];
            if (model.Hidden) {
                [hideArray addObject:model];
            } else {
                [showArray addObject:model];
            }
            NSMutableDictionary *e = [NSMutableDictionary dictionary];
            for (NSString *keystr in dic.allKeys) {
                if ([[dic objectForKey:keystr] isEqual:[NSNull null]]) {
                    [e setObject:@"" forKey:keystr];
                }
                else{
                    [e setObject:[dic objectForKey:keystr] forKey:keystr];
                }
            }
            [earray addObject:e];
        }
        [dataarr addObjectsFromArray:showArray];
        [dataarr addObjectsFromArray:hideArray];
        [_indicator stopAnimating];
        [[NSUserDefaults standardUserDefaults]setObject:[earray copy]forKey:@"Custom"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        _dataArray = [dataarr copy];
        [_tableview reloadData];
        [self shownull];
    } fail:^(NSError *error) {
        
    }];
    
}
-(void)createTableView
{
    _tableview  = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64)];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.backgroundColor = ZDBackgroundColor;
    [_tableview registerNib:[UINib nibWithNibName:@"Custom" bundle:nil] forCellReuseIdentifier:@"Customcell"];
    
    _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    _searchController.searchBar.frame = CGRectMake(0,5,kScreenWidth-40, 40);
    _searchController.searchBar.placeholder = @"搜索";
    _searchController.searchBar.barTintColor =ZDBackgroundColor;
    _searchController.dimsBackgroundDuringPresentation = NO;
    _searchController.delegate = self;
    [self.searchController.searchBar sizeToFit];

    //搜索时，背景变模糊
    [_searchController.searchBar setBackgroundImage:[UIImage new]];
    
    _tableview.tableHeaderView = self.searchController.searchBar;
    //    在使用了navigationController后，当界面进行跳转往返后，时而会出现tableView或collectionView上移的情况，通常会自动上移64个像素，那么这种情况，我们可以关闭tableView的自动适配布局。
    self.searchController.searchResultsUpdater = self;
    [self.view addSubview:_tableview];
}

#pragma mark UISearchControllerDelegate 的代理
- (void)willPresentSearchController:(UISearchController *)searchController
{
    _tableview.frame = CGRectMake(0,0, kScreenWidth, kScreenHeight);
}
- (void)willDismissSearchController:(UISearchController *)searchController
{
    [UIView animateWithDuration:0.1 animations:^{
        _tableview.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight- 64);
    }];
}

- (void) viewDidLayoutSubviews {
    CGRect viewBounds = self.view.bounds;
    CGFloat topBarOffset = self.topLayoutGuide.length;
    viewBounds.origin.y = topBarOffset * -1;
    self.view.bounds = viewBounds;
}

#pragma mark UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.titleArray removeAllObjects];
    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", [self.searchController.searchBar text]];
   
    NSArray *filterArray = [self.allTitleArray filteredArrayUsingPredicate:preicate];
    if (filterArray.count) {
        for (int i =0; i<filterArray.count; i++) {
            [self.titleArray addObject:_dataArray[[_allTitleArray indexOfObject:filterArray[i]]]];
        }
    }
    [_tableview reloadData];
}

#pragma pickerview delegate/datasource

- (void)createpicker
{
    baseView =[[UIView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth,kScreenHeight)];
    baseView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    [self.view.window addSubview:baseView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancleAction)];
    [baseView addGestureRecognizer:tap];
    
    whiteView = [[UIView alloc] initWithFrame:CGRectMake(50, -245, kScreenWidth-100, 245)];
    whiteView.backgroundColor = [UIColor whiteColor];
    whiteView.layer.cornerRadius = 9.0;
    whiteView.layer.masksToBounds = YES;
    [baseView addSubview:whiteView];
    [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0 options:UIViewAnimationOptionTransitionFlipFromTop animations:^{
           whiteView.transform = CGAffineTransformMakeTranslation(0,  (kScreenHeight-245)/2+245);
    } completion:nil];
    
    UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 190, whiteView.frame.size.width, .5)];
    lineLabel.backgroundColor = [UIColor blackColor];
    [whiteView addSubview:lineLabel];
    CGFloat btnWhidth=(kScreenWidth-100)/2;
    
    UIButton *cancleBt = [UIButton buttonWithType:UIButtonTypeCustom];
    cancleBt.frame = CGRectMake(0, 190+10, btnWhidth, 35);
    [cancleBt setTitle:@"取消" forState:UIControlStateNormal];
    NSMutableAttributedString *attributedString1 = [[NSMutableAttributedString alloc]initWithString:@"取消"];
    [attributedString1 addAttribute:NSFontAttributeName value:KweixinFont(16) range:NSMakeRange(0, 2)];
    [cancleBt setAttributedTitle:attributedString1 forState:UIControlStateNormal];
    [cancleBt addTarget:self action:@selector(cancleAction) forControlEvents:UIControlEventTouchUpInside];
    [cancleBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [whiteView addSubview:cancleBt];
    
    //确定
    UIButton *confirmBt = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmBt addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
    confirmBt.frame = CGRectMake(btnWhidth, 190+10, btnWhidth, 35);
    [confirmBt setTitle:@"确定" forState:UIControlStateNormal];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:@"确定"];
    [attributedString addAttribute:NSFontAttributeName value:KweixinFont(16) range:NSMakeRange(0, 2)];
    [confirmBt setAttributedTitle:attributedString forState:UIControlStateNormal];
    [confirmBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [whiteView addSubview:confirmBt];
    
    UIPickerView *_picker = [[UIPickerView alloc] initWithFrame: CGRectMake(0, 10, kScreenWidth-100, 190)];
    _picker.delegate = self;
    _picker.dataSource = self;
    [self.view addSubview:_picker];
    [_picker selectRow:0 inComponent:0 animated:YES];
    flag =0;
    _picker.showsSelectionIndicator = YES;
    [whiteView addSubview:_picker];
    
}
- (void)cancleAction
{    [UIView animateWithDuration:0.4 animations:^{
    whiteView.alpha=0;
    baseView.alpha=0;
} completion:^(BOOL finished) {
     [baseView removeFromSuperview];
}];
}
- (void)confirmAction
{
    if (flag==0||flag ==6 ||flag==7) {
        InputFieldViewController *input = [[InputFieldViewController alloc]init];
        input.type = flag;
        [self presentViewController:input animated:NO completion:^{
            [baseView removeFromSuperview];
        }];
        input.block = ^(NSDictionary *dic){
            DDLogVerbose(@"dic = %@",dic);
            NSArray *array = [[NSUserDefaults standardUserDefaults]objectForKey:@"Custom"] ;
            CustomModel *model = [CustomModel yy_modelWithJSON:dic];
            NSMutableArray *earray  = [NSMutableArray array];
             daarr =  [_dataArray mutableCopy];
            [daarr insertObject:model atIndex:0];
            [earray addObjectsFromArray:array];
            [earray insertObject:dic atIndex:0];
            [[NSUserDefaults standardUserDefaults]setObject:[earray copy]forKey:@"Custom"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            _dataArray = [daarr copy];
            [_tableview reloadData];
        };

        
    }
    else if (flag==1)
    {
        MoreInputViewController *moreInput = [[MoreInputViewController alloc]init];
        [self setHidesBottomBarWhenPushed:YES];
        [self presentViewController:moreInput animated:NO completion:^{
            [baseView removeFromSuperview];
        }];
        moreInput.block = ^(NSDictionary *dic){
            DDLogVerbose(@"dic = %@",dic);
            NSArray *array = [[NSUserDefaults standardUserDefaults]objectForKey:@"Custom"] ;
            CustomModel *model = [CustomModel yy_modelWithJSON:dic];
            NSMutableArray *earray  = [NSMutableArray array];
            daarr = [_dataArray mutableCopy];
            [daarr insertObject:model atIndex:0];
            [earray addObjectsFromArray:array];
            [earray insertObject:dic atIndex:0];
            [[NSUserDefaults standardUserDefaults]setObject:[earray copy]forKey:@"Custom"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            _dataArray = [daarr copy];
            [_tableview reloadData];
        };

        [self setHidesBottomBarWhenPushed:NO];
    }
    else if (flag==2)
    {
        MultipleChoiceViewController *oneChoice = [[MultipleChoiceViewController alloc]init];
        [self setHidesBottomBarWhenPushed:YES];
        [self presentViewController:oneChoice animated:NO completion:^{
            [baseView removeFromSuperview];
        }];
        oneChoice.block = ^(NSDictionary *dic){
            DDLogVerbose(@"dic = %@",dic);
           NSArray *array = [[NSUserDefaults standardUserDefaults]objectForKey:@"Custom"] ;
            CustomModel *model = [CustomModel yy_modelWithJSON:dic];
            NSMutableArray *earray  = [NSMutableArray array];
            daarr = [_dataArray mutableCopy];
            [daarr insertObject:model atIndex:0];
            [earray addObjectsFromArray:array];
            [earray insertObject:dic atIndex:0];
            [[NSUserDefaults standardUserDefaults]setObject:[earray copy]forKey:@"Custom"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            _dataArray = [daarr copy];
            [_tableview reloadData];
        };
        [self setHidesBottomBarWhenPushed:NO];
    }
    else if (flag==3)
    {
        MorechoiceViewController *moreChoice = [[MorechoiceViewController alloc]init];
        [self setHidesBottomBarWhenPushed:YES];
     
        [self presentViewController:moreChoice animated:NO completion:^{
            [baseView removeFromSuperview];
        }];
        moreChoice.block = ^(NSDictionary *dic){
            DDLogVerbose(@"dic = %@",dic);
            NSArray *array = [[NSUserDefaults standardUserDefaults]objectForKey:@"Custom"] ;
            CustomModel *model = [CustomModel yy_modelWithJSON:dic];
            NSMutableArray *earray  = [NSMutableArray array];
            daarr = [_dataArray mutableCopy];
            [daarr insertObject:model atIndex:0];
            [earray addObjectsFromArray:array];
            [earray insertObject:dic atIndex:0];
            [[NSUserDefaults standardUserDefaults]setObject:[earray copy]forKey:@"Custom"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            _dataArray = [daarr copy];
            [_tableview reloadData];
        };

        [self setHidesBottomBarWhenPushed:NO];
    }
    else if (flag==4)
    {
        ImageViewController *moreImage = [[ImageViewController alloc]init];
        [self setHidesBottomBarWhenPushed:YES];
        [self presentViewController:moreImage animated:NO completion:^{
            [baseView removeFromSuperview];
        }];
        moreImage.block = ^(NSDictionary *dic){
            DDLogVerbose(@"dic = %@",dic);
            NSArray *array = [[NSUserDefaults standardUserDefaults]objectForKey:@"Custom"] ;
            CustomModel *model = [CustomModel yy_modelWithJSON:dic];
            NSMutableArray *earray  = [NSMutableArray array];
            daarr = [_dataArray mutableCopy];
            [daarr insertObject:model atIndex:0];
            [earray addObjectsFromArray:array];
            [earray insertObject:dic atIndex:0];
            [[NSUserDefaults standardUserDefaults]setObject:[earray copy]forKey:@"Custom"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            _dataArray = [daarr copy];
            [_tableview reloadData];
        };
    

        [self setHidesBottomBarWhenPushed:NO];
    }
    else
    {
        pulldownViewController *pull = [[pulldownViewController alloc]init];
        [self setHidesBottomBarWhenPushed:YES];
        [self presentViewController:pull animated:NO completion:^{
            [baseView removeFromSuperview];
        }];
        pull.block = ^(NSDictionary *dic){
            DDLogVerbose(@"dic = %@",dic);
            NSArray *array = [[NSUserDefaults standardUserDefaults]objectForKey:@"Custom"] ;
            CustomModel *model = [CustomModel yy_modelWithJSON:dic];
            NSMutableArray *earray  = [NSMutableArray array];
            daarr = [_dataArray mutableCopy];
            [daarr insertObject:model atIndex:0];
            [earray addObjectsFromArray:array];
            [earray insertObject:dic atIndex:0];
            [[NSUserDefaults standardUserDefaults]setObject:[earray copy]forKey:@"Custom"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            _dataArray = [daarr copy];
            [_tableview reloadData];
        };
        
        
        [self setHidesBottomBarWhenPushed:NO];
    }
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 8;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _pickerArray[row];
}
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return kScreenWidth-100;
}
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 30;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    flag = [pickerView selectedRowInComponent:0];
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.font = KweixinFont(15);
        pickerLabel.textAlignment = NSTextAlignmentCenter;
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:15]];
    }
    // Fill the label text here
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}
#pragma tableview delegate/datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_searchController.active) {
        return self.titleArray.count;
    } else {
        return _dataArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Customcell" forIndexPath:indexPath];
    if (cell==nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"Customcell" owner:self options:nil]lastObject];
    }
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushChange:)];
    
    [cell addGestureRecognizer:tap];
    cell.tag = indexPath.row;
    if (_searchController.active) {
        cell.model = self.titleArray[indexPath.row];
    } else {
        cell.model = _dataArray[indexPath.row];
    }
    return cell;
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomModel *model;
    if (_searchController.active) {
        model = self.titleArray[indexPath.row];
    } else {
        model = _dataArray[indexPath.row];
    }
    
    if (model.Hidden) {
        UITableViewRowAction *showAction = [UITableViewRowAction rowActionWithStyle:(UITableViewRowActionStyleDefault) title:@"显示" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
            [self hideOrShowList:model hidden:NO];
        }];
        showAction.backgroundColor = ZDGreenColor;
        return @[showAction];
    } else {
        UITableViewRowAction *hideAction = [UITableViewRowAction rowActionWithStyle:(UITableViewRowActionStyleDefault) title:@"隐藏" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
            [self hideOrShowList:model hidden:YES];
        }];
        hideAction.backgroundColor = [UIColor redColor];
        return @[hideAction];
    }
}

- (void)hideOrShowList:(CustomModel *)model hidden:(BOOL)hidden{
     MBProgressHUD *hud = [MyHud initWithAnimationType:MBProgressHUDAnimationFade showAnimated:YES UIView:self.view];
     hud.label.text = @"请稍等";
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    [dic setObject:hidden ? @(1): @(0) forKey:@"hidden"];
    [dic setObject:@(model.ID) forKey:@"id"];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:0 error:nil];
    NSString *jsonStr = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    [ZD_NetWorkM postDataWithMethod:[NSString stringWithFormat:@"%@api/v2/activity/updateActivityOption?token=%@",zhundaoApi,token] parameters:jsonStr succ:^(NSDictionary *obj) {
        if (_searchController.active) {
            NSInteger index = [_titleArray indexOfObject:model];
            model.Hidden = !model.Hidden;
            [_titleArray replaceObjectAtIndex:index withObject:model];
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hideAnimated:YES];
            [self loadData];
        });
    } fail:^(NSError *error) {
        [hud hideAnimated:YES];
        if (_searchController.active) {
            NSInteger index = [_titleArray indexOfObject:model];
            model.Hidden = !model.Hidden;
            [_titleArray replaceObjectAtIndex:index withObject:model];
        }
        [self loadData];
    }];
}

- (void)pushChange:(UITapGestureRecognizer *)tap
{
    CustomTableViewCell *mycell = (CustomTableViewCell *)tap.view;
    mycell.tag = tap.view.tag;
//    NSInteger customID = mycell.model.ID;
    NSInteger InputType = mycell.model.InputType;
    if (InputType==1||InputType==0||InputType==4||InputType==6||InputType==7) {
        ChangeInputViewController *input = [[ChangeInputViewController alloc]init];
        input.model = mycell.model;
        [self.navigationController presentViewController:input animated:YES completion:^{
        }];

        input.block = ^(NSDictionary *dic){
            DDLogVerbose(@"dic = %@",dic);
            NSArray *array = [[NSUserDefaults standardUserDefaults]objectForKey:@"Custom"] ;
            CustomModel *model = [CustomModel yy_modelWithJSON:dic];
            NSMutableArray *earray  = [NSMutableArray array];
            daarr = [_dataArray mutableCopy];
            [daarr insertObject:model atIndex:tap.view.tag];
            [daarr removeObjectAtIndex:tap.view.tag+1];
            [earray addObjectsFromArray:array];
            [earray insertObject:dic atIndex:tap.view.tag];
            [earray removeObjectAtIndex:tap.view.tag+1];
            [[NSUserDefaults standardUserDefaults]setObject:[earray copy]forKey:@"Custom"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            _dataArray = [daarr copy];
            [_tableview reloadData];
        };
    }
    else
    {
        ChooseViewController *choose = [[ChooseViewController alloc]init];
        choose.model = mycell.model;
        [self.navigationController presentViewController:choose animated:YES completion:^{
        }];
        choose.block = ^(NSDictionary *dic){
            DDLogVerbose(@"dic = %@",dic);
            NSArray *array = [[NSUserDefaults standardUserDefaults]objectForKey:@"Custom"] ;
            CustomModel *model = [CustomModel yy_modelWithJSON:dic];
            NSMutableArray *earray  = [NSMutableArray array];
            daarr = [_dataArray mutableCopy];
            [daarr insertObject:model atIndex:tap.view.tag];
            [daarr removeObjectAtIndex:tap.view.tag+1];
            
            [earray addObjectsFromArray:array];
            [earray insertObject:dic atIndex:tap.view.tag];
            [earray removeObjectAtIndex:tap.view.tag+1];
            [[NSUserDefaults standardUserDefaults]setObject:[earray copy]forKey:@"Custom"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            _dataArray = [daarr copy];
            [_tableview reloadData];
        };

    }
}

- (NSArray *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSArray *array = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        DDLogVerbose(@"json解析失败：%@",err);
        return nil;
    }
    return array;
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
