//
//  MapViewController.m
//  zhundao
//
//  Created by zhundao on 2017/4/20.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "MapViewController.h"
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import <MAMapKit/MAMapKit.h>
#import "AMapTipAnnotation.h"  //这是 高德2d地图demo中的私有文件
#define DefaultLocationTimeout  6 //定位超时时间
#define DefaultReGeocodeTimeout 3 //逆定理定位超时时间
@interface MapViewController ()<MAMapViewDelegate,AMapLocationManagerDelegate,AMapSearchDelegate,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate, UISearchResultsUpdating>
@property(nonatomic,strong)AMapSearchAPI *search ; //周边搜索类方法实例对象
@property(nonatomic,strong)MAMapView *mapView;   //地图
@property(nonatomic,strong)CLLocation *currentLocation; //当前位置
@property(nonatomic,strong)NSMutableArray *dataArray; //存放名称 即cell的TextLabel 的text
@property(nonatomic,strong)NSMutableArray *subDataArray; //存放地址 即cell的detailTextLabel 的text
@property(nonatomic,strong)UITableView *tableview;
@property (nonatomic, strong) AMapLocationManager *locationManager;//地图管理单例类，初始化之前请设置 APIKey
@property (nonatomic, strong) UISearchController *searchController;  //顶部搜索框
@property (nonatomic, copy) AMapLocatingCompletionBlock completionBlock;  //逆定理定位回调

@property(nonatomic,strong)NSMutableArray *longDataArray;   //纬度的数组
@property(nonatomic,strong)NSMutableArray *latDataArray;    //经度的数组
@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [self initMapViews];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(returnAction)];//自定义返回
     [self initSearchController];
    [self.view addSubview:self.tableview];
    
    [self initCompleteBlock];
    
    [self configLocationManager];
    
    [self checkLocation];
    
//    [self.view setBackgroundColor:ZDBackgroundColor];
    // Do any additional setup after loading the view.
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.searchController.active = NO;
    self.navigationItem.titleView = nil;
}
#pragma 初始化
- (void)initSearchController
{
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil]; //初始化搜索框，nil表示在本视图控制器中展示
    self.searchController.searchBar.frame = CGRectMake(0, -10, kScreenWidth - 200, 30);
    self.searchController.searchResultsUpdater = self;  //UISearchResultsUpdating
    self.searchController.dimsBackgroundDuringPresentation = NO;  //搜索时,背景变暗色
    self.searchController.hidesNavigationBarDuringPresentation = NO; //隐藏导航栏
    self.searchController.searchBar.delegate = self; //UISearchBarDelegate
    self.searchController.searchBar.placeholder = @"请输入关键字";
    [self.searchController.searchBar sizeToFit];   //搜索框自适应
    
    self.navigationItem.titleView = self.searchController.searchBar; // 将搜索框显示在导航栏标题视图处
    if (self.latitude) {
        CLLocation *loca = [[CLLocation alloc]initWithLatitude:_latitude longitude:_longitude];
        _currentLocation = [loca copy];
    }
}
- (void)initMapViews
{
    _mapView = [[MAMapView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight/2)];
    _mapView.compassOrigin = CGPointMake(_mapView.compassOrigin.x, 22); //指南针位置
    _mapView.scaleOrigin= CGPointMake(_mapView.scaleOrigin.x, 22); //比例尺位置
    _mapView.delegate =self;  //MAMapViewDelegate
    _mapView.desiredAccuracy = kCLLocationAccuracyBest; //设置定位精度
    _mapView.showsCompass = NO;   //是否显示指南针罗盘
    _mapView.zoomLevel = 16.3;   // 地图缩放等级
    _mapView.zoomEnabled = YES;  //是否支持缩放 默认yes
     _mapView.userTrackingMode = MAUserTrackingModeFollow;//跟随用户移动
    _mapView.showsUserLocation = YES;
    _mapView.mapType = MAMapTypeStandard; //地图样式为普通地图。  还有卫星地图
    _mapView.language = MAMapLanguageZhCN; //地图的语言
    [self.view addSubview:_mapView];
    
}
- (void)initCompleteBlock  //逆地理定位完成回调
{
    __weak MapViewController *weakSelf = self;
    self.completionBlock = ^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error)
    {
        if (error != nil && error.code == AMapLocationErrorLocateFailed)
        {
            //定位错误：此时location和regeocode没有返回值，不进行annotation的添加
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
            //逆地理错误：在带逆地理的单次定位中，逆地理过程可能发生错误，此时location有返回值，regeocode无返回值，进行annotation的添加
            NSLog(@"逆地理错误:{%ld - %@};", (long)error.code, error.localizedDescription);
        }
        else
        {
            //没有错误：location有返回值，regeocode是否有返回值取决于是否进行逆地理操作，进行annotation的添加
        }
        
        //根据定位信息，添加annotation
        MAPointAnnotation *annotation = [[MAPointAnnotation alloc] init];
        [annotation setCoordinate:location.coordinate];
        
        //有无逆地理信息，annotationView的标题显示的字段不一样
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
    //设置期望定位精度
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    //设置定位超时时间
    [self.locationManager setLocationTimeout:DefaultLocationTimeout];
    //设置逆地理超时时间
    [self.locationManager setReGeocodeTimeout:DefaultReGeocodeTimeout];
    //设置不允许系统暂停定位
    [self.locationManager setPausesLocationUpdatesAutomatically:NO];

    //设置允许连续定位逆地理
    [self.locationManager setLocatingWithReGeocode:YES];
    [self.locationManager startUpdatingLocation];  //开始连续定位
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        MAPointAnnotation *annotation = [[MAPointAnnotation alloc] init];
        [annotation setCoordinate:_currentLocation.coordinate];//设置标注
//        [self cleanUpAction];  //0.5s后关闭定位 ，开连续定位不开单次是因为发现高德开单次定位地图的定位速度很慢，而连续定位秒开启。
    });
}




- (void)cleanUpAction {
    //停止定位
    [self.locationManager stopUpdatingLocation];
    [self.locationManager setDelegate:nil];
    [self.mapView removeAnnotations:self.mapView.annotations]; //移除标注
}
- (void)dealloc
{
    [self cleanUpAction];
    self.completionBlock = nil;
}




#pragma mark - MAMapViewDelegate
- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode
{
    if (!self.latitude) {
        _currentLocation = [location copy]; //设置当前位置
    }
    [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(_currentLocation.coordinate.latitude, _currentLocation.coordinate.longitude)];  //设置地图中心坐标
    [self searchAround]; //在当前位置搜索周边
}
- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view //选择定位的位置显示位置
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
    [self searchAround];
}
#pragma  发起逆地理编码
- (void)initAction
{
    if (_currentLocation) {
        AMapReGeocodeSearchRequest *requset = [[AMapReGeocodeSearchRequest alloc]init];
        requset.location = [AMapGeoPoint locationWithLatitude:_currentLocation.coordinate.latitude longitude:_currentLocation.coordinate.longitude]; //经度和纬度
        [self searchLocationWithCoordinate2D:_currentLocation.coordinate];
    }
}

- (void)searchLocationWithCoordinate2D:(CLLocationCoordinate2D )coordinate {
    //构造AMapReGeocodeSearchRequest对象
    AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
    regeo.location = [AMapGeoPoint locationWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    regeo.radius = 10000;
    regeo.requireExtension = YES;
    //发起逆地理编码
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:self.completionBlock];
}

#pragma  输入提示 搜索
- (void)searchTipsWithKey:(NSString *)key //搜索框搜索
{
    if (key.length == 0) //长度为0不搜索
    {
        return;
    }
    AMapInputTipsSearchRequest *tips = [[AMapInputTipsSearchRequest alloc] init];
    tips.keywords = key;
    //    tips.cityLimit = YES; 是否限制城市
    [self.search AMapInputTipsSearch:tips];  //输入提示查询接口
}
- (void)onInputTipsSearchDone:(AMapInputTipsSearchRequest *)request response:(AMapInputTipsSearchResponse *)response  //输入提示查询回调函数
{
    if (response.count == 0)  //如果没搜索到结果，则使用之前的数据显示tableview
    {
        return;
    }
    else{ // 如果有结果 ，现删除之前的所有数据
        if (self.dataArray) {
            [self.dataArray removeAllObjects];
            [self.subDataArray removeAllObjects];
            [self.latDataArray removeAllObjects];
            [self.longDataArray removeAllObjects];
        }
    }
    
    
    
    
    
    for (AMapTip *tip in response.tips) { //添加数据 ，最多50条
        [self.dataArray addObject:tip.name];
        [self.subDataArray addObject:tip.address];
        [self.longDataArray addObject:[NSString stringWithFormat:@"%lf",tip.location.longitude]];
        [self.latDataArray addObject:[NSString stringWithFormat:@"%lf",tip.location.latitude]];
        if (_dataArray.count>=50) {
            return;
        }
    }
    [self clearAndShowAnnotationWithTip:response.tips.firstObject]; //清除标注，切换地图
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
    /* 清除annotations & overlays */
    [self clear];
 /* 可以直接在地图打点  */
        AMapTipAnnotation *annotation = [[AMapTipAnnotation alloc] initWithMapTip:tip];
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
- (void)searchAround {
    AMapPOIAroundSearchRequest *Request = [[AMapPOIAroundSearchRequest alloc]init];
    Request.location = [AMapGeoPoint locationWithLatitude:self.currentLocation.coordinate.latitude longitude:self.currentLocation.coordinate.longitude];
    Request.types = @"道路附属设施|地名地址信息|公共设施|风景名胜|商务住宅|政府机构及社会团体";
    Request.sortrule = 0; //排序 0 为距离排序
    Request.requireExtension = YES;//是否返回扩展信息
    [self.search AMapPOIAroundSearch: Request];
}
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response{
    NSLog(@"周边搜索回调");
    if(response.pois.count == 0)
    {
        return;
    }
    else{ // 如果有结果 ，现删除之前的所有数据
        if (self.dataArray) {
            [self.dataArray removeAllObjects];
            [self.subDataArray removeAllObjects];
            [self.latDataArray removeAllObjects];
            [self.longDataArray removeAllObjects];
        }
    }
    NSArray *responseArray = [NSMutableArray arrayWithArray:response.pois];
//    AMapPOI *poi = [[AMapPOI alloc]init];
    for (AMapPOI *pod in responseArray) {
        [self.dataArray addObject:pod.name]; //取搜索出来的名称
        [self.subDataArray addObject:pod.address]; //取搜索出来的地址
        [self.longDataArray addObject:[NSString stringWithFormat:@"%lf",pod.location.longitude]];
        [self.latDataArray addObject:[NSString stringWithFormat:@"%lf",pod.location.latitude]];
        if (_dataArray.count>=50) {
            return;
        }
    }
    // 周边搜索完成后，刷新tableview
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

- (void)checkLocation {
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied ||   [CLLocationManager authorizationStatus] == kCLAuthorizationStatusRestricted || ![CLLocationManager locationServicesEnabled]) {
        [self openPositioning]; /*打开定位开关*/
    }
}

#pragma mark 定位开关关闭，询问是否打开开关
- (void)openPositioning{
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
