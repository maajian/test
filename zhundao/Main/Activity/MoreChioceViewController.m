//
//  MoreChioceViewController.m
//  zhundao
//
//  Created by zhundao on 2017/4/12.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "MoreChioceViewController.h"
#import "postActivityTableViewCell.h"
#import "OptionTableViewCell.h"
#import "BDImagePicker.h"
#import "MoreChioceMV.h"
#import "NewOrEditMV.h"

#define kBigImageArray @"BigImageArray"
#define kSmallImageArray @"SmallImageArray"
#define kBigIndex @"BigIndex"
#define kSmallIndex @"smallindex"
#define kBoolarray @"Boolarray"
#define kAlertSwitch @"AlertSwitch"
#define kHiddenList @"HiddenList"
static NSString *optionid = @"optionid";
//https://joinheadoss.oss-cn-hangzhou.aliyuncs.com/qinglong/Static/zhundao/img/bg/1.jpg
//https://joinheadoss.oss-cn-hangzhou.aliyuncs.com/qinglong/Static/zhundao/img/bg/2.jpg
//https://joinheadoss.oss-cn-hangzhou.aliyuncs.com/qinglong/Static/zhundao/img/bg/3.jpg
//https://joinheadoss.oss-cn-hangzhou.aliyuncs.com/qinglong/Static/zhundao/img/bg/4.jpg
@interface MoreChioceViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    BOOL isExpland;
    postActivityTableViewCell *myCell;
}
@property(nonatomic ,strong)UITableView *tableview ;
@property(nonatomic,strong)NSMutableArray *boolArray;   //自定义项的bool值
@property(nonatomic,strong)NSMutableArray *baseOptionsArray ;  //基础自定义项
@property(nonatomic,strong)NSMutableArray *allOptionaArray ;  //全部自定义项
@property(nonatomic,strong)NSMutableDictionary *backDic;  //返回界面block的字典
@property(nonatomic,assign)BOOL alertBool;
@property(nonatomic,assign)NSInteger hiddenBool;

@property(nonatomic,strong)          UISwitch *alertSwitch;
@property(nonatomic,strong)          UILabel *hiddenRightLabel;
@property(nonatomic,strong)         UILabel *customLeftLabel ;
@property(nonatomic,strong)         UILabel *customRightLabel ;
@property(nonatomic,strong)         UILabel *alertLabel ;
@property(nonatomic,strong)         UILabel *hiddenLabel ;
@property(nonatomic,strong)          UIImageView *img1;
@property(nonatomic,assign)          NSInteger gradeID;
@end

@implementation MoreChioceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customBack];
    [self rightButton];
    [self dataBaseSet];
    NSLog(@"arrrray = %@",self.boolArray);
    if ([[  NSUserDefaults standardUserDefaults  ]objectForKey:@"GradeId"]) {
        self.gradeID =  [[[  NSUserDefaults standardUserDefaults  ]objectForKey:@"GradeId"]integerValue];
    }

}

#pragma 基础设置 
- (void)dataBaseSet
{
    isExpland = NO;
    self.title = @"更多选项";
    self.gradeID=0;
    if (_datadic.count!=0) {
        self.backDic = [_datadic mutableCopy];
        self.hiddenBool = [_datadic[kHiddenList] integerValue];
        self.alertBool = [_datadic[kAlertSwitch]boolValue];
    }
    else{
        [self.backDic setValue:self.boolArray forKey:kBoolarray];
        [self.backDic setValue:@0 forKey:kAlertSwitch];
        [self.backDic setValue:@0 forKey:kHiddenList];
    }
    [self.view addSubview:self.tableview];
}

-(void)customBack
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(-8, 20, 80, 44)];
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backpop)];
    UILabel *button = [MyLabel initWithLabelFrame:CGRectMake(0, 0, 40,45) Text:@"取消" textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:17] textAlignment:NSTextAlignmentLeft cornerRadius:0 masksToBounds:NO];
    [view addSubview:button];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:view];
    self.navigationItem.leftBarButtonItem = item;
    [view addGestureRecognizer:tap3];
}
-(void)rightButton
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(save)];
    NSDictionary *dic = @{NSFontAttributeName : KHeitiSCMedium(17),
                          NSForegroundColorAttributeName:zhundaoGreenColor};
    [item setTitleTextAttributes:dic forState:UIControlStateNormal];

    self.navigationItem.rightBarButtonItem = item;
}
- (void)save
{
    if (_block) {
        _block(_backDic,_imageStr,_isSmallPost);
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController popViewControllerAnimated:YES];
    });
}
- (void)backpop
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma 懒加载 模块
- (UILabel *)customLeftLabel
{
    if (_customLeftLabel==nil) {
        _customLeftLabel = [MyLabel initWithLabelFrame:CGRectMake(10, 0, 120, 44) Text:@"报名填写项" textColor:[UIColor blackColor] font:KHeitiSCMedium(15) textAlignment:NSTextAlignmentLeft cornerRadius:0 masksToBounds:0];
    }
    return _customLeftLabel;
}
- (UILabel *)customRightLabel
{
    
    if (!_customRightLabel) {
        _customRightLabel =  [MyLabel initWithLabelFrame:CGRectMake(85, 0, kScreenWidth-115, 44) Text:@"多选" textColor:kColorA(199, 199, 205, 1) font:KHeitiSCLight(15) textAlignment:NSTextAlignmentRight cornerRadius:0 masksToBounds:0];
    }
    return _customRightLabel;
}
- (UILabel *)alertLabel
{
    if (_alertLabel==nil) {
        _alertLabel = [MyLabel initWithLabelFrame:CGRectMake(10, 0, 120, 44) Text:@"用户报名提醒" textColor:[UIColor blackColor] font:KHeitiSCMedium(15) textAlignment:NSTextAlignmentLeft cornerRadius:0 masksToBounds:0];
    }
    return _alertLabel;
}
- (UISwitch *)alertSwitch
{
    if (!_alertSwitch) {
        _alertSwitch = [[UISwitch alloc]initWithFrame:CGRectMake(kScreenWidth-60, 7, 50, 44)];
        [_alertSwitch addTarget:self action:@selector(switchChange:) forControlEvents:UIControlEventValueChanged];
        _alertSwitch.on = _alertBool;
    }
    return _alertSwitch;
}
- (UILabel *)hiddenLabel
{
    if (_hiddenLabel==nil) {
        _hiddenLabel = [MyLabel initWithLabelFrame:CGRectMake(10, 0, 120, 44) Text:@"隐藏报名名单" textColor:[UIColor blackColor] font:KHeitiSCMedium(15) textAlignment:NSTextAlignmentLeft cornerRadius:0 masksToBounds:0];
    }
    return _hiddenLabel;
}
- (UILabel *)hiddenRightLabel
{
    if (!_hiddenRightLabel) {
        _hiddenRightLabel= [MyLabel initWithLabelFrame:CGRectMake(kScreenWidth-200, 0, 170, 44) Text:@"名单显示设置" textColor:kColorA(199, 199, 205, 1) font:KHeitiSCLight(15) textAlignment:NSTextAlignmentRight cornerRadius:0 masksToBounds:0];
        _hiddenRightLabel.text = [self listLabelFromindex:_hiddenBool];
    }
    return _hiddenRightLabel;
}

- (NSMutableDictionary *)backDic
{
    if (!_backDic) {
        _backDic = [NSMutableDictionary dictionary];
    }
    return _backDic;
}
- (UITableView *)tableview
{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64)
                      style:UITableViewStyleGrouped];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        [_tableview registerNib:[UINib nibWithNibName:@"OptionTableViewCell" bundle:nil] forCellReuseIdentifier:@"optionid"];
    }
    return _tableview;
}
- (NSMutableArray *)boolArray
{
    if (!_boolArray) {
        _boolArray = [NSMutableArray array];
        
        if (_datadic.count!=0) {
            _boolArray = _datadic[kBoolarray];
        }
        else{
        for (int i= 0; i<self.allOptionaArray.count; i++) {
            if (i==0||i==1) {
                [_boolArray addObject:@"1"];
            }else
            {
                [_boolArray addObject:@"0"];
            }
        }
        }
    }
    return _boolArray;
}
- (NSMutableArray *)allOptionaArray
{
    if (!_allOptionaArray) {
        _allOptionaArray = [NSMutableArray array];
        [_allOptionaArray addObjectsFromArray:self.baseOptionsArray];
        [_allOptionaArray addObjectsFromArray:self.optionsArray];
    }
    return _allOptionaArray;
}
- (NSMutableArray *)baseOptionsArray
{
    if (!_baseOptionsArray) {
        _baseOptionsArray = [NSMutableArray array];
        NSArray *arr =  @[@"姓名",@"手机",@"性别",@"单位",@"部门",@"职务",@"身份证",@"行业",@"邮箱",@"地址",@"备注",@"人脸照片"];
        for (NSString *str in arr) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setValue:str forKey:@"Title"];
            [_baseOptionsArray addObject:dic];
        }
    }
    return _baseOptionsArray;
}

#pragma datasource tableview 
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.gradeID>1) {
        return 4;
    }
    else{
        return 3;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 1:
        {
            if (isExpland==YES) {
                return self.allOptionaArray.count+1;
            }
            else{
                return 1;
            }
        }
            break;
            
        default:return 1;
            break;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  if (indexPath.section==1&&indexPath.row!=0) {
        OptionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:optionid];
        if (!cell) {
            cell = [[OptionTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:optionid];
        }
        if (indexPath.row==1||indexPath.row==2) {
            cell.imageview.image = [UIImage imageNamed:@"option打勾"];
        }
        else
        {
            if ([_boolArray[indexPath.row-1]integerValue]) {
                cell.imageview.image = [UIImage imageNamed:@"option打勾"];
            }
            else{
                cell.imageview.image = [UIImage imageNamed:@"空圈"];
            }
        }
        NSDictionary *dic = self.allOptionaArray[indexPath.row-1];
        cell.titleLabel.text = dic[@"Title"];
        return cell;
    }
    else
    {
        postActivityTableViewCell *cell = [postActivityTableViewCell cellAllocWithTableView:tableView WithIndexPath:indexPath];
        if (indexPath.section==0) {
            [self ImageCell:cell];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        else if (indexPath.section==1) {
            if (indexPath.row==0) {
                [cell.contentView addSubview:self.customRightLabel];
                [cell.contentView addSubview:self.customLeftLabel];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            else{}
        }
        else if (indexPath.section==2)
        {
            [cell.contentView addSubview:self.alertSwitch];
            [cell.contentView addSubview:self.alertLabel];
        }
        else
        {
            if (self.gradeID>1) {
                [cell.contentView addSubview:self.hiddenRightLabel];
                [cell.contentView addSubview:self.hiddenLabel];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(listGes)];
                [cell addGestureRecognizer:tap3];
            }
        }
        return cell;
        
    }
    
}
#pragma delegate tableview
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            return 120;
            break;
        default:
            return 44;
            break;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
   return 30;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (self.gradeID>1) {
        if (section==3) {
            return 30;
        }
        else{
            return 0.1;
        }
    }
    else{
        if (section==2) {
            return 30;
        }
        else{
            return 0.1;
        }
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return [self createViewWithStr:@"分享小图(建议尺寸100*100)"];
            break;
        case 1:
            return [self createViewWithStr:@"默认姓名,手机 可前往 发现->自定义报名项 添加更多"];
            break;
        case 2:
            return [self createViewWithStr:@"有人报名，准到给您发提醒消息(您需先关注准到公众号)"];
            break;
        case 3:
            return [self createViewWithStr:@"开启后，活动详情页将不再显示报名人数"];
            break;
        default: return nil;
            break;
    }
}
#pragma create headerView
- (UIView *)createViewWithStr :(NSString *)str
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    view.backgroundColor = [UIColor clearColor];
    
    UILabel *label = [MyLabel initWithLabelFrame:CGRectMake(10, 0, kScreenWidth-10, 30) Text:str textColor:[UIColor grayColor] font:KHeitiSCLight(12) textAlignment:NSTextAlignmentLeft cornerRadius:0 masksToBounds:0];
    [view addSubview:label];
    return  view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    OptionTableViewCell *Cell = [tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.section==1&&indexPath.row>2) {
        if (![_boolArray[indexPath.row-1] integerValue]) {
            [_boolArray replaceObjectAtIndex:indexPath.row-1 withObject:@"1"];
            Cell.imageview.image = [UIImage imageNamed:@"option打勾"];
        }
        else
        {
            Cell.imageview.image = [UIImage imageNamed:@"空圈"];
            [_boolArray replaceObjectAtIndex:indexPath.row-1 withObject:@"0"];
        }
        NSLog(@"boolArray = %@",_boolArray);
        [_backDic setValue:_boolArray forKey:kBoolarray];
    }
    if (indexPath.section==1&&indexPath.row==0) {
        isExpland = !isExpland;
        [_tableview reloadData];
    }
}

#pragma  mark ---

- (void)switchChange:(UISwitch *)mySwitch{
    if (mySwitch.on) {
        [_backDic setObject:@(1) forKey:kAlertSwitch];
    }else{
        [_backDic setObject:@(0) forKey:kAlertSwitch];
    }
}

#pragma 名单显示设置
- (void)listGes  //手势点击名单
{
        TYAlertView *view = [TYAlertView alertViewWithTitle:@"报名名单设置" message:nil];
        __weak typeof(self) weakSelf = self;
        TYAlertAction *Action1 = [TYAlertAction actionWithTitle:@"显示人数和头像姓名" style:TYAlertActionStyleDefault handler:^(TYAlertAction *action) {
            [weakSelf changeDataWithIndex:3 Str:@"显示人数和头像姓名"];
        }];
        TYAlertAction *Action2 = [TYAlertAction actionWithTitle:@"显示人数和头像昵称" style:TYAlertActionStyleDefault handler:^(TYAlertAction *action) {
            [weakSelf changeDataWithIndex:0 Str:@"显示人数和头像昵称"];
        }];
        TYAlertAction *Action3 = [TYAlertAction actionWithTitle:@"显示人数" style:TYAlertActionStyleDefault handler:^(TYAlertAction *action) {
            [weakSelf changeDataWithIndex:1 Str:@"显示人数"];
        }];
         TYAlertAction *Action4= [TYAlertAction actionWithTitle:@"隐藏" style:TYAlertActionStyleDefault handler:^(TYAlertAction *action) {
            [weakSelf changeDataWithIndex:2 Str:@"隐藏"];
         }];
        TYAlertAction *Action5 = [TYAlertAction actionWithTitle:@"取消" style:TYAlertActionStyleCancel handler:^(TYAlertAction *action) {
        }];
        [view addAction:Action1];
        [view addAction:Action2];
        [view addAction:Action3];
        [view addAction:Action4];
        [view addAction:Action5];
        TYAlertController *alert = [TYAlertController alertControllerWithAlertView:view preferredStyle:TYAlertControllerStyleActionSheet];
        [self presentViewController:alert animated:YES completion:nil];
}
- (void)changeDataWithIndex :(NSInteger )index Str :(NSString *)str //选择设置
{
    switch (index) {
        case 0:
            _hiddenRightLabel.text = str ;
            [self.backDic setValue:@(0) forKey:kHiddenList];
            break;
        case 1:
            _hiddenRightLabel.text = str ;
            [self.backDic setValue:@(1) forKey:kHiddenList];
            break;
        case 2:
            _hiddenRightLabel.text = str ;
            [self.backDic setValue:@(2) forKey:kHiddenList];
            break;
        case 3:
            _hiddenRightLabel.text = str ;
            [self.backDic setValue:@(3) forKey:kHiddenList];
            break;
        default:
            break;
    }
}
- (NSString *)listLabelFromindex :(NSInteger )index
{
    switch (index) {
        case 0:
            return @"显示人数和头像昵称";
            break;
        case 1:
            return @"显示人数";
            break;
        case 2:
            return @"隐藏";
            break;
        case 3:
            return @"显示人数和头像姓名";
            break;
        default:
            return @"显示人数和头像";
            break;
    }
}
#pragma  图片视图创建
- (void)ImageCell :(UITableViewCell *)cell{
    _img1 = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 100,100)];
    [_img1 sd_setImageWithURL:[NSURL URLWithString:_imageStr]];
    [self borderImage:_img1];
    [cell.contentView addSubview:_img1];
    UIImageView *selectImg = [[UIImageView alloc]initWithFrame:CGRectMake(120, 10, 100, 100)];
    [self borderImage:selectImg];
    UIImageView *addImg =[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetWidth(selectImg.frame)/4, CGRectGetWidth(selectImg.frame)/4, CGRectGetWidth(selectImg.frame)/2, CGRectGetWidth(selectImg.frame)/2)];
    [selectImg addSubview:addImg];
    addImg.image = [UIImage imageNamed:@"加号"];
    [cell.contentView addSubview:selectImg];
    selectImg.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addSmallImage)];
    [selectImg addGestureRecognizer:tap];
}
- (void)borderImage:(UIImageView *)imageView{
    imageView.layer.borderWidth = 1;
    imageView.layer.borderColor = zhundaoLineColor.CGColor;
}
#pragma 手势
- (void)addSmallImage
{
    [BDImagePicker showImagePickerFromViewController:self allowsEditing:YES finishAction:^(UIImage *image) {
        if (image) {
            MBProgressHUD *hud = [MyHud initWithAnimationType:MBProgressHUDAnimationFade showAnimated:YES UIView:self.view];
            [NewOrEditMV changeToNetImage:image block:^(NSString *str) {
                _isSmallPost = YES;
                _imageStr = str;
                _img1.image = image;
                [hud hideAnimated:YES];
                MBProgressHUD *hud1 = [MyHud initWithMode:MBProgressHUDModeCustomView labelText:@"添加成功" showAnimated:YES UIView:self.view imageName:@"签到打勾"];
                [hud1 hideAnimated:YES afterDelay:1.5];
            }];
        }
    }];
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
