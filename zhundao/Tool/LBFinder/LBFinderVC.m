//
//  LBFinderVC.m
//  LBFinder
//
//  Created by 李兵 on 2018/1/11.
//

#import "LBFinderVC.h"
#import "LBFinderItem.h"
#import "LBFinderItemVC.h"
#import "UIViewController+LBFinder.h"
@interface LBFinderVC ()
@property (nonatomic, strong)LBFinderItem *item;
@property (nonatomic, strong)NSArray <LBFinderItem *> *dataSource;
@end

@implementation LBFinderVC
- (LBFinderItem *)item {
    if(!_item) {
        _item = [LBFinderItem instanceWithPath:NSHomeDirectory()];
    }
    return _item;
}
- (NSArray<LBFinderItem *> *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSet];
}

#pragma mark - Init
- (void)initSet {
    self.navigationItem.title = self.item.name;
    if (self.item.subItems.count > 0) {
        self.dataSource = self.item.subItems;
    }
}



#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:12.0f];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:12.0f];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    LBFinderItem *item = self.dataSource[indexPath.row];
    cell.textLabel.text = item.name;
    if (item.isFolder) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld", (long)item.subItemsCount];
    }else {
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.detailTextLabel.text = item.sizeString;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LBFinderItem *item = self.dataSource[indexPath.row];
    if (item.isFolder) {
        LBFinderVC *vc = [LBFinderVC instanceWithPath:item.path];
        [self lbf_showVC:vc];
    }else {
        LBFinderItemVC *vc = [LBFinderItemVC instanceWithItem:item];
        [self lbf_showVC:vc];
        
    }
}

#pragma mark - Public
+ (instancetype)instanceWithPath:(NSString *)path {
    LBFinderVC *vc = [LBFinderVC new];
    NSString *p = path.length > 0 ? path : NSHomeDirectory();
    vc.item = [LBFinderItem instanceWithPath:p];
    return vc;
}



@end
