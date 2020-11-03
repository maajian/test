#import "PGLocationHeaderView.h"
#import "PGActivityOneConsultVC.h"
#import "PGActivityOneConsultTableViewCell.h"
#import "PGActivityOneConsultViewModel.h"
@interface PGActivityOneConsultVC ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)PGActivityOneConsultViewModel *oneVM;
@property(nonatomic,assign)float cellHeight;
@property(nonatomic,assign)float textViewHeight;
@property(nonatomic,copy)NSString *answerStr ;
@property(nonatomic,assign)BOOL isCommand;
@end
@implementation PGActivityOneConsultVC
- (void)viewDidLoad {
dispatch_async(dispatch_get_main_queue(), ^{
    NSTextAlignment imageSourceCopyJ4 = NSTextAlignmentCenter; 
        UITableViewStyle supportedWindowLevely7 = UITableViewStylePlain; 
    PGLocationHeaderView *gradeCollectionView= [[PGLocationHeaderView alloc] init];
[gradeCollectionView assetExportPresetWithlocationViewModel:imageSourceCopyJ4 imageWithLeft:supportedWindowLevely7 ];
});
    [super viewDidLoad];
    [self baseSetting];
}
#pragma mark ---------
- (void)baseSetting
{
    self.title = @"咨询回复";
    if (_model.Answer) {
        _answerStr = _model.Answer;
    }else{
        _answerStr = @"";
    }
    _textViewHeight = 60 ;
    _isCommand = _model.IsRecommend;
    self.view.backgroundColor = ZDBackgroundColor;
     _cellHeight =  [self.oneVM getHeight:_model.Question width:(0.88 *kScreenWidth-50)];
    [self.view addSubview:self.tableView];
}
#pragma mark 懒加载
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) style:UITableViewStyleGrouped];
        _tableView.delegate =self;
        _tableView.dataSource =self;
        _tableView.estimatedRowHeight = 44;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.backgroundColor = ZDBackgroundColor;
    }
    return _tableView;
}
- (PGActivityOneConsultViewModel *)oneVM{
    if (!_oneVM) {
        _oneVM = [[PGActivityOneConsultViewModel alloc]init];
    }
    return _oneVM;
}
#pragma mark -------UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PGActivityOneConsultTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"oneConsultID"];
    if (!cell) {
        cell = [[PGActivityOneConsultTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"oneConsultID"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.height = _cellHeight;
    cell.tag = indexPath.section;
    cell.timeStr = _timeStr;
    cell.model = self.model;
    cell.textView.delegate = self;
    [cell.mySwitch addTarget:self action:@selector(switchChange:) forControlEvents:UIControlEventValueChanged];
    return cell;
}
#pragma mark -------UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if(section==2) return 100;
    else return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) return 30;
    else return 15;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if(section==2) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
        view.backgroundColor = ZDBackgroundColor;
        UIButton *button = [MyButton initWithButtonFrame:CGRectMake(10, 20, kScreenWidth-20, 44) title:@"确认" textcolor:[UIColor whiteColor] Target:self action:@selector(postConsult) BackgroundColor:ZDMainColor cornerRadius:5 masksToBounds:1];
        [view addSubview:button];
        return view;
    }
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
        view.backgroundColor = ZDBackgroundColor;
        UILabel *label = [MyLabel initWithLabelFrame:CGRectMake(10, 0, kScreenWidth-20, 30) Text:_model.Title textColor:ZDHeaderTitleColor font:[UIFont systemFontOfSize:12] textAlignment:NSTextAlignmentLeft cornerRadius:0 masksToBounds:0];
        [view addSubview:label];
        return view;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return _cellHeight+72;
    }else if (indexPath.section==1)
    {
        return _textViewHeight;
    }else{
        return 44;
    }
}
#pragma mark textdelegate
- (void)textViewDidBeginEditing:(UITextView *)textView{
    if ([textView.text isEqualToString:@"请输入要回复的内容"]) {
        textView.text = @"";
    }
    textView.textColor = [UIColor blackColor];
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    if (textView.text.length<1) {
        textView.text = @"请输入要回复的内容";
        textView.textColor = [UIColor lightGrayColor];
    }else{
        _answerStr = textView.text;
    }
}
#pragma mark -----开关的点击
- (void)switchChange:(UISwitch *)myswitch
{
    _isCommand = myswitch.on;
}
#pragma mark -----发送咨询
- (void)postConsult
{
    [self.view endEditing:YES];
    __weak typeof(self) weakSelf = self;
    MBProgressHUD *hud = [PGMyHud initWithAnimationType:MBProgressHUDAnimationFade showAnimated:YES UIView:self.view];
    if ([_answerStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length>0) {
        [self.oneVM postData:_model.ID answer:_answerStr IsRecommend:_isCommand postBlock:^(BOOL isSuccess) {
            [hud hideAnimated:YES];
            if (isSuccess) {
                MBProgressHUD *hud1 = [PGMyHud initWithMode:MBProgressHUDModeCustomView labelText:@"发送成功" showAnimated:YES UIView:self.view imageName:@"img_public_signin_check"];
                [hud1 hideAnimated:YES afterDelay:1.5];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                });
            }else{
                PGMaskLabel *label = [[PGMaskLabel alloc]initWithTitle:@"发送失败"];
                [label labelAnimationWithViewlong:weakSelf.view];
            }
        }];
    }else{
        PGMaskLabel *label = [[PGMaskLabel alloc]initWithTitle:@"内容不能为空"];
        [label labelAnimationWithViewlong:self.view];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end