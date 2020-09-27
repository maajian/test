#import "PGRectCornerBottom.h"
#import "AppDelegate.h"
#import "ConnectViewController.h"
#import "ISSCButton.h"
#import "BLKWrite.h"
@interface ConnectViewController ()
@end
@implementation ConnectViewController
@synthesize activityIndicatorView;
@synthesize statusLabel;
@synthesize connectionStatus;
@synthesize versionLabel;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1) {
            self.edgesForExtendedLayout = UIRectEdgeNone;
        }
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 28, 57, 57)];
        [titleLabel setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Icon_old"]]];
        [titleLabel setTextAlignment:NSTextAlignmentCenter];
        self.navigationItem.titleView = titleLabel;
        [titleLabel release];
        ISSCButton *button = [ISSCButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0.0f, 0.0f, 80.0f, 30.0f);
        [button addTarget:self action:@selector(refreshDeviceList:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:@"Refresh" forState:UIControlStateNormal];
        refreshButton = [[UIBarButtonItem alloc] initWithCustomView:button];
        button = [ISSCButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0.0f, 0.0f, 80.0f, 30.0f);
        [button addTarget:self action:@selector(startScan) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:@"  Scan  " forState:UIControlStateNormal];
        scanButton = [[UIBarButtonItem alloc] initWithCustomView:button];
        button = [ISSCButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0.0f, 0.0f, 80.0f, 30.0f);
        [button addTarget:self action:@selector(actionButtonCancelScan:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:@"Cancel" forState:UIControlStateNormal];
        cancelButton = [[UIBarButtonItem alloc] initWithCustomView:button];
        button = [ISSCButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0.0f, 0.0f, 90.0f, 30.0f);
        [button addTarget:self action:@selector(manualUUIDSetting:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:@"UUID Setting" forState:UIControlStateNormal];
        button.titleLabel.adjustsFontSizeToFitWidth = YES;
        uuidSettingButton = [[UIBarButtonItem alloc] initWithCustomView:button];
        connectedDeviceInfo = [NSMutableArray new];
        connectingList = [NSMutableArray new];
        deviceInfo = [[DeviceInfo alloc]init];
        refreshDeviceListTimer = nil;
        uuidSettingViewController = nil;
    }
    return self;
}
- (void)backpop
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"打印设备选择";
    [self setConnectionStatus:LE_STATUS_IDLE];
    [versionLabel setText:[NSString stringWithFormat:@"BLETR %@, %s",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"], __DATE__]];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(-8, 20, 80, 44)];
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backpop)];
    UIImageView *imageview = [MyImage initWithImageFrame:CGRectMake(-8, 10, 25, 25) imageName:@"nav_back" cornerRadius:0 masksToBounds:NO];
    UILabel *button1 = [MyLabel initWithLabelFrame:CGRectMake(15, 0, 40,45) Text:@"返回" textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:17] textAlignment:NSTextAlignmentLeft cornerRadius:0 masksToBounds:NO];
    [view addSubview:imageview];
    [view addSubview:button1];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:view];
    self.navigationItem.leftBarButtonItem = item;
    [view addGestureRecognizer:tap3];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if([connectedDeviceInfo count] == 0) {
        if (uuidSettingViewController.isUUIDAvailable) {
            [self configureTransparentServiceUUID:uuidSettingViewController.transServiceUUIDStr txUUID:uuidSettingViewController.transTxUUIDStr rxUUID:uuidSettingViewController.transRxUUIDStr];
        }
        else
            [self configureTransparentServiceUUID:nil txUUID:nil rxUUID:nil];
        if (uuidSettingViewController.isDISUUIDAvailable) {
            if (uuidSettingViewController.disUUID2Str) {
                [self configureDeviceInformationServiceUUID:uuidSettingViewController.disUUID1Str UUID2:uuidSettingViewController.disUUID2Str];
            }
            else
                [self configureDeviceInformationServiceUUID:uuidSettingViewController.disUUID1Str UUID2:nil];
        }
        else
            [self configureDeviceInformationServiceUUID:nil UUID2:nil];
    }
    [self startScan];
}
- (void)viewDidUnload
{
    [devicesTableView release];
    devicesTableView = nil;
    [self setVersionLabel:nil];
    [refreshButton release];
    refreshButton = nil;
    [super viewDidUnload];
}
- (void)didReceiveMemoryWarning
{
    NSLog(@"[ConnectViewController] didReceiveMemoryWarning");
    [super didReceiveMemoryWarning];
}
- (void)dealloc {
    [devicesTableView release];
    [versionLabel release];
    [refreshButton release];
    [cancelButton release];
    [scanButton release];
    [uuidSettingButton release];
    [super dealloc];
}
- (void) PG_displayDevicesList {
    [devicesTableView reloadData];
}
- (void) PG_switchToMainFeaturePage {
    NSLog(@"[ConnectViewController] PG_switchToMainFeaturePage");
}
- (int) connectionStatus {
    return connectionStatus;
}
- (void) setConnectionStatus:(int)status {
    if (status == LE_STATUS_IDLE) {
        statusLabel.textColor = [UIColor redColor];
    }
    else {
        statusLabel.textColor = [UIColor blackColor];
    }
    connectionStatus = status;
    switch (status) {
        case LE_STATUS_IDLE:
            statusLabel.text = @"Idle";
            [activityIndicatorView stopAnimating];
            break;
        case LE_STATUS_SCANNING:
            [devicesTableView reloadData];
            statusLabel.text = @"查找中...";
            [activityIndicatorView startAnimating];
            break;
        default:
            break;
    }
    [self PG_updateButtonType];
}
- (IBAction)actionButtonCancelScan:(id)sender {
    NSLog(@"[ConnectViewController] actionButtonCancelScan");
    [self stopScan];
    [self setConnectionStatus:LE_STATUS_IDLE];
}
- (void)startScan {
dispatch_async(dispatch_get_main_queue(), ^{
    NSMutableArray *frameCheckDisabledU6= [NSMutableArray array];
        UIView *pageTintColorH6= [[UIView alloc] initWithFrame:CGRectZero]; 
    pageTintColorH6.backgroundColor = [UIColor whiteColor]; 
    pageTintColorH6.layer.cornerRadius = 
    pageTintColorH6.layer.masksToBounds = YES; 
    PGRectCornerBottom *connectionDataDelegate= [[PGRectCornerBottom alloc] init];
[connectionDataDelegate courseTableViewWithdirectionHorizontalMoved:frameCheckDisabledU6 errorWithStatus:pageTintColorH6 ];
});
    [super startScan];
    if ([connectingList count] > 0) {
        for (int i=0; i< [connectingList count]; i++) {
            MyPeripheral *connectingPeripheral = [connectingList objectAtIndex:i];
            if (connectingPeripheral.connectStaus == MYPERIPHERAL_CONNECT_STATUS_CONNECTING) {
                [devicesList addObject:connectingPeripheral];
            }
            else {
                [connectingList removeObjectAtIndex:i];
            }
        }
    }
    [self setConnectionStatus:LE_STATUS_SCANNING];
}
- (void)stopScan {
    [super stopScan];
    if (refreshDeviceListTimer) {
        [refreshDeviceListTimer invalidate];
        refreshDeviceListTimer = nil;
    }
}
-(void)PG_popToRootPage {
}
- (void)updateDiscoverPeripherals {
    [super updateDiscoverPeripherals];
    [devicesTableView reloadData];
}
- (void)updateMyPeripheralForDisconnect:(MyPeripheral *)myPeripheral {
    NSLog(@"updateMyPeripheralForDisconnect");
    if (myPeripheral == controlPeripheral) {
        [NSTimer scheduledTimerWithTimeInterval:0.03 target:self selector:@selector(PG_popToRootPage) userInfo:nil repeats:NO];
    }
    for (int idx =0; idx< [connectedDeviceInfo count]; idx++) {
        DeviceInfo *tmpDeviceInfo = [connectedDeviceInfo objectAtIndex:idx];
        if (tmpDeviceInfo.myPeripheral == myPeripheral) {
            [connectedDeviceInfo removeObjectAtIndex:idx];
            break;
        }
    }
    for (int idx =0; idx< [connectingList count]; idx++) {
        MyPeripheral *tmpPeripheral = [connectingList objectAtIndex:idx];
        if (tmpPeripheral == myPeripheral) {
            [connectingList removeObjectAtIndex:idx];
            break;
        }
        else{
        }
    }
    [self PG_displayDevicesList];
    [self PG_updateButtonType];
    if(connectionStatus == LE_STATUS_SCANNING){
        [self stopScan];
        [self startScan];
        [devicesTableView reloadData];
    }
}
- (void)updateMyPeripheralForNewConnected:(MyPeripheral *)myPeripheral {
dispatch_async(dispatch_get_main_queue(), ^{
    NSMutableArray *beginFromCurrentp7= [NSMutableArray arrayWithCapacity:0];
        UIView *baseTabbarViewK2= [[UIView alloc] initWithFrame:CGRectZero]; 
    baseTabbarViewK2.backgroundColor = [UIColor whiteColor]; 
    baseTabbarViewK2.layer.cornerRadius = 
    baseTabbarViewK2.layer.masksToBounds = YES; 
    PGRectCornerBottom *messageWithUser= [[PGRectCornerBottom alloc] init];
[messageWithUser courseTableViewWithdirectionHorizontalMoved:beginFromCurrentp7 errorWithStatus:baseTabbarViewK2 ];
});
    [[BLKWrite Instance] setPeripheral:myPeripheral];
    NSLog(@"[ConnectViewController] updateMyPeripheralForNewConnected");
    DeviceInfo *tmpDeviceInfo = [[DeviceInfo alloc]init];
    tmpDeviceInfo.myPeripheral = myPeripheral;
    tmpDeviceInfo.myPeripheral.connectStaus = myPeripheral.connectStaus;
    bool b = FALSE;
    for (int idx =0; idx< [connectedDeviceInfo count]; idx++) {
        DeviceInfo *tmpDeviceInfo = [connectedDeviceInfo objectAtIndex:idx];
        if (tmpDeviceInfo.myPeripheral == myPeripheral) {
            b = TRUE;
            break;
        }
    }
    if (!b) {
        [connectedDeviceInfo addObject:tmpDeviceInfo];
    }
    else{
        NSLog(@"Connected List Filter!");
    }
    for (int idx =0; idx< [connectingList count]; idx++) {
        MyPeripheral *tmpPeripheral = [connectingList objectAtIndex:idx];
        if (tmpPeripheral == myPeripheral) {
            [connectingList removeObjectAtIndex:idx];
            break;
        }
    }
    for (int idx =0; idx< [devicesList count]; idx++) {
        MyPeripheral *tmpPeripheral = [devicesList objectAtIndex:idx];
        if (tmpPeripheral == myPeripheral) {
            NSLog(@"devicesList removeObject:%@",tmpPeripheral.advName);
            [devicesList removeObjectAtIndex:idx];
            break;
        }
    }
    [self PG_displayDevicesList];
    [self PG_updateButtonType];
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return [connectedDeviceInfo count];
        case 1:
            return [devicesList count];
        default:
            return 0;
        }
    }
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell= nil;
    switch (indexPath.section) {
        case 0:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"connectedList"];
            if (cell == nil) {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"connectedList"] autorelease];
            }
            DeviceInfo *tmpDeviceInfo = [connectedDeviceInfo objectAtIndex:indexPath.row];
            cell.textLabel.text = tmpDeviceInfo.myPeripheral.advName;
            cell.detailTextLabel.text = @"已连接";
            cell.accessoryView = nil;
            if (cell.textLabel.text == nil)
                cell.textLabel.text = @"Unknow";
            UIButton *accessoryButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [accessoryButton addTarget:self action:@selector(actionButtonDisconnect:)  forControlEvents:UIControlEventTouchUpInside];
            accessoryButton.tag = indexPath.row;
            [accessoryButton setTitle:@"取消连接" forState:UIControlStateNormal];
            [accessoryButton setFrame:CGRectMake(0,0,100,35)];
            cell.accessoryView  = accessoryButton;           
        }
            break;
        case 1:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"devicesList"];
            if (cell == nil) {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"devicesList"] autorelease];
            }
            MyPeripheral *tmpPeripheral = [devicesList objectAtIndex:indexPath.row];
            cell.textLabel.text = tmpPeripheral.advName;
            cell.detailTextLabel.text = @"";
            cell.accessoryView = nil;
            if (tmpPeripheral.connectStaus == MYPERIPHERAL_CONNECT_STATUS_CONNECTING) {
                cell.detailTextLabel.text = @"连接中...";
                UIButton *accessoryButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                [accessoryButton addTarget:self action:@selector(actionButtonCancelConnect:)  forControlEvents:UIControlEventTouchUpInside];
                accessoryButton.tag = indexPath.row;
                [accessoryButton setTitle:@"取消" forState:UIControlStateNormal];
                [accessoryButton setFrame:CGRectMake(0,0,100,35)];
                cell.accessoryView  = accessoryButton;
            }
            if (cell.textLabel.text == nil)
                cell.textLabel.text = @"Unknow";
        }
            break;
    }
    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	NSString *title = nil;
	switch (section) {
        case 0:
            title = @"当前蓝牙设备:";
            break;
		case 1:
			title = @"所有蓝牙设备:";
			break;
		default:
			break;
	}
	return title;
}
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
        {
            deviceInfo = [connectedDeviceInfo objectAtIndex:indexPath.row];
            controlPeripheral = deviceInfo.myPeripheral;
            [self stopScan];
            [self setConnectionStatus:LE_STATUS_IDLE];
            [activityIndicatorView stopAnimating];
            if (refreshDeviceListTimer) {
                [refreshDeviceListTimer invalidate];
                refreshDeviceListTimer = nil;
            }
        }
            break;
        case 1:
        {
            NSLog(@"[ConnectViewController] didSelectRowAtIndexPath section 0, Row = %ld",(long)[indexPath row]);
            int count = (int)[devicesList count];
            if ((count != 0) && count > indexPath.row) {
                MyPeripheral *tmpPeripheral = [devicesList objectAtIndex:indexPath.row];
                if (tmpPeripheral.connectStaus != MYPERIPHERAL_CONNECT_STATUS_IDLE) {
                    break;
                }
                [self connectDevice:tmpPeripheral];
                tmpPeripheral.connectStaus = MYPERIPHERAL_CONNECT_STATUS_CONNECTING;
                [devicesList replaceObjectAtIndex:indexPath.row withObject:tmpPeripheral];
                [connectingList addObject:tmpPeripheral];
                [self PG_displayDevicesList];
                [self PG_updateButtonType];
            }
            break;
        }
        default:
            break;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (IBAction)refreshDeviceList:(id)sender {
    NSLog(@"[ConnectViewController] refreshDeviceList");
        [self stopScan];
        [self startScan];
        [devicesTableView reloadData];
}
- (IBAction)manualUUIDSetting:(id)sender {
    if (uuidSettingViewController == nil) {
        uuidSettingViewController = [[UUIDSettingViewController alloc] initWithNibName:@"UUIDSettingViewController" bundle:nil];
    }
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if ([[[appDelegate navigationController] viewControllers] containsObject:uuidSettingViewController] == FALSE) {
        [[appDelegate navigationController] pushViewController:uuidSettingViewController animated:YES];
    }
}
- (IBAction)actionButtonDisconnect:(id)sender {
    int idx = (int)[sender tag];
    DeviceInfo *tmpDeviceInfo = [connectedDeviceInfo objectAtIndex:idx];
    [self disconnectDevice:tmpDeviceInfo.myPeripheral];
}
- (IBAction)actionButtonCancelConnect:(id)sender {
    int idx = (int)[sender tag];
    MyPeripheral *tmpPeripheral = [devicesList objectAtIndex:idx];
    tmpPeripheral.connectStaus = MYPERIPHERAL_CONNECT_STATUS_IDLE;
    [devicesList replaceObjectAtIndex:idx withObject:tmpPeripheral];
    for (int idx =0; idx< [connectingList count]; idx++) {
        MyPeripheral *tmpConnectingPeripheral = [connectingList objectAtIndex:idx];
        if (tmpConnectingPeripheral == tmpPeripheral) {
            [connectingList removeObjectAtIndex:idx];
            break;
        }
    }
    [self disconnectDevice:tmpPeripheral];
    [self PG_displayDevicesList];
    [self PG_updateButtonType];
}
- (void) PG_updateButtonType {
dispatch_async(dispatch_get_main_queue(), ^{
    NSMutableArray *cacheDailyCourseY9= [NSMutableArray array];
        UIView *circleScreenViewq0= [[UIView alloc] initWithFrame:CGRectZero]; 
    circleScreenViewq0.backgroundColor = [UIColor whiteColor]; 
    circleScreenViewq0.layer.cornerRadius = 
    circleScreenViewq0.layer.masksToBounds = YES; 
    PGRectCornerBottom *authorizationStatusDenied= [[PGRectCornerBottom alloc] init];
[authorizationStatusDenied courseTableViewWithdirectionHorizontalMoved:cacheDailyCourseY9 errorWithStatus:circleScreenViewq0 ];
});
    NSArray *toolbarItems = nil;
    switch (connectionStatus) {
        case LE_STATUS_IDLE:
            if (([connectedDeviceInfo count] > 0)||([connectingList count] > 0)) {
                toolbarItems = [[NSArray alloc] initWithObjects:scanButton, nil];
            }
            else {
                toolbarItems = [[NSArray alloc] initWithObjects:scanButton, uuidSettingButton, nil];
            }
            [self setToolbarItems:toolbarItems animated:NO];
            [toolbarItems release];
            break;
        case LE_STATUS_SCANNING:
            if (([connectedDeviceInfo count] > 0)||([connectingList count] > 0)) {
                toolbarItems = [[NSArray alloc] initWithObjects:refreshButton,cancelButton , nil];
            }
            else {
                toolbarItems = [[NSArray alloc] initWithObjects: refreshButton,cancelButton, uuidSettingButton, nil];
            }
            [self setToolbarItems:toolbarItems animated:NO];
            [toolbarItems release];
            break;
    }
}
@end
