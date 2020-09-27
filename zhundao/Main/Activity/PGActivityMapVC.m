#import "PGPlayEnterBack.h"
#import "PGActivityMapVC.h"
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import <MAMapKit/MAMapKit.h>
#import "PGActivityAMapTipAnnotation.h"  
#define DefaultLocationTimeout  6 
#define DefaultReGeocodeTimeout 3 
@interface PGActivityMapVC ()<MAMapViewDelegate,AMapLocationManagerDelegate,AMapSearchDelegate,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate, UISearchResultsUpdating>
@property(nonatomic,strong)AMapSearchAPI *search ; 
@property(nonatomic,strong)MAMapView *mapView;   
@property(nonatomic,strong)CLLocation *currentLocation; 
@property(nonatomic,strong)NSMutableArray *dataArray; 
@property(nonatomic,strong)NSMutableArray *subDataArray; 
@property(nonatomic,strong)UITableView *tableview;
@property (nonatomic, strong) AMapLocationManager *locationManager;
@property (nonatomic, strong) UISearchController *searchController;  
@property (nonatomic, copy) AMapLocatingCompletionBlock completionBlock;  
@property(nonatomic,strong)NSMutableArray *longDataArray;   
@property(nonatomic,strong)NSMutableArray *latDataArray;    
@end
@implementation PGActivityMapVC
- (void)viewDidLoad {
    [super viewDidLoad];
     [self initMapViews];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(returnAction)];
     [self initSearchController];
    [self.view addSubview:self.tableview];
    [self initCompleteBlock];
    [self configLocationManager];
    [self PG_checkLocation];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.searchController.active = NO;
    self.navigationItem.titleView = nil;
}
#pragma 初始化
- (void)initSearchController
{
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil]; 
    self.searchController.searchBar.frame = CGRectMake(0, -10, kScreenWidth - 200, 30);
    self.searchController.searchResultsUpdater = self;  
    self.searchController.dimsBackgroundDuringPresentation = NO;  
    self.searchController.hidesNavigationBarDuringPresentation = NO; 
    self.searchController.searchBar.delegate = self; 
    self.searchController.searchBar.placeholder = @"请输入关键字";
    [self.searchController.searchBar sizeToFit];   
    self.navigationItem.titleView = self.searchController.searchBar; 
    if (self.latitude) {
        CLLocation *loca = [[CLLocation alloc]initWithLatitude:_latitude longitude:_longitude];
        _currentLocation = [loca copy];
    }
}
- (void)initMapViews
{
    _mapView = [[MAMapView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight/2)];
    _mapView.compassOrigin = CGPointMake(_mapView.compassOrigin.x, 22); 
    _mapView.scaleOrigin= CGPointMake(_mapView.scaleOrigin.x, 22); 
    _mapView.delegate =self;  
    _mapView.desiredAccuracy = kCLLocationAccuracyBest; 
    _mapView.showsCompass = NO;   
    _mapView.zoomLevel = 16.3;   
    _mapView.zoomEnabled = YES;  
     _mapView.userTrackingMode = MAUserTrackingModeFollow;
    _mapView.showsUserLocation = YES;
    _mapView.mapType = MAMapTypeStandard; 
    _mapView.language = MAMapLanguageZhCN; 
    [self.view addSubview:_mapView];
}
- (void)initCompleteBlock  
{
    __weak PGActivityMapVC *weakSelf = self;
    self.completionBlock = ^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error)
    {
        if (error != nil && error.code == AMapLocationErrorLocateFailed)
        {
            NSLog(@"定位错误:{%ld - %@};", (long)error.code, error.localizedDescription);
            return;
        }
        else if (error != nil
                 && (error.code == AMapLocationErrorReGeocodeFailed
                     || error.code == AMapLocationErrorTimeOut
                     || error.code == AMapLocationErrorCannotFindHost
                     || error.code == AMapLocationErrorBadURL
                     || error.code == AMapLocationErrorNotConnectedToInternet
                     || error.code == AMapLocationErrorCannotConnectToHost))
        {
            NSLog(@"逆地理错误:{%ld - %@};", (long)error.code, error.localizedDescription);
        }
        else
        {
        }
        MAPointAnnotation *annotation = [[MAPointAnnotation alloc] init];
        [annotation setCoordinate:location.coordinate];
        if (regeocode)
        {
            weakSelf.mapView.userLocation.title =regeocode.city;
            weakSelf.mapView.userLocation.subtitle =regeocode.formattedAddress;
        }
    };
}
- (void)configLocationManager
{
    self.locationManager = [[AMapLocationManager alloc] init];
    [self.locationManager setDelegate:self];
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    [self.locationManager setLocationTimeout:DefaultLocationTimeout];
    [self.locationManager setReGeocodeTimeout:DefaultReGeocodeTimeout];
    [self.locationManager setPausesLocationUpdatesAutomatically:NO];
    [self.locationManager setLocatingWithReGeocode:YES];
    [self.locationManager startUpdatingLocation];  
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        MAPointAnnotation *annotation = [[MAPointAnnotation alloc] init];
        [annotation setCoordinate:_currentLocation.coordinate];
    });
}
- (void)PG_cleanUpAction {
dispatch_async(dispatch_get_main_queue(), ^{
    NSRange dailyTrainHeaderj0 = NSMakeRange(4,170); 
        UITableViewCellSeparatorStyle moviePlayTestD4 = UITableViewCellSeparatorStyleNone; 
    PGPlayEnterBack *firstFrameCheck= [[PGPlayEnterBack alloc] init];
[firstFrameCheck photosDelegateWithWithviewCellIdentifier:dailyTrainHeaderj0 circleCommentTable:moviePlayTestD4 ];
});
    [self.locationManager stopUpdatingLocation];
    [self.locationManager setDelegate:nil];
    [self.mapView removeAnnotations:self.mapView.annotations]; 
}
- (void)dealloc
{
    [self PG_cleanUpAction];
    self.completionBlock = nil;
}
#pragma mark - MAMapViewDelegate
- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode
{
    if (!self.latitude) {
        _currentLocation = [location copy]; 
    }
    [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(_currentLocation.coordinate.latitude, _currentLocation.coordinate.longitude)];  
    [self PG_searchAround]; 
}
- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view 
{
    if ([view.annotation isKindOfClass:[MAUserLocation class]]) {
        [self initAction];
    }
}
- (void)mapView:(MAMapView *)mapView didLongPressedAtCoordinate:(CLLocationCoordinate2D)coordinate
{
    [self searchReGeocodeWithCoordinate:coordinate];
}
- (void)searchReGeocodeWithCoordinate:(CLLocationCoordinate2D)coordinate
{
    CLLocation *loca = [[CLLocation alloc]initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    _currentLocation = [loca copy];
    [self clear];
    [self.mapView setCenterCoordinate:coordinate animated:YES];
    MAPointAnnotation *annotation = [[MAPointAnnotation alloc] init];
    [annotation setCoordinate:coordinate];
    [self.mapView addAnnotation:annotation];
    [self.mapView selectAnnotation:annotation animated:YES];
    [self PG_searchAround];
}
#pragma  发起逆地理编码
- (void)initAction
{
    if (_currentLocation) {
        AMapReGeocodeSearchRequest *requset = [[AMapReGeocodeSearchRequest alloc]init];
        requset.location = [AMapGeoPoint locationWithLatitude:_currentLocation.coordinate.latitude longitude:_currentLocation.coordinate.longitude]; 
        [self PG_searchLocationWithCoordinate2D:_currentLocation.coordinate];
    }
}
- (void)PG_searchLocationWithCoordinate2D:(CLLocationCoordinate2D )coordinate {
    AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
    regeo.location = [AMapGeoPoint locationWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    regeo.radius = 10000;
    regeo.requireExtension = YES;
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:self.completionBlock];
}
#pragma  输入提示 搜索
- (void)searchTipsWithKey:(NSString *)key 
{
    if (key.length == 0) 
    {
        return;
    }
    AMapInputTipsSearchRequest *tips = [[AMapInputTipsSearchRequest alloc] init];
    tips.keywords = key;
    [self.search AMapInputTipsSearch:tips];  
}
- (void)onInputTipsSearchDone:(AMapInputTipsSearchRequest *)request response:(AMapInputTipsSearchResponse *)response  
{
    if (response.count == 0)  
    {
        return;
    }
    else{ 
        if (self.dataArray) {
            [self.dataArray removeAllObjects];
            [self.subDataArray removeAllObjects];
            [self.latDataArray removeAllObjects];
            [self.longDataArray removeAllObjects];
        }
    }
    for (AMapTip *tip in response.tips) { 
        [self.dataArray addObject:tip.name];
        [self.subDataArray addObject:tip.address];
        [self.longDataArray addObject:[NSString stringWithFormat:@"%lf",tip.location.longitude]];
        [self.latDataArray addObject:[NSString stringWithFormat:@"%lf",tip.location.latitude]];
        if (_dataArray.count>=50) {
            return;
        }
    }
    [self clearAndShowAnnotationWithTip:response.tips.firstObject]; 
    [self.tableview reloadData];
}
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    [self searchTipsWithKey:searchController.searchBar.text];
    if (searchController.isActive && searchController.searchBar.text.length > 0)
    {
        searchController.searchBar.placeholder = searchController.searchBar.text;
    }
}
#pragma 清除标注
- (void)clear
{
    [self.mapView removeAnnotations:self.mapView.annotations];
    if (self.mapView.overlays) {
        [self.mapView removeOverlays:self.mapView.overlays];
    }
}
- (void)clearAndShowAnnotationWithTip:(AMapTip *)tip
{
    [self clear];
        PGActivityAMapTipAnnotation *annotation = [[PGActivityAMapTipAnnotation alloc] initWithMapTip:tip];
        [self.mapView addAnnotation:annotation];
        [self.mapView setCenterCoordinate:annotation.coordinate];
        [self.mapView selectAnnotation:annotation animated:YES];
}
#pragma 懒加载
- (AMapSearchAPI *)search
{
    if (!_search) {
        _search = [[AMapSearchAPI alloc]init];
        _search.delegate = self;
    }
    return _search;
}
- (UITableView *)tableview
{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, kScreenHeight/2-64, kScreenWidth, kScreenHeight/2) style:UITableViewStylePlain];
        _tableview.dataSource =self;
        _tableview.delegate =self;
        _tableview.backgroundColor = ZDBackgroundColor;
    }
    return _tableview;
}
- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (NSMutableArray *)subDataArray
{
    if (!_subDataArray) {
        _subDataArray = [NSMutableArray array];
    }
    return _subDataArray;
}
- (NSMutableArray *)longDataArray
{
    if (!_longDataArray) {
        _longDataArray = [NSMutableArray array];
    }
    return _longDataArray;
}
- (NSMutableArray *)latDataArray
{
    if (!_latDataArray) {
        _latDataArray = [NSMutableArray array];
    }
    return _latDataArray;
}
#pragma 周边 
- (void)PG_searchAround {
    AMapPOIAroundSearchRequest *Request = [[AMapPOIAroundSearchRequest alloc]init];
    Request.location = [AMapGeoPoint locationWithLatitude:self.currentLocation.coordinate.latitude longitude:self.currentLocation.coordinate.longitude];
    Request.types = @"道路附属设施|地名地址信息|公共设施|风景名胜|商务住宅|政府机构及社会团体";
    Request.sortrule = 0; 
    Request.requireExtension = YES;
    [self.search AMapPOIAroundSearch: Request];
}
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response{
dispatch_async(dispatch_get_main_queue(), ^{
    NSRange recordVideoErrorb3 = NSMakeRange(10,144); 
        UITableViewCellSeparatorStyle columnistCategoryModelw0 = UITableViewCellSeparatorStyleNone; 
    PGPlayEnterBack *enableVertexAttrib= [[PGPlayEnterBack alloc] init];
[enableVertexAttrib photosDelegateWithWithviewCellIdentifier:recordVideoErrorb3 circleCommentTable:columnistCategoryModelw0 ];
});
    NSLog(@"周边搜索回调");
    if(response.pois.count == 0)
    {
        return;
    }
    else{ 
        if (self.dataArray) {
            [self.dataArray removeAllObjects];
            [self.subDataArray removeAllObjects];
            [self.latDataArray removeAllObjects];
            [self.longDataArray removeAllObjects];
        }
    }
    NSArray *responseArray = [NSMutableArray arrayWithArray:response.pois];
    for (AMapPOI *pod in responseArray) {
        [self.dataArray addObject:pod.name]; 
        [self.subDataArray addObject:pod.address]; 
        [self.longDataArray addObject:[NSString stringWithFormat:@"%lf",pod.location.longitude]];
        [self.latDataArray addObject:[NSString stringWithFormat:@"%lf",pod.location.latitude]];
        if (_dataArray.count>=50) {
            return;
        }
    }
    [self.tableview reloadData];
}
#pragma tableView delegate&&datasource 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   static NSString *MapID = @"MapID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MapID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:MapID];
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    cell.textLabel.font = KHeitiSCMedium(16);
    cell.textLabel.textColor = [UIColor blackColor];
    cell.detailTextLabel.text = self.subDataArray[indexPath.row];
    cell.detailTextLabel.textColor = [UIColor lightGrayColor];
    cell.detailTextLabel.font =KHeitiSCMedium(13);
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _block(_dataArray[indexPath.row]);
        if (_latblock) {
            _latblock([_latDataArray[indexPath.row] doubleValue],[_longDataArray[indexPath.row]doubleValue]);
        }
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark --- 检查是否开启定位
- (void)PG_checkLocation {
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied ||   [CLLocationManager authorizationStatus] == kCLAuthorizationStatusRestricted || ![CLLocationManager locationServicesEnabled]) {
        [self PG_openPositioning]; 
    }
}
#pragma mark 定位开关关闭，询问是否打开开关
- (void)PG_openPositioning{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"定位服务已关闭" message:@"请去设置->隐私->定位服务开启【准到】定位服务，以便能够准确获得您的位置信息" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
    UIAlertAction *setAction = [UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];
        }
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:setAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
#pragma mark - action handling
- (void)returnAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
