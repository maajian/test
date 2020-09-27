#import "PGIntervalSinceDate.h"
#import "PGAvtivityPostView.h"
#import "ActivityModel.h"
#import "NSString+HTML.h"
#import "PGAvtivityPostViewModel.h"
#import "UITextField+textCenter.h"
#import "PGAvtivityPostActivityCell.h"
#import "PGAvtivityPostFooterView.h"
#import "Time.h"
#import "PGAvtivityCCDatePickerView.h"
@interface PGAvtivityPostView()<UIGestureRecognizerDelegate,UITableViewDelegate,UITableViewDataSource,ZDAvtivityFooterDelegate>
@property(nonatomic,strong)      UIImageView *bigImageView;
@property(nonatomic,strong)      UIButton *changeButton;
@property(nonatomic,strong)      UILabel *beginTimeLeftLabel;
@property(nonatomic,strong)      UILabel *stopTimeLeftLabel;
@property(nonatomic,strong)      UILabel *startTimeLeftLabel;
@property(nonatomic,strong)      UILabel *endTimeLeftLabel;
@property(nonatomic,strong)      UILabel *activityTitleLabel;
@property(nonatomic,strong)      UILabel *activityPlaceLabel;
@property(nonatomic,strong)      UIButton *locationButton;
@property(nonatomic,strong)      UILabel *activityNumberLabel;
@property(nonatomic,strong)      UILabel *activityFeeLeftLabel;
@property(nonatomic,strong)      UILabel *moreLabel;
@property(nonatomic,strong)     PGAvtivityPostViewModel  *postVM;
@property(nonatomic,strong)     ActivityModel *activityModel;
@property(nonatomic,assign)          NSInteger gradeID; 
@property(nonatomic,copy)       NSArray  *imageArray;
@end
@implementation PGAvtivityPostView
- (instancetype)initWithModel :(ActivityModel *)activityModel{
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight-64);
        if ([[  NSUserDefaults standardUserDefaults  ]objectForKey:@"GradeId"]) {
            self.gradeID =  [[[  NSUserDefaults standardUserDefaults  ]objectForKey:@"GradeId"]integerValue];
        }
        _activityModel = activityModel;
        _postVM = [[PGAvtivityPostViewModel alloc]init];
        [self getImage];
        [self addSubview:self.tableview];
        [self datasourceGesAction];
    }
    return self;
}
-(UITableView *)tableview
{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) style:UITableViewStyleGrouped];
        _tableview.delegate = self;
        _tableview.dataSource =self;
    }
    return _tableview;
}
- (WKWebView *)textview
{
    if (!_textview) {
        _textview = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
        if (_activityModel) {
            [_textview loadHTMLString:_activityModel.Content baseURL:nil];
            _htmlStr = [_activityModel.Content copy];
            NSAttributedString *attstr = [NSString strToAttriWithStr:_htmlStr];
            NSLog(@"attstr = %@",attstr);
            _textStr = [attstr copy];
        }
    }
    return  _textview;
}
- (UIImageView *)bigImageView{
    if (!_bigImageView) {
        _bigImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 250)];
    }
    return _bigImageView;
}
- (UIButton *)changeButton{
    if (!_changeButton) {
        _changeButton = [MyButton initWithButtonFrame:CGRectMake(kScreenWidth-80, 210, 70, 30) title:@"编辑封面" textcolor:kColorA(70, 70, 70, 1) Target:self action:@selector(PG_imgChange) BackgroundColor:kColorA(250, 250, 250, 1) cornerRadius:5 masksToBounds:1];
        _changeButton.titleLabel.font = KweixinFont(13);
    }
    return _changeButton;
}
- (UILabel *)beginTimeLeftLabel
{
    if (!_beginTimeLeftLabel) {
        _beginTimeLeftLabel = [MyLabel initWithLabelFrame:CGRectMake(10, 0, 70, 44) Text:@"开始时间" textColor:[UIColor blackColor] font:KHeitiSCMedium(15) textAlignment:NSTextAlignmentLeft cornerRadius:0 masksToBounds:0];
    }
    return _beginTimeLeftLabel;
}
- (UILabel *)beginTimeRightLabel
{
    if (!_beginTimeRightLabel) {
        _beginTimeRightLabel = [MyLabel initWithLabelFrame:CGRectMake(85, 0, kScreenWidth-85, 44) Text:[_postVM beginTime:_activityModel] textColor:[UIColor blackColor] font:KHeitiSCMedium(15) textAlignment:NSTextAlignmentLeft cornerRadius:0 masksToBounds:0];
    }
    return _beginTimeRightLabel;
}
- (UILabel *)activityTitleLabel
{
    if (!_activityTitleLabel) {
        _activityTitleLabel =[MyLabel initWithLabelFrame:CGRectMake(10, 0, 70, 44) Text:@"活动名称" textColor:[UIColor blackColor] font:KHeitiSCMedium(15) textAlignment:NSTextAlignmentLeft cornerRadius:0 masksToBounds:0];
    }
    return _activityTitleLabel;
}
- (UITextField *)activityTitleTextField
{
    if (!_activityTitleTextField) {
        _activityTitleTextField = [myTextField initWithFrame:CGRectMake(85, 0, kScreenWidth-85, 44) placeholder:@"请输入活动名称" font:KHeitiSCMedium(15) TextAlignment:NSTextAlignmentLeft textColor:[UIColor blackColor]];
        if (_activityModel) {
            _activityTitleTextField.text = _activityModel.Title;
        }
        else{
            [_activityTitleTextField initWithString:@"请输入活动名称" font:KHeitiSCMedium(15)];
        }
    }
    return  _activityTitleTextField;
}
- (UILabel *)startTimeLeftLabel{
    if (!_startTimeLeftLabel) {
        _startTimeLeftLabel =[MyLabel initWithLabelFrame:CGRectMake(10, 0, 70, 44) Text:@"报名开始" textColor:[UIColor blackColor] font:KHeitiSCMedium(15) textAlignment:NSTextAlignmentLeft cornerRadius:0 masksToBounds:0];
    }
    return _startTimeLeftLabel;
}
- (UILabel *)startTimeRightLabel{
    if (!_startTimeRightLabel) {
        _startTimeRightLabel =[MyLabel initWithLabelFrame:CGRectMake(85, 0, kScreenWidth-85, 44) Text:[_postVM startTime:_activityModel] textColor:[UIColor blackColor] font:KHeitiSCMedium(15) textAlignment:NSTextAlignmentLeft cornerRadius:0 masksToBounds:0];
    }
    return _startTimeRightLabel;
}
- (UILabel *)endTimeLeftLabel
{
    if (!_endTimeLeftLabel) {
        _endTimeLeftLabel = [MyLabel initWithLabelFrame:CGRectMake(10, 0, 70, 44) Text:@"报名截止" textColor:[UIColor blackColor] font:KHeitiSCMedium(15) textAlignment:NSTextAlignmentLeft cornerRadius:0 masksToBounds:0];
    }
    return _endTimeLeftLabel;
}
- (UILabel *)endTimeRightLabel
{
    if (!_endTimeRightLabel) {
        _endTimeRightLabel = [MyLabel initWithLabelFrame:CGRectMake(85, 0, kScreenWidth-85, 44) Text:[_postVM endTime:_activityModel] textColor:[UIColor blackColor] font:KHeitiSCMedium(15) textAlignment:NSTextAlignmentLeft cornerRadius:0 masksToBounds:0];
    }
    return _endTimeRightLabel;
}
- (UILabel *)stopTimeLeftLabel
{
    if (!_stopTimeLeftLabel) {
        _stopTimeLeftLabel =[MyLabel initWithLabelFrame:CGRectMake(10, 0, 70, 44) Text:@"结束时间" textColor:[UIColor blackColor] font:KHeitiSCMedium(15) textAlignment:NSTextAlignmentLeft cornerRadius:0 masksToBounds:0];
    }
    return _stopTimeLeftLabel;
}
- (UILabel *)stopTimeRightLabel
{
    if (!_stopTimeRightLabel) {
        _stopTimeRightLabel =  [MyLabel initWithLabelFrame:CGRectMake(85, 0, kScreenWidth-85, 44) Text:[_postVM stopTime:_activityModel] textColor:[UIColor blackColor] font:KHeitiSCMedium(15) textAlignment:NSTextAlignmentLeft cornerRadius:0 masksToBounds:0];
    }
    return _stopTimeRightLabel;
}
- (UILabel *)activityPlaceLabel
{
    if (!_activityPlaceLabel) {
        _activityPlaceLabel = [MyLabel initWithLabelFrame:CGRectMake(10, 0, 70, 44) Text:@"活动地点" textColor:[UIColor blackColor] font:KHeitiSCMedium(15) textAlignment:NSTextAlignmentLeft cornerRadius:0 masksToBounds:0];
    }
    return _activityPlaceLabel;
}
- (UITextField *)activityPlaceTextField
{
    if (!_activityPlaceTextField) {
        _activityPlaceTextField =[myTextField initWithFrame:CGRectMake(85, 0, kScreenWidth-150, 44) placeholder:@"请输入活动地点" font:KHeitiSCMedium(15) TextAlignment:NSTextAlignmentLeft textColor:[UIColor blackColor]];
        if (_activityModel) {
            _activityPlaceTextField.text = _activityModel.Address;
        }
        else{
            [_activityPlaceTextField initWithString:@"请输入活动地点" font:KHeitiSCMedium(15)];
        }
    }
    return  _activityPlaceTextField;
}
- (UIButton *)locationButton
{
    if (!_locationButton) {
        _locationButton = [MyButton initWithButtonFrame:CGRectMake(kScreenWidth-65, 7, 50, 30) title:@"定位" textcolor:[UIColor blackColor] Target:self action:@selector(PG_locationAction) BackgroundColor:kColorA(244, 244, 244, 1) cornerRadius:5 masksToBounds:YES];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:@"定位"];
        [str  addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(0, 2)];
        [_locationButton setAttributedTitle:str forState:UIControlStateNormal];
    }
    return _locationButton;
}
- (UILabel *)moreLabel
{
    if (!_moreLabel) {
        _moreLabel = [MyLabel initWithLabelFrame:CGRectMake(10, 0, 70, 44) Text:@"更多选项" textColor:ZDMainColor font:KHeitiSCMedium(15) textAlignment:NSTextAlignmentLeft cornerRadius:0 masksToBounds:0];
    }
    return _moreLabel;
}
- (UILabel *)activityFeeLeftLabel
{
    if (!_activityFeeLeftLabel) {
        _activityFeeLeftLabel =[MyLabel initWithLabelFrame:CGRectMake(10, 0, 70, 44) Text:@"活动费用" textColor:[UIColor blackColor] font:KHeitiSCMedium(15) textAlignment:NSTextAlignmentLeft cornerRadius:0 masksToBounds:0];
    }
    return _activityFeeLeftLabel;
}
- (UILabel *)activityFeeRightLabel
{
    if (!_activityFeeRightLabel) {
        if (_activityModel) {
            if (_activityModel.Fee==0) {
                [self createFeeLabelWithText:@"未设置,默认免费"];
            }
            else{
                [self createFeeLabelWithText:@"已设置"];
                _feeArray = [_postVM getFeeArrayNotDelete:_activityModel];
            }
        }
        else
        {
            [self createFeeLabelWithText:@"未设置,默认免费"];
        }
    }
    return _activityFeeRightLabel;
}
- (void)createFeeLabelWithText :(NSString *)text
{
    _activityFeeRightLabel =[MyLabel initWithLabelFrame:CGRectMake(85, 0, kScreenWidth-115, 44) Text:text textColor:kColorA(199, 199, 205, 1) font:KHeitiSCMedium(15) textAlignment:NSTextAlignmentRight cornerRadius:0 masksToBounds:0];
}
- (UILabel *)activityNumberLabel
{
    if (!_activityNumberLabel) {
        _activityNumberLabel =[MyLabel initWithLabelFrame:CGRectMake(10, 0, 70, 44) Text:@"活动人数" textColor:[UIColor blackColor] font:KHeitiSCMedium(15) textAlignment:NSTextAlignmentLeft cornerRadius:0 masksToBounds:0];
    }
    return _activityNumberLabel;
}
- (UITextField *)activityNumbertField
{
    if (!_activityNumbertField) {
        _activityNumbertField = [myTextField initWithFrame:CGRectMake(85, 0, kScreenWidth-105, 44) placeholder:@"默认不限" font:KHeitiSCMedium(15) TextAlignment:NSTextAlignmentRight textColor:[UIColor blackColor]];
        _activityNumbertField.keyboardType = UIKeyboardTypeNumberPad;
        if (_activityModel) {
            if (_activityModel.UserLimit ==0) {
                [_activityNumbertField initWithString:@"默认不限" font:KHeitiSCMedium(15)];
            }else
            {
                _activityNumbertField.text = [NSString stringWithFormat:@"%li",(long)_activityModel.UserLimit];
            }
        }
        else{
            [_activityNumbertField initWithString:@"默认不限" font:KHeitiSCMedium(15)];
        }
    }
    return _activityNumbertField;
}
#pragma mark uitableviewDatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 7;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 2:{
            if (_gradeID>2) {
                return 4;
            }else{
                return 3;
            }
        }
            break;
        case 5:
            return 2;
            break;
        default:
            return 1;
            break;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PGAvtivityPostActivityCell *cell = [PGAvtivityPostActivityCell cellAllocWithTableView:tableView WithIndexPath:indexPath];
    if (indexPath.section==0) {
        [cell.contentView addSubview:self.bigImageView];
        [cell.contentView addSubview:self.changeButton];
         [_bigImageView sd_setImageWithURL:[NSURL URLWithString:_bigImageStr] placeholderImage:[UIImage imageNamed:@"logogray"]];
    }
   else if (indexPath.section==1) {
        [cell.contentView addSubview:self.activityTitleTextField];
        [cell.contentView addSubview:self.activityTitleLabel];
    }
    else if (indexPath.section==2)
    {
        if (indexPath.row==0) {
            [cell.contentView addSubview:self.beginTimeLeftLabel];
            [cell.contentView addSubview:self.beginTimeRightLabel];
        }
        else if (indexPath.row==1)
        {
            [cell.contentView addSubview:self.stopTimeRightLabel];
            [cell.contentView addSubview:self.stopTimeLeftLabel];
        }
        else if (indexPath.row==2)
        {
            if (_gradeID>2) {
                [cell.contentView addSubview:self.startTimeLeftLabel];
                [cell.contentView addSubview:self.startTimeRightLabel];
            }else{
                [cell.contentView addSubview:self.endTimeRightLabel];
                [cell.contentView addSubview:self.endTimeLeftLabel];
            }
        }
        else{
            [cell.contentView addSubview:self.endTimeRightLabel];
            [cell.contentView addSubview:self.endTimeLeftLabel];
        }
    }
    else if(indexPath.section==3){
        [  cell.contentView addSubview:self.activityPlaceLabel];
        [cell.contentView addSubview:self.activityPlaceTextField];
        [cell.contentView addSubview:self.locationButton];
    }
    else if(indexPath.section==4)
    {
        [cell.contentView addSubview:self.textview];
        self.textview.backgroundColor = [UIColor clearColor];
    }
    else if(indexPath.section==5)
    {
        if (indexPath.row==0) {
            [cell.contentView addSubview:self.activityNumbertField];
            [cell.contentView addSubview:self.activityNumberLabel];
        }
        else
        {
            [cell.contentView addSubview:self.activityFeeRightLabel];
            [cell.contentView addSubview:self.activityFeeLeftLabel];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    else{
        [cell.contentView addSubview:self.moreLabel];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
#pragma uitableviewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            return 250;
            break;
        case 4:
            return 100;
            break;
        default:
            return 44;
            break;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 0.1;
            break;
        case 4:
            return 30;
            break;
        default:
            return 10;
            break;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    switch (section) {
        case 6:
            return 150;
            break;
        default:
            return 0.1;
            break;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==6) {
        if ([self.ZDAvtivityPostDelegate respondsToSelector:@selector(pushMoreChoose)]) {
            [self.ZDAvtivityPostDelegate pushMoreChoose];
        }
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==4) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 30)];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 80, 30)];
        [view addSubview:label];
        label.text = @"活动详情";
        label.textColor =[UIColor grayColor];
        label.font = KHeitiSCLight(13);
        return view;
    }
    else{
        return nil;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    switch (section) {
        case 6:
        {
            PGAvtivityPostFooterView *footer = [[PGAvtivityPostFooterView alloc]init];
            footer.footerDelegate = self;
            return  footer;
        }
            break;
        default:return nil;
            break;
    }
}
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}
#pragma mark datasourceGesAction加手势
- (void)datasourceGesAction
{
    self.endTimeRightLabel.userInteractionEnabled = YES;
    self.stopTimeRightLabel.userInteractionEnabled = YES;
    self.beginTimeRightLabel.userInteractionEnabled = YES;
    self.activityFeeRightLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *stopTimeTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showStopTimePick)];
    [self.stopTimeRightLabel addGestureRecognizer:stopTimeTap];
    UITapGestureRecognizer *endtimeTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showEndTimePick)];
    [self.endTimeRightLabel addGestureRecognizer:endtimeTap];
    UITapGestureRecognizer *startTimeTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showStartTimePick)];
    [self.beginTimeRightLabel addGestureRecognizer:startTimeTap];
    UITapGestureRecognizer *startTimeTap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(PG_showApplyStartTimePick)];
    [self.startTimeRightLabel addGestureRecognizer:startTimeTap1];
    UITapGestureRecognizer *activityFeeTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(PG_pushToFee)];
    [self.activityFeeRightLabel addGestureRecognizer:activityFeeTap];
    UITapGestureRecognizer *webtap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(edit)];
    webtap.delegate =self;
    [self.textview addGestureRecognizer:webtap];
}
#pragma mark ---时间选择器
-(void)showStopTimePick
{
    NSDate *date = [[Time alloc]getDateFromStr:_stopTimeRightLabel.text];
    PGAvtivityCCDatePickerView *dateView = [[PGAvtivityCCDatePickerView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) WithStr:@"选择活动结束时间" withDate:date];
    [self addSubview:dateView];
    dateView.blcok = ^(NSDate *dateString){
        NSString *datestr = [NSString stringWithFormat:@"%ld-%02ld-%02ld %02ld:%02ld",(long)dateString.year,(long)dateString.month,(long)dateString.day,(long)dateString.hour,(long)dateString.minute];
        self.stopTimeRightLabel.text = datestr;
    };
    [dateView fadeIn];
}
-(void)showEndTimePick
{
    NSDate *date = [[Time alloc]getDateFromStr:_endTimeRightLabel.text];
    PGAvtivityCCDatePickerView *dateView = [[PGAvtivityCCDatePickerView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) WithStr:@"选择活动截止时间" withDate:date];
    [self addSubview:dateView];
    dateView.blcok = ^(NSDate *dateString){
        NSString *datestr = [NSString stringWithFormat:@"%ld-%02ld-%02ld %02ld:%02ld",(long)dateString.year,(long)dateString.month,(long)dateString.day,(long)dateString.hour,(long)dateString.minute];
        self.endTimeRightLabel.text = datestr;
    };
    [dateView fadeIn];
}
-(void)showStartTimePick
{
    NSDate *date = [[Time alloc]getDateFromStr:_beginTimeRightLabel.text];
    PGAvtivityCCDatePickerView *dateView = [[PGAvtivityCCDatePickerView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) WithStr:@"选择活动开始时间" withDate:date];
    [self addSubview:dateView];
    dateView.blcok = ^(NSDate *dateString){
        NSString *datestr = [NSString stringWithFormat:@"%ld-%02ld-%02ld %02ld:%02ld",(long)dateString.year,(long)dateString.month,(long)dateString.day,(long)dateString.hour,(long)dateString.minute];
        self.beginTimeRightLabel.text = datestr;
    };
    [dateView fadeIn];
}
- (void)PG_showApplyStartTimePick{
    NSDate *date = [[Time alloc]getDateFromStr:_startTimeRightLabel.text];
    PGAvtivityCCDatePickerView *dateView = [[PGAvtivityCCDatePickerView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) WithStr:@"选择报名开始时间" withDate:date];
    [self addSubview:dateView];
    dateView.blcok = ^(NSDate *dateString){
        NSString *datestr = [NSString stringWithFormat:@"%ld-%02ld-%02ld %02ld:%02ld",(long)dateString.year,(long)dateString.month,(long)dateString.day,(long)dateString.hour,(long)dateString.minute];
        self.startTimeRightLabel.text = datestr;
    };
    [dateView fadeIn];
}
#pragma  mark --- 获取图片
- (void)getImage{
    [_postVM getImage:^(id responseObject) {
        NSArray *Array = [NSArray arrayWithArray:responseObject];
        _imageArray = [Array copy];
        NSDictionary *Dic = Array.firstObject;
        NSArray *listArray = Dic[@"List"];
        if (!_bigImageStr) {
            NSDictionary *firstImageDic = listArray.firstObject;
            _bigImageStr = firstImageDic[@"Link"];
        }
        [_bigImageView sd_setImageWithURL:[NSURL URLWithString:_bigImageStr] placeholderImage:[UIImage imageNamed:@"logogray"]];
    } error:^(NSError *error) {
        [[PGSignManager shareManager]showNotHaveNet:self];
    }];
}
#pragma mark --- 回调
- (void)pushToXieyi{
    if ([self.ZDAvtivityPostDelegate respondsToSelector:@selector(pushXieYi)]) {
        [self.ZDAvtivityPostDelegate pushXieYi];
    }
}
- (void)post{
    if ([self.ZDAvtivityPostDelegate respondsToSelector:@selector(isCanPost:)]) {
        [self.ZDAvtivityPostDelegate isCanPost:_bigImageStr];
    }
}
- (void)PG_pushToFee{
dispatch_async(dispatch_get_main_queue(), ^{
    UITextView *taskCenterCelle5= [[UITextView alloc] initWithFrame:CGRectMake(171,153,22,119)]; 
    taskCenterCelle5.editable = NO; 
    taskCenterCelle5.font = [UIFont systemFontOfSize:193];
    taskCenterCelle5.text = @"underlinePatternSolid";
        NSString *withProgressViewT1 = @"reusableAnnotationView";
    PGIntervalSinceDate *photoSelectableWith= [[PGIntervalSinceDate alloc] init];
[photoSelectableWith chooseCityCellWithwillLayoutSubviews:taskCenterCelle5 tableViewCell:withProgressViewT1 ];
});
    if ([self.ZDAvtivityPostDelegate respondsToSelector:@selector(pushFee)]) {
        [self.ZDAvtivityPostDelegate pushFee];
    }
}
- (void)edit{
    if ([self.ZDAvtivityPostDelegate respondsToSelector:@selector(pushEdit)]) {
        [self.ZDAvtivityPostDelegate pushEdit];
    }
}
- (void)PG_locationAction{
    if ([self.ZDAvtivityPostDelegate respondsToSelector:@selector(pushLocation)]) {
        [self.ZDAvtivityPostDelegate pushLocation];
    }
}
- (void)PG_imgChange{
    if ([self.ZDAvtivityPostDelegate respondsToSelector:@selector(changeBigImage:)]) {
        [self.ZDAvtivityPostDelegate changeBigImage:_imageArray];
    }
}
@end
