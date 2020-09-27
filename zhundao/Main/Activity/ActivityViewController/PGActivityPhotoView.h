#import <UIKit/UIKit.h>
@protocol PhotoViewDelegate <NSObject>
-(void)tapHiddenPhotoView;
@end
@interface PGActivityPhotoView : UIView
@property(nonatomic,strong)  UIScrollView *scrollView;
@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic, assign) id<PhotoViewDelegate> delegate;
-(id)initWithFrame:(CGRect)frame withPhotoUrl:(NSString *)photoUrl;
-(id)initWithFrame:(CGRect)frame withPhotoImage:(UIImage *)image;
@end
