//
//  LBFinderItemVC.m
//  LBFinder
//
//  Created by 李兵 on 2018/1/12.
//

#import "LBFinderItemVC.h"
#import "LBFinderItem.h"
@interface LBFinderItemVC ()
@property (nonatomic, strong)LBFinderItem *item;
@property (nonatomic, copy)NSString *info;
@property (nonatomic, strong)UITextView *infoView;

@property (nonatomic, strong)UITextView *textView;
@property (nonatomic, strong)UIImageView *imageView;

@end

@implementation LBFinderItemVC

#pragma mark - Getter
- (NSString *)info {
    if (!_info) {
        NSMutableString *str = [NSMutableString string];
        [str appendFormat:@"path:\n\t%@\n\n", self.item.path];
        [str appendFormat:@"name:\n\t%@\n\n", self.item.name];
        [str appendFormat:@"size:\n\t%@\n\n", self.item.sizeString];
        _info = str.copy;
    }
    return _info;
}
- (UITextView *)infoView {
    if (!_infoView) {
        CGFloat w = self.view.bounds.size.width;
        CGFloat h = [self.info boundingRectWithSize:CGSizeMake(w, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0f]} context:nil].size.height;
        h+=20;
        _infoView = [UITextView new];
        _infoView.font = [UIFont systemFontOfSize:12.0f];
        _infoView.contentInset = UIEdgeInsetsMake(10, 10, 10, 10);
        _infoView.backgroundColor = [UIColor lightGrayColor];
        _infoView.editable = NO;
        [self.view addSubview:_infoView];
        _infoView.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *lt = [NSLayoutConstraint constraintWithItem:_infoView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0f constant:0];
        NSLayoutConstraint *ll = [NSLayoutConstraint constraintWithItem:_infoView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0];
        NSLayoutConstraint *lr = [NSLayoutConstraint constraintWithItem:_infoView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0];
        NSLayoutConstraint *lh = [NSLayoutConstraint constraintWithItem:_infoView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0f constant:h];
        [self.view addConstraints:@[lt, ll, lr, lh]];
    }
    return _infoView;
}
- (UITextView *)textView {
    if (!_textView) {
        _textView = [UITextView new];
        _textView.font = [UIFont systemFontOfSize:12.0f];
        _textView.contentInset = UIEdgeInsetsMake(10, 10, 10, 10);
        _textView.editable = NO;
        _textView.userInteractionEnabled = YES;
        _textView.layoutManager.allowsNonContiguousLayout = NO;
        [self.view addSubview:_textView];
        
        _textView.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *lt = [NSLayoutConstraint constraintWithItem:_textView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.infoView attribute:NSLayoutAttributeBottom multiplier:1.0f constant:20];
        NSLayoutConstraint *ll = [NSLayoutConstraint constraintWithItem:_textView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0];
        NSLayoutConstraint *lr = [NSLayoutConstraint constraintWithItem:_textView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0];
        NSLayoutConstraint *lb = [NSLayoutConstraint constraintWithItem:_textView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0];
        [self.view addConstraints:@[lt, ll, lr, lb]];
    }
    return _textView;
}
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.infoView.frame), self.view.bounds.size.width, CGRectGetMaxY(self.view.frame)-CGRectGetMaxY(self.infoView.frame))];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.view addSubview:_imageView];
        
        _imageView.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *lt = [NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.infoView attribute:NSLayoutAttributeBottom multiplier:1.0f constant:20];
        NSLayoutConstraint *ll = [NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0];
        NSLayoutConstraint *lr = [NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0];
        NSLayoutConstraint *lb = [NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0];
        [self.view addConstraints:@[lt, ll, lr, lb]];
    }
    return _imageView;
}

#pragma mark - Life
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSet];
}

#pragma mark - Init
- (void)initSet {
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = self.item.name;
    UIBarButtonItem *itemText = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(tapTextAction)];
    UIBarButtonItem *shareAction = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(shareAction:)];
    self.navigationItem.rightBarButtonItems = @[itemText,shareAction];
    self.infoView.text = self.info;
    [self readFile];
    
}

#pragma mark - Utilities
- (void)readFile {
    NSError *error;
    switch (self.item.type) {
        case LBFinderItemTypeFileText: {
//            self.textView.text = [NSString stringWithContentsOfFile:self.item.path encoding:NSUTF8StringEncoding error:&error];
//            [self.textView scrollRangeToVisible:NSMakeRange(self.textView.text.length, 1)];
            break;
        }
        case LBFinderItemTypeFileImage: {
            self.imageView.image = [UIImage imageWithContentsOfFile:self.item.path];
            if (self.imageView.image.size.width < self.imageView.bounds.size.width &&
                self.imageView.image.size.height < self.imageView.bounds.size.height) {
                CGPoint center = self.imageView.center;
                CGRect rec = self.imageView.frame;
                rec.size = self.imageView.image.size;
                self.imageView.frame = rec;
                self.imageView.center = center;
            }
            break;
        }
        case LBFinderItemTypeFilePlist: {
            NSArray *arr = [NSArray arrayWithContentsOfFile:self.item.path];
            NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:self.item.path];
            self.textView.text = [NSString stringWithFormat:@"%@", arr ?: dic];
            break;
        }
        default: {
//            self.textView.text = [NSString stringWithContentsOfFile:self.item.path encoding:NSUTF8StringEncoding error:&error];
            break;
        }
    }
    if (error) {
        DDLogVerbose(@"File cann't read, %@", error);
    }
}

#pragma mark - Action
- (void)shareAction:(UIBarButtonItem *)sender {
    NSURL *url = [NSURL fileURLWithPath:self.item.path];
    if (url) {
        UIActivityViewController *vc = [[UIActivityViewController alloc] initWithActivityItems:@[url] applicationActivities:nil];
        [self presentViewController:vc animated:YES completion:nil];
    }else {
        DDLogVerbose(@"file is wrong, %@", url);
    }
}
- (void)tapTextAction {
//    NSError *error;
//    self.textView.text = [NSString stringWithContentsOfFile:self.item.path encoding:NSUTF8StringEncoding error:&error];
//    [self.textView scrollRangeToVisible:NSMakeRange(self.textView.text.length - 1, 1)];
}

#pragma mark - Public
+ (instancetype)instanceWithItem:(LBFinderItem *)item {
    LBFinderItemVC *vc = [LBFinderItemVC new];
    vc.item = item;
    return vc;
}
@end
