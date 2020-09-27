#import "PGUploadCompletionBlock.h"
#import "PGActivityPostActivityVC.h"
#import "PGAvtivityMoreChioceVC.h"
#import "PGActivityFeeViewController.h"
#import "PGAvtivityOptions.h"
#import "PGActivityMapVC.h"
#import "PGActivityEditWebVC.h"
#import "PGMainActivityVC.h"
#import "PGAvtivityPostView.h"
#import "PGAvtivityPostViewModel.h"
#import "PGActivityChooseBigImgVC.h"
#import "PGActivityShowPostImageVC.h"
#define kBoolarray @"Boolarray"
#define kAlertSwitch @"AlertSwitch"
#define kHiddenList @"HiddenList"
@interface PGActivityPostActivityVC ()<ZDAvtivityPostDelegate>
{
    MBProgressHUD *hud ;
}
@property(nonatomic,strong)PGAvtivityPostView                     *postView;
@property(nonatomic,strong)PGAvtivityPostViewModel                *postVM;
@property(nonatomic,strong)NSDateFormatter            *formatter;
@property(nonatomic,strong)      NSMutableArray *optionArray;
@property(nonatomic,copy)         NSDictionary *moredic;
@property(nonatomic,copy)NSString *bigImageUrl ;
@property(nonatomic,assign)BOOL isImgPost;
@property(nonatomic,assign)NSInteger currentItem;
@property(nonatomic,assign)NSInteger collectIndex;
@property(nonatomic,copy)NSString *smallImageUrl ;
@property(nonatomic,assign)BOOL isSmallPost;
@property(nonatomic,assign)double latitude;
@property(nonatomic,assign)double longitude;
@property (nonatomic, assign) BOOL isGaoDeMap;
@property(nonatomic,strong)NSMutableArray *ALLOptionsArray;
@property(nonatomic,assign)NSInteger jiexiCount;
@property(nonatomic,strong)NSMutableArray *strArray; 
@end
@implementation PGActivityPostActivityVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ZDBackgroundColor;
    _postVM = [[PGAvtivityPostViewModel alloc]init];
    [self baseSetting];
    [self.view addSubview:self.PG_PGAvtivityPostView];
     [self network];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(PG_selectImg:) name:@"changeImg" object:nil];
}
- (void)baseSetting
{
    _jiexiCount=0;
    if (_activityModel) {
        _postView.htmlStr = [_activityModel.Content copy];
        self.postView.bigImageStr = _activityModel.BackImgurl;
        _isImgPost = NO;
        _smallImageUrl = _activityModel.ShareImgurl;
        _isSmallPost = YES;
         self.title = @"编辑活动";
    }
    else{
        _postView.htmlStr= @"";
        self.title = @"发起活动";
    }
}
#pragma mark netWork网络请求
- (void)network
{   
    __weak typeof(self) weakSelf = self;
    PGAvtivityOptions *Options = [[PGAvtivityOptions alloc]init];
    JQIndicatorView *indicator = [[JQIndicatorView alloc]initWithType:3 tintColor: [UIColor colorWithRed:9.00f/255.0f green:187.00f/255.0f blue:7.00f/255.0f alpha:1] size:CGSizeMake(90, 70)];
    indicator.center = self.view.center;
    [self.view addSubview:indicator];
    [indicator startAnimating];
    [Options networkwithBlock:^(NSArray *optionsArray) {
        [indicator stopAnimating];
        weakSelf.optionArray = [optionsArray copy];
        if (_activityModel) {
            [self editDic];
        }
    }];
}
#pragma mark 懒加载
- (PGAvtivityPostView *)PG_PGAvtivityPostView{
    if (!_postView) {
        _postView = [[PGAvtivityPostView alloc]initWithModel:_activityModel];
        _postView.ZDAvtivityPostDelegate = self;
    }
    return _postView;
}
-(NSDateFormatter *)formatter{
    if (!_formatter) {
        _formatter = [[NSDateFormatter alloc] init];
        _formatter.dateFormat =@"yyyyMMddHHmmss";
    }
    return _formatter;
}
- (NSDictionary *)moredic
{
    if (!_moredic) {
        _moredic = [NSDictionary dictionary];
    }
    return _moredic;
}
- (NSMutableArray *)optionArray  
{
    if (!_optionArray) {
        _optionArray = [NSMutableArray array];
    }
    return _optionArray;
}
- (NSMutableArray *)ALLOptionsArray 
{
    __weak typeof(self) weakSelf = self;
    if (!_ALLOptionsArray) {
        _ALLOptionsArray = [NSMutableArray array];
        NSArray *arr =  @[@"100",@"101",@"102",@"103",@"104",@"105",@"110",@"106",@"107",@"111",@"109",@"112"];
        [_ALLOptionsArray addObjectsFromArray:arr];
        if (weakSelf.optionArray.count>0) {
            for (NSDictionary *dic in weakSelf.optionArray) {
                [_ALLOptionsArray addObject:dic[@"ID"]];
            }
        }
    }
    return _ALLOptionsArray;
}
#pragma mark --- ZDAvtivityPostDelegate
- (void)pushXieYi{
    NSString *xieyiStr = @"https://www.zhundao.net/service/help/detail/206";
    PGBaseWebViewVC *web = [[PGBaseWebViewVC alloc] init];
    web.urlString = xieyiStr;
    web.title = @"准到服务协议";
    web.isClose = YES;
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:web animated:YES];
}
- (void)pushFee{
    PGActivityFeeViewController *fee = [[PGActivityFeeViewController alloc]init];
    [self setHidesBottomBarWhenPushed: YES];
    if (_postView.feeArray.count) {
        fee.feeArray = _postView.feeArray;
    }
    [self.navigationController pushViewController:fee animated:YES];
    fee.block = ^(NSArray *feeArray)
    {
        _postView.feeArray = [feeArray copy];
        if (feeArray.count) {
            _postView.activityFeeRightLabel.text = @"已设置";
        }
        [self.view endEditing:YES];
    };
}
- (void)pushEdit{
    PGActivityEditWebVC *ed = [[PGActivityEditWebVC alloc]init];
    if (_postView.htmlStr) {
        ed.pushText = _postView.textStr;
        [self setImageStr];
        ed.imageArray = [_strArray copy];
    }
    _jiexiCount=0;
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:ed animated:YES];
    ed.block = ^(NSAttributedString *text ,NSString *htmlstr,NSString *titletext)
    {
        [_postView.textview loadHTMLString:htmlstr baseURL:nil];
        _postView.textStr = [text copy];
        _postView.htmlStr= [htmlstr copy];
    };
}
- (void)pushMoreChoose{
    PGAvtivityMoreChioceVC *moreChioce = [[PGAvtivityMoreChioceVC alloc]init];
    [self setHidesBottomBarWhenPushed:YES];
    moreChioce.optionsArray = self.optionArray;
    moreChioce.datadic =self.moredic;
    if (_isSmallPost) {
        moreChioce.isSmallPost = _isSmallPost;
        moreChioce.imageStr = _smallImageUrl;
    }else{
        moreChioce.imageStr = self.PG_PGAvtivityPostView.bigImageStr;
    }
    [self.navigationController pushViewController:moreChioce animated:YES];
    moreChioce.block = ^(NSDictionary *dic, NSString *smallStr, BOOL isPost) {
        _smallImageUrl = smallStr;
        _moredic = [dic copy];
        _isSmallPost = isPost;
    };
}
- (void)pushLocation{
dispatch_async(dispatch_get_main_queue(), ^{
    UIButton *badgeDefaultMaximumA2= [UIButton buttonWithType:UIButtonTypeCustom]; 
    badgeDefaultMaximumA2.frame = CGRectZero; 
    badgeDefaultMaximumA2.exclusiveTouch = NO; 
    badgeDefaultMaximumA2.adjustsImageWhenHighlighted = NO; 
    badgeDefaultMaximumA2.reversesTitleShadowWhenHighlighted = NO; 
    badgeDefaultMaximumA2.frame = CGRectZero; 
        CGPoint fieldShouldBegink3 = CGPointZero;
    PGUploadCompletionBlock *imageCropManager= [[PGUploadCompletionBlock alloc] init];
[imageCropManager videoPreviewCellWithcancelCollectionCourse:badgeDefaultMaximumA2 activityIndicatorVisible:fieldShouldBegink3 ];
});
        PGActivityMapVC *map = [[PGActivityMapVC alloc]init];
    if (self.latitude) {
        map.latitude = self.latitude;
        map.longitude = self.longitude;
    }
        [self setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:map animated:YES];
        __weak typeof(self) weakSelf = self;
        map.block =^(NSString *address)
        {
            _postView.activityPlaceTextField.text = address;
        };
        map.latblock = ^(double lat ,double loog)
        {
            weakSelf.latitude = lat;
            weakSelf.longitude = loog;
            weakSelf.isGaoDeMap = YES;
        };
}
- (void)changeBigImage:(NSArray *)imageArray{
    if (_isImgPost) {
        PGActivityShowPostImageVC *showPost = [[PGActivityShowPostImageVC alloc]init];
        showPost.imageArray = imageArray;
        showPost.imageStr = self.PG_PGAvtivityPostView.bigImageStr;
        [self.navigationController pushViewController:showPost animated:YES];
    }else{
        PGActivityChooseBigImgVC *chooseimageVC = [[PGActivityChooseBigImgVC alloc]init];
        chooseimageVC.imageArray = imageArray;
        chooseimageVC.selectUrl = self.PG_PGAvtivityPostView.bigImageStr;
        chooseimageVC.currentItem = _currentItem;
        chooseimageVC.collectIndex = _collectIndex;
        [self setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:chooseimageVC animated:YES];
    }
}
- (void)PG_selectImg:(NSNotification *)sender{
    _bigImageUrl = sender.userInfo[@"ImgStr"];
    _isImgPost = [sender.userInfo[@"isPost"] boolValue];
    if (!_isImgPost) {
        _currentItem = [sender.userInfo[@"item"] integerValue];
        _collectIndex = [sender.userInfo[@"collectIndex"] integerValue];
    }
    self.PG_PGAvtivityPostView.bigImageStr = _bigImageUrl;
    [self.PG_PGAvtivityPostView.tableview reloadData];
}
#pragma  mark --- 发起活动
- (void)postActivity
{
    [self isHaveMoredic];
}
- (void)lastPost
{
    NSString *str = nil;
    if (_activityModel) {
        str = [NSString stringWithFormat:@"%@api/v2/activity/updateActivity?token=%@",zhundaoApi,[[PGSignManager shareManager] getToken]];
    } else {
        str = [NSString stringWithFormat:@"%@api/v2/activity/addActivity?token=%@",zhundaoApi,[[PGSignManager shareManager] getToken]];
    }
    NSDictionary *postBody = @{@"title":ZD_SafeValue(_postView.activityTitleTextField.text),
                               @"timeStart":ZD_SafeValue([_postVM appendTime:_postView.beginTimeRightLabel.text]),
                               @"endTime": ZD_SafeValue([_postVM appendTime:_postView.stopTimeRightLabel.text]),
                               @"timeStop":ZD_SafeValue([_postVM appendTime:_postView.endTimeRightLabel.text]),
                               @"address":ZD_SafeValue(_postView.activityPlaceTextField.text),
                               @"content":_postView.htmlStr,
                               @"userInfo":[_postVM getUserInfo:_moredic ALLOptionsArray:self.ALLOptionsArray],
                               @"userLimit":_postView.activityNumbertField.text,
                               @"backImgurl":ZD_SafeStringValue(_bigImageUrl),
                               @"shareImgurl":ZD_SafeStringValue(_smallImageUrl),
                               @"timeSure":[_postVM timeNow],
                               @"alert":[NSNumber numberWithBool:[_postVM isAlert:_moredic]],
                               @"sendSms":[NSNumber numberWithBool:0],
                               @"extraUserInfo" :[_postVM getExtraUserInfo:_moredic ALLOptionsArray:self.ALLOptionsArray],
                               @"hideInfo":[_moredic valueForKey:kHiddenList]
                               };
    NSMutableDictionary *dic = [postBody mutableCopy];
    if ([_postView.activityFeeRightLabel.text isEqualToString:@"未设置,默认免费"]) {
        NSLog(@"没有费用");
        [dic setObject:@"" forKey:@"activityFees"];
    }else
    {
        NSMutableArray *temp = _postView.feeArray.mutableCopy;
        [temp enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSMutableDictionary *tempDic2 = [NSMutableDictionary dictionaryWithDictionary:obj];
            [tempDic2 setValue:temp.firstObject[@"ActivityID"] forKey:@"ActivityID"];
            [tempDic2 setValue:temp.firstObject[@"UserID"] forKey:@"UserID"];
            [temp replaceObjectAtIndex:idx withObject:tempDic2];
        }];
         [dic setObject:ZD_SafeValue(temp) forKey:@"activityFees"];
    }
    if ([_postView.activityNumbertField.text isEqualToString:@""]) {
        [dic setObject:[NSString stringWithFormat:@"%d",0] forKey:@"userLimit"];
    }else{
        [dic setObject:_postView.activityNumbertField.text forKey:@"userLimit"];
    }
    if (_postView.startTimeRightLabel.text) {
         [dic setObject:[_postVM appendTime:_postView.startTimeRightLabel.text] forKey:@"startTime"];
    }
    if (self.latitude) {
        if (_isGaoDeMap) {
            [dic setObject:[NSString stringWithFormat:@"%lf",_longitude + 0.0065] forKey:@"lng"];
            [dic setObject:[NSString stringWithFormat:@"%lf",_latitude + 0.006] forKey:@"lat"];
        } else {
            [dic setObject:[NSString stringWithFormat:@"%lf",_longitude] forKey:@"lng"];
            [dic setObject:[NSString stringWithFormat:@"%lf",_latitude] forKey:@"lat"];
        }
    }
    if (_activityModel) {
        [dic setObject:@(_activityModel.ID) forKey:@"id"];
        if (_activityModel.HasJoinNum >0) {
            if (_activityModel.ExtraUserInfo) {
                 [dic setObject:_activityModel.ExtraUserInfo forKey:@"extraUserInfo"];
            }else
            {
                [dic setObject:@"" forKey:@"extraUserInfo"];
            }
        }
        [dic setObject:@(_activityModel.ActivityGenre) forKey:@"activityGenre"];
        if (!self.latitude && _activityModel.Lat) {
            [dic setObject:[NSString stringWithFormat:@"%lf",_activityModel.Lng] forKey:@"lng"];
            [dic setObject:[NSString stringWithFormat:@"%lf",_activityModel.Lat] forKey:@"lat"];
        }
        [dic setObject:@(_activityModel.MaxPeople) forKey:@"maxPeople"];
        [dic setObject:@(_activityModel.MinPeople) forKey:@"minPeople"];
    }
    [self havedic:dic str:str];
}
- (void)havedic :(NSDictionary *)dic str :(NSString *)str
{
    PGNetWorkManager.shareHTTPSessionManager.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"application/json",
                                                          @"text/html",
                                                          @"text/json",
                                                          @"text/javascript",
                                                          @"text/plain",
                                                          nil];
    PGNetWorkManager.shareHTTPSessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [ZD_NetWorkM postDataWithMethod:str parameters:dic succ:^(NSDictionary *obj) {
        NSLog(@"responseObject = %@",obj);
        NSString *str = [[NSString alloc]initWithData:obj encoding:NSUTF8StringEncoding];
        NSDictionary *dictinary = [[NSString alloc]initWithData:obj encoding:NSUTF8StringEncoding].zd_jsonDictionary;
        PGNetWorkManager.shareHTTPSessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
        if ([dictinary[@"errcode"] integerValue] != 0) {
            [hud hideAnimated:YES];
            PGMaskLabel *label = [[PGMaskLabel alloc]initWithTitle:dictinary[@"errmsg"]];
            [label labelAnimationWithViewlong:self.view];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popToRootViewControllerAnimated:YES];
            });
        }
        if ([dictinary[@"errcode"]integerValue]==0) {
            [self showSuccess];
            [ZD_NotificationCenter postNotificationName:ZDNotification_Load_Activity object:nil];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popToRootViewControllerAnimated:YES];
            });
        }
    } fail:^(NSError *error) {
        PGNetWorkManager.shareHTTPSessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
        NSLog(@"error = %@",error);
        [hud hideAnimated:YES];
        PGMaskLabel *label = [[PGMaskLabel alloc]initWithTitle:error.description];
        [label labelAnimationWithViewlong:self.view];
    }];
}
#pragma 逻辑
- (void)showSuccess
{
    [hud hideAnimated:YES];
    MBProgressHUD *hud1 = [PGMyHud initWithMode:MBProgressHUDModeCustomView labelText:@"发布成功" showAnimated:YES UIView:self.view imageName:@"img_public_signin_check"];
    [hud1 hideAnimated:YES afterDelay:2];
}
- (void)isHaveMoredic
{
    if (self.moredic.count==0) {
        NSMutableArray *boarray = [NSMutableArray array];
        for (int i= 0; i<self.ALLOptionsArray.count; i++) {
            if (i==0||i==1) {
                [boarray addObject:@1];
            }else
            {
                [boarray addObject:@0];
            }
        }
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setValue:boarray forKey:kBoolarray];
        [dic setValue:@0 forKey:kAlertSwitch];
        [dic setValue:@0 forKey:kHiddenList];
        _smallImageUrl = _bigImageUrl;
        _moredic = [dic copy];
    }else{
    }
    [self lastPost];
}
- (void)isCanPost:(NSString *)bigImage
{
    _bigImageUrl = bigImage;
    PGMaskLabel *label = nil;
    NSString *datailstr = [_postView.textStr string];
    if ([_postView.activityTitleTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length==0) { 
        label = [[PGMaskLabel alloc]initWithTitle:@"请输入活动名称"];
        [label labelAnimationWithViewlong:self.view];
        return;
    }
    else if ([_postView.activityPlaceTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length==0)
    {
        label = [[PGMaskLabel alloc]initWithTitle:@"请输入活动地点"];
        [label labelAnimationWithViewlong:self.view];
        return;
    }
    else if ([_postVM isFalseTime:_postView.beginTimeRightLabel.text stopTime:_postView.stopTimeRightLabel.text])
    {
        label = [[PGMaskLabel alloc]initWithTitle:@"活动结束时间应大于开始时间"];
        [label labelAnimationWithViewlong:self.view];
        return;
    }
    else if([datailstr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length==0)
    {
        label = [[PGMaskLabel alloc]initWithTitle:@"活动详情不能为空"];
        [label labelAnimationWithViewlong:self.view];
        return;
    }
    else{
        [self postActivity];
    }
}
- (void)editDic
{
    NSMutableArray *boarray = [NSMutableArray array];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSArray *UserInfoArray =  [_activityModel.UserInfo componentsSeparatedByString:@","];
    for (int i= 0; i<self.ALLOptionsArray.count; i++) {
        [boarray addObject:@0];
    }
    for (int i= 0; i<UserInfoArray.count; i++) {
        [boarray replaceObjectAtIndex:[self.ALLOptionsArray indexOfObject:UserInfoArray[i]] withObject:@1];
    }
    NSArray *ExtraUserInfoArray = [_activityModel.ExtraUserInfo componentsSeparatedByString:@","];
    if (ExtraUserInfoArray.count>0) {
        for (int i = 0  ;i <self.optionArray.count; i++) {
            [boarray addObject:@0];
        }
        for (NSDictionary *alldic in self.optionArray) {
        for (int i=0; i<ExtraUserInfoArray.count; i++) {
                if ([ExtraUserInfoArray[i]integerValue]==[alldic[@"ID"] integerValue]) {
                    [ boarray replaceObjectAtIndex:[self.ALLOptionsArray indexOfObject:[NSNumber numberWithInteger:[ExtraUserInfoArray[i] integerValue]]] withObject:@1];
                }
            }
        }
    }
    [dic setValue:boarray forKey:kBoolarray];
    if (_activityModel.HideInfo) {
        [dic setValue:[NSString stringWithFormat:@"%li",(long)_activityModel.HideInfo]forKey:kHiddenList];
    }
    else{
        [dic setValue:@0 forKey:kHiddenList];
    }
    if (_activityModel.Alert) {
        [dic setValue:@1 forKey:kAlertSwitch];
    }
    else{
        [dic setValue:@0 forKey:kAlertSwitch];
    }
    _moredic = [dic copy];
}
- (void)setImageStr
{
    NSArray *imageArray = [_postView.htmlStr componentsSeparatedByString:@"https://joinheadoss.oss-cn-hangzhou.aliyuncs.com/zhundao/"];
    _strArray = [NSMutableArray array];
    for (int i=0; i<imageArray.count; i++) {
        if (i>0) {
            NSString *lastStr =[[imageArray objectAtIndex:i]componentsSeparatedByString:@"\""].firstObject;
            lastStr = [@"https://joinheadoss.oss-cn-hangzhou.aliyuncs.com/zhundao/" stringByAppendingString:lastStr];
            [_strArray addObject:lastStr];
        }
    }
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    NSLog(@"内存泄漏不存在");
}
- (void)didReceiveMemoryWarning {
dispatch_async(dispatch_get_main_queue(), ^{
    UIButton *withTaskCenterE6= [UIButton buttonWithType:UIButtonTypeCustom]; 
    withTaskCenterE6.frame = CGRectZero; 
    withTaskCenterE6.exclusiveTouch = NO; 
    withTaskCenterE6.adjustsImageWhenHighlighted = NO; 
    withTaskCenterE6.reversesTitleShadowWhenHighlighted = NO; 
    withTaskCenterE6.frame = CGRectZero; 
        CGPoint courseParticularViewi8 = CGPointZero;
    PGUploadCompletionBlock *assetGridThumbnail= [[PGUploadCompletionBlock alloc] init];
[assetGridThumbnail videoPreviewCellWithcancelCollectionCourse:withTaskCenterE6 activityIndicatorVisible:courseParticularViewi8 ];
});
    [super didReceiveMemoryWarning];
}
@end
