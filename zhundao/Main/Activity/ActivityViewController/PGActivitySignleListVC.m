#import "PGExerciseRecordTable.h"
#import "PGActivitySignleListVC.h"
#import "PGActivitySignleModel.h"
#import "PGActivityImageBrowserVC.h"
#import "GZActionSheet.h"
#import "PGActivityEditSignListVC.h"
#import "PGActivityListVC.h"
#import "PGDiscoverPrintVM.h"
#import "PGActivityEditSignListViewModel.h"
#import "PGActivityNewPersonViewModel.h"
#import "PGActivityMoreLabelVC.h"
#import "PGActivitySignListViewModel.h"
@interface PGActivitySignleListVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_table;
    NSMutableArray *photoArray;
    NSString *Remarkstr;
      double flag;
    NSInteger sign;
    UITableViewCell *cell;
}
@property(nonatomic,copy)NSString *phoneStr ;
@property(nonatomic,copy)NSString *nameStr ;
@property(nonatomic,strong)PGActivityEditSignListViewModel *VM ;   
@property(nonatomic,strong)PGActivitySignListViewModel *SignListVM ;   
@property(nonatomic,strong)NSMutableArray *leftArray; 
@property(nonatomic,strong)NSMutableArray *rightArray ; 
@property(nonatomic,strong)NSMutableArray *typeArray ; 
@property(nonatomic,copy)NSArray *baseNameArray ;
@property(nonatomic,copy)NSArray *baseArray ;
@end
@implementation PGActivitySignleListVC
- (void)viewDidLoad {
    [super viewDidLoad];
    [self baseSetting];
}
#pragma mark -----base 基础设置 
- (void)baseSetting
{
    self.title = @"个人信息";
    flag = 0;
    self.view.backgroundColor = ZDBackgroundColor;
    [self createTableView];
    if (_isChange )  [self rightButton];
    _VM = [[PGActivityEditSignListViewModel alloc]init];
    _SignListVM =[[ PGActivitySignListViewModel alloc]init];
    PGActivityNewPersonViewModel *newVM = [[PGActivityNewPersonViewModel alloc]init];
    _baseNameArray = [[newVM getBaseName:self.userInfo] copy];
    _baseArray  = [[_SignListVM getRightArray:self.datadic array:_baseNameArray]copy];
     NSArray *allOptionArray = [[NSUserDefaults standardUserDefaults]objectForKey:[NSString stringWithFormat:@"optionArray%li",(long)self.activityID]];  
    NSDictionary *datadic = [_VM getDicWithStr:self.datadic[@"ExtraInfo"]];
    self.leftArray =  [[_VM getMustArrayFromArray:_baseNameArray customArray:allOptionArray] mutableCopy];
    self.rightArray = [[_VM getRightMustArray:_baseArray allOptionArray:allOptionArray dic:datadic] mutableCopy];
    [_SignListVM removeNone:self.rightArray];
    self.typeArray =[[_VM getMustInputTypeFromArray:_baseNameArray customArray:allOptionArray] mutableCopy];
    if (![self.datadic[@"Title"] isEqualToString:@""] && self.datadic[@"Title"]) {  
        [_SignListVM payMent:[[self.datadic valueForKey:@"Payment"] integerValue] title:[self.datadic valueForKey:@"Title"] array:_leftArray];
        [_rightArray addObject:[self.datadic objectForKey:@"Amount"]];
        [_typeArray addObject:@"10"];
    }
}
#pragma mark 右上角修改
- (void)rightButton
{
     [UIButton initCreateButtonWithFrame:CGRectMake(0, 0, 25, 25) WithImageName:@"nav_more" Withtarget:self Selector:@selector(moreAction)];
}
- (void)moreAction
{
    NSArray *array = @[@"修改人员信息"];
    GZActionSheet *sheet = [[GZActionSheet alloc]initWithTitleArray:array WithRedIndex:1 andShowCancel:YES];
    __weak typeof(self) weakSelf = self;
    sheet.ClickIndex = ^(NSInteger index){
        NSLog(@"Show Index %zi",index); 
        if (index==1) {   
            [weakSelf EditSignList];
        }
    };
    [self.view.window addSubview:sheet];
}
- (void)EditSignList
{
    PGActivityEditSignListVC *edit = [[PGActivityEditSignListVC alloc]init];
    edit.activityID = self.activityID;
    edit.dataStr = [self.datadic[@"ExtraInfo"] copy];
    edit.baseArray = [_baseArray copy];
    edit.baseNameArray = [_baseNameArray copy];
    edit.personID = self.personID;
    [self.navigationController pushViewController:edit animated:YES];
}
#pragma mark tableview创建
- (void)createTableView
{
    _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) style:UITableViewStylePlain];
    _table.delegate = self;
    _table.dataSource = self;
    _table.backgroundColor = ZDBackgroundColor;
    [self.view addSubview:_table];
}
#pragma mark tableview delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return self.leftArray.count;
    } else if(section == 1){
        return 1;
    } else {
        return 1;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell = [tableView dequeueReusableCellWithIdentifier:@"signlecell"];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"signlecell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    while (cell.contentView.subviews.lastObject!=nil) {
        [cell.contentView.subviews.lastObject removeFromSuperview];
    }
    if (indexPath.section==0) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        if ([_typeArray[indexPath.row] integerValue]==1) {
            UILabel *longLabel   = [MyLabel initWithLabelFrame:CGRectMake(20,8,kScreenWidth-30, 1000) Text: nil textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:16] textAlignment:NSTextAlignmentLeft cornerRadius:0 masksToBounds:0];
            longLabel.numberOfLines = 0;
            longLabel.text = [NSString stringWithFormat:@"%@     %@",_leftArray[indexPath.row],_rightArray[indexPath.row]];
            NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:16]};
            CGSize size1 = [longLabel.text boundingRectWithSize:CGSizeMake(kScreenWidth-50, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
            [paragraphStyle setLineSpacing:0.5];
            NSMutableAttributedString *attributedString =  [[NSMutableAttributedString alloc] initWithString:longLabel.text attributes:@{NSKernAttributeName : @(0.1f)}];
            [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, longLabel.text.length)];
            [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:[longLabel.text rangeOfString:[NSString stringWithFormat:@"%@",_rightArray[indexPath.row]]]];
            longLabel.attributedText = attributedString;
            longLabel.frame = CGRectMake(20, 8, kScreenWidth-30, size1.height+2);
            [cell.contentView addSubview:longLabel];
        }
        else if ([_typeArray[indexPath.row] integerValue]==4){
            NSString *str = _rightArray[indexPath.row];
            UILabel *label   = [MyLabel initWithLabelFrame:CGRectMake(20, 5,150, 30) Text:_leftArray[indexPath.row] textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15] textAlignment:NSTextAlignmentLeft cornerRadius:0 masksToBounds:0];
            [cell.contentView addSubview:label];
            NSArray *showimageArray = [str componentsSeparatedByString:@"|"];
            photoArray = [NSMutableArray array];
            for (int i=0; i<showimageArray.count; i++) {
                if (![showimageArray[i] isEqualToString:@""]&&![showimageArray[i] isEqualToString:@"未填写"]) {
                    [photoArray addObject:showimageArray[i]];
                }
            }
            NSInteger count=1;
            NSInteger left =1;
            NSInteger weith = 100;
            for (int i =1; i<photoArray.count+1; i++) {
                if (i%3==0) {
                    count = i/3;
                    left=3;
                }
                else
                {
                    count = i/3+1;
                    left = i%3;
                }
                UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(5+(left-1)*weith, 5+(count-1)*weith+30, weith, weith)];
                imageview.tag =  (count-1)*3+left-1;
                imageview.userInteractionEnabled = YES;
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(PG_scanImageClickAction:)];
                [imageview addGestureRecognizer:tap];
                MBProgressHUD *hud = [PGMyHud initWithAnimationType:MBProgressHUDAnimationFade showAnimated:YES UIView:imageview];
                hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
                hud.bezelView.backgroundColor = [UIColor clearColor];
                if ([[[UIDevice currentDevice] systemVersion] floatValue]>=9) {
                    [UIActivityIndicatorView appearanceWhenContainedInInstancesOfClasses:@[[MBProgressHUD class]]].color = [UIColor grayColor];
                }
                [imageview sd_setImageWithURL:photoArray[i-1] placeholderImage:[UIImage imageNamed:@""] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    [hud hideAnimated:YES];
                }];
                imageview.contentMode =  UIViewContentModeScaleAspectFit;
                [cell.contentView addSubview:imageview];
            }
        }
        else{
            UILabel *label   = [MyLabel initWithLabelFrame:CGRectMake(20, 5,kScreenWidth-70, 30) Text:_leftArray[indexPath.row] textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15] textAlignment:NSTextAlignmentLeft cornerRadius:0 masksToBounds:0];
            CGSize size = [label.text boundingRectWithSize:CGSizeMake(kScreenWidth-70, label.frame.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:label.font} context:nil].size;
            label.frame = CGRectMake(20, 5, size.width, 30);
            [cell.contentView addSubview:label];
            UILabel *label1   = [MyLabel initWithLabelFrame:CGRectMake(106, 5, kScreenWidth-96, 30) Text:nil textColor:[UIColor lightGrayColor] font:[UIFont systemFontOfSize:15] textAlignment:NSTextAlignmentRight cornerRadius:0 masksToBounds:0];
            if ([_typeArray[indexPath.row] integerValue]==10) {
                label1.text =[NSString stringWithFormat:@"¥%@",_rightArray[indexPath.row]];
                label1.textColor =  kColorA(98, 167, 98, 1);
            }
            else
            {
                label1.text = _rightArray[indexPath.row];
            }
            label1.frame = CGRectMake(CGRectGetMaxX(label.frame)+10, 5, (kScreenWidth- CGRectGetMaxX(label.frame)-20), 30);
            if ([_leftArray[indexPath.row] isEqualToString:@"手机"]) {
                _phoneStr = _rightArray[indexPath.row];
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(PG_callAlert)];
                label1.userInteractionEnabled = YES;
                [label1 addGestureRecognizer:tap];
            }
            else if ([_leftArray[indexPath.row] isEqualToString:@"姓名"]) {
                _nameStr = [_rightArray[indexPath.row] copy];
            }
            else{}
            [cell.contentView addSubview:label1];
        }
    }else if(indexPath.section == 1) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        UILabel *label   = [MyLabel initWithLabelFrame:CGRectMake(20, 5,80, 30) Text:@"管理员备注" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15] textAlignment:NSTextAlignmentLeft cornerRadius:0 masksToBounds:0];
        CGSize size = [label.text boundingRectWithSize:CGSizeMake(100, label.frame.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:label.font} context:nil].size;
        label.frame = CGRectMake(20, 5, size.width, 30);
        [cell.contentView addSubview:label];
        UILabel *label1   = [MyLabel initWithLabelFrame:CGRectMake(106, 5, kScreenWidth-116, 30) Text:self.datadic[@"AdminRemark"] textColor:[UIColor lightGrayColor] font:[UIFont systemFontOfSize:15] textAlignment:NSTextAlignmentRight cornerRadius:0 masksToBounds:0];
        [cell.contentView addSubview:label1];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(PG_adMark:)];
        [label1 addGestureRecognizer:tap];
    } else {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = @"所属组织";
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.detailTextLabel.text = self.personListModel.DepartName;
        cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
    }
        cell.tag = indexPath.row;
    return cell;
}
#pragma mark tableview datasource
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        PGBaseWebViewVC *web = [[PGBaseWebViewVC alloc] init];
        web.webTitle = @"选择组织";
        web.urlString = [NSString stringWithFormat:@"https://app.zhundao.net/p/JinTa/m/index.html?id=%li&token=%@", (long)self.personID ,ZD_UserM.token];
        web.alertSureBlock = ^{
            PGActivityListVC *list = nil;
            for (UIViewController *VC in self.navigationController.viewControllers) {
                if ([VC isKindOfClass:[PGActivityListVC class]]) {
                    list = (PGActivityListVC *)VC;
                }
            }
            [self.navigationController popToViewController:list animated:YES];
        };
        [self.navigationController pushViewController:web animated:YES];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_typeArray[indexPath.row] integerValue]==1) {
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:16]};
        CGSize size = [[NSString stringWithFormat:@"%@     %@",_leftArray[indexPath.row],_rightArray[indexPath.row]] boundingRectWithSize:CGSizeMake(kScreenWidth-50, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
        return  size.height+15;
    }else if ([_typeArray[indexPath.row] integerValue]==4)
    {
        NSArray  *imageArr = [_rightArray[indexPath.row] componentsSeparatedByString:@"|"];
        if (imageArr.count==0||(imageArr.count==1&&[imageArr.firstObject isEqualToString:@""])) return 40;
        NSMutableArray *Array = [NSMutableArray array];
        for (int i=0; i<imageArr.count; i++) {
              if (imageArr[i]!=nil) [Array addObject:imageArr[i]];
        }
        if (Array.count%3==0)  return  Array.count/3 *110+30;
           else return  (Array.count/3+1) *110+30;
       }
    else{
        return 40;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
    view.backgroundColor = ZDBackgroundColor;
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (!_isChange&&[[[NSUserDefaults standardUserDefaults]objectForKey:@"GradeId"]integerValue]>=4&&[[NSUserDefaults standardUserDefaults]boolForKey:@"printFlag"]&&section==1) {
        return 100;
    }else{
        return 0.1;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (!_isChange&&[[[NSUserDefaults standardUserDefaults]objectForKey:@"GradeId"]integerValue]>=4&&[[NSUserDefaults standardUserDefaults]boolForKey:@"printFlag"]&&section==1) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
        view.backgroundColor = [UIColor clearColor];
        UIButton *button = [MyButton initWithButtonFrame:CGRectMake(20, 20, kScreenWidth-40, 44) title:@"打印签到二维码" textcolor:[UIColor whiteColor] Target:self action:@selector(print) BackgroundColor:ZDMainColor cornerRadius:5 masksToBounds:1];
            [view addSubview:button];
            return view;
    }
    else{
        return nil;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}
#pragma mark 去除黏性
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{if (scrollView == _table) {
    CGFloat sectionHeaderHeight = 40;
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    }
    else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}
}
#pragma mark 图片浏览
-(void)PG_scanImageClickAction:(UITapGestureRecognizer *)tap{
    NSString *str = _rightArray[tap.view.superview.superview.tag];
    NSMutableArray *showimageArray = [[str componentsSeparatedByString:@"|"]mutableCopy];
    [showimageArray removeObject:@""];
    [PGActivityImageBrowserVC show:self type:PhotoBroswerVCTypePush index:tap.view.tag imagesBlock:^NSArray *{
        return showimageArray;
    }];
}
#pragma mark 蓝牙打印 
- (void)print
{
    PGDiscoverPrintVM *printVM = [[PGDiscoverPrintVM alloc]init];
    NSArray *modelselArray = [printVM getModel];
    NSInteger index = [modelselArray indexOfObject:@"1"];
    int offsetx = [[[NSUserDefaults standardUserDefaults]objectForKey:@"printX"] intValue];
    int offsety = [[[NSUserDefaults standardUserDefaults]objectForKey:@"printY"] intValue];
    if (index ==0) {  
        [printVM printQRCode:self.vcode isPrint:YES offsetx:offsetx offsety:offsety];
    }else{  
        [printVM printQRCode:self.vcode name:_nameStr isPrint:YES offsetx:offsetx offsety:offsety];
    }
}
#pragma mark call打电话
- (void)PG_callAlert {
dispatch_async(dispatch_get_main_queue(), ^{
    UIFont *navigantionItemWithx3= [UIFont systemFontOfSize:37];
        UIColor *dailyTrainChapterG2= [UIColor redColor];
    PGExerciseRecordTable *deviceSettingsCamera= [[PGExerciseRecordTable alloc] init];
[deviceSettingsCamera assetCameraCellWithcellPlayerFather:navigantionItemWithx3 bytesFromData:dailyTrainChapterG2 ];
});
    [PGAlertView alertWithTitle:@"确定拨打电话?" message:nil sureBlock:^{
        [self callphone];
    } cancelBlock:^{
    }];
}
- (void)callphone
{
    NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel:%@",_phoneStr];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}
- (void)PG_adMark:(UITapGestureRecognizer *)tap{
    UILabel *label = (UILabel *)tap.view;
    PGActivityMoreLabelVC *more =[[PGActivityMoreLabelVC alloc]init];
    more.isADMark = YES;
    more.textfTitle = label.text;
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:more animated:YES];
    __weak typeof(self) weakSelf = self;
    more.strBlock = ^(NSString *backStr) {
        MBProgressHUD *hud = [PGMyHud initWithAnimationType:MBProgressHUDAnimationFade showAnimated:YES UIView:self.view];
         [_SignListVM  addADMark:backStr personID:_personID UserName:_nameStr Mobile:_phoneStr markBlock:^(BOOL isSuccess) {
             [hud hideAnimated:YES];
             if (isSuccess) {
                 MBProgressHUD *hud = [PGMyHud initWithMode:MBProgressHUDModeCustomView labelText:@"修改成功" showAnimated:YES UIView:weakSelf.view imageName:@"img_public_signin_check"];
                 [hud hideAnimated:YES afterDelay:1.5];
                 label.text = backStr;
             }else{
                 PGMaskLabel *label = [[PGMaskLabel alloc]initWithTitle:@"修改失败"];
                 [label labelAnimationWithViewlong:weakSelf.view];
             }
         }];
    };
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end