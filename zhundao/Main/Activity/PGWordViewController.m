#import "PGImageAlphaPremultiplied.h"
#import "PGWordViewController.h"
#import "PGWordView.h"
#import "PGSegmentedControl.h"
#import "PGStyleSettingsController.h"
#import "PGImageSettingsController.h"
#import "PGTextStyle.h"
#import "PGParagraphConfig.h"
#import "NSTextAttachment+LMText.h"
#import "UIFont+LMText.h"
#import "PGTextHTMLParser.h"
@interface PGWordViewController () <UITextViewDelegate, UITextFieldDelegate, PGSegmentedControlDelegate, PGStyleSettingsControllerDelegate, PGImageSettingsControllerDelegate>
@property (nonatomic, assign) CGFloat keyboardSpacingHeight;
@property (nonatomic, strong) PGSegmentedControl *contentInputAccessoryView;
@property (nonatomic, readonly) UIStoryboard *lm_storyboard;
@property (nonatomic, strong) PGStyleSettingsController *styleSettingsViewController;
@property (nonatomic, strong) PGImageSettingsController *imageSettingsViewController;
@property (nonatomic, assign) CGFloat inputViewHeight;
@property (nonatomic, strong) PGTextStyle *currentTextStyle;
@property (nonatomic, strong) PGParagraphConfig *currentParagraphConfig;
@end
@implementation PGWordViewController
{
    NSRange _lastSelectedRange;
    BOOL _keepCurrentTextStyle;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *items = @[
                       [UIImage imageNamed:@"keyboard.png"],
                       [UIImage imageNamed:@"img_public_cc_font"],
                       [UIImage imageNamed:@"insertImage.png"],
                       [UIImage imageNamed:@"link.png"],
                       [UIImage imageNamed:@"img_public_bottom_move"]
                       ];
    _contentInputAccessoryView = [[PGSegmentedControl alloc] initWithItems:items];
    _contentInputAccessoryView.delegate = self;
    _contentInputAccessoryView.changeSegmentManually = YES;
    _textView = [[PGWordView alloc] init];
    _textView.delegate = self;
    _textView.titleTextField.delegate = self;
    [self.view addSubview:_textView];
    [self setCurrentParagraphConfig:[[PGParagraphConfig alloc] init]];
    [self setCurrentTextStyle:[PGTextStyle textStyleWithType:LMTextStyleFormatNormal]];
    [self PG_updateParagraphTypingAttributes];
    [self PG_updateTextStyleTypingAttributes];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(PG_keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(PG_keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    [_contentInputAccessoryView addTarget:self action:@selector(PG_changeTextInputView:) forControlEvents:UIControlEventValueChanged];
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self PG_layoutTextView];
    CGRect rect = self.view.bounds;
    rect.size.height = 40.f;
    self.contentInputAccessoryView.frame = rect;
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [_textView becomeFirstResponder];
}
- (void)PG_layoutTextView {
    CGRect rect = self.view.bounds;
    rect.origin.y = [self.topLayoutGuide length];
    rect.size.height -= rect.origin.y;
    self.textView.frame = rect;
    UIEdgeInsets insets = self.textView.contentInset;
    insets.bottom = self.keyboardSpacingHeight;
    self.textView.contentInset = insets;
}
#pragma mark - Keyboard
- (void)PG_keyboardWillShow:(NSNotification *)notification {
dispatch_async(dispatch_get_main_queue(), ^{
    UIColor *playerStatusPauseM2= [UIColor redColor];
        NSTextAlignment locationStyleReuseA2 = NSTextAlignmentCenter; 
    PGImageAlphaPremultiplied *activeShaderProgram= [[PGImageAlphaPremultiplied alloc] init];
[activeShaderProgram assetResourceTypeWithbottomShareView:playerStatusPauseM2 calendarUnitYear:locationStyleReuseA2 ];
});
    NSDictionary *info = [notification userInfo];
    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    if (self.keyboardSpacingHeight == keyboardSize.height) {
        return;
    }
    self.keyboardSpacingHeight = keyboardSize.height;
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        [self PG_layoutTextView];
    } completion:nil];
}
- (void)PG_keyboardWillHide:(NSNotification *)notification {
    if (self.keyboardSpacingHeight == 0) {
        return;
    }
    self.keyboardSpacingHeight = 0;
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        [self PG_layoutTextView];
    } completion:nil];
}
#pragma mark - <UITextViewDelegate>
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.text.length == 0) {
        textField.text = textField.placeholder;
    }
    self.textView.editable = NO;
    [textField resignFirstResponder];
    self.textView.editable = YES;
    return YES;
}
#pragma mark - <UITextViewDelegate>
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    [self.contentInputAccessoryView setSelectedSegmentIndex:0 animated:NO];
    _textView.inputAccessoryView = self.contentInputAccessoryView;
    [self.imageSettingsViewController reload];
    return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    _textView.inputAccessoryView = nil;
    return YES;
}
- (void)textViewDidChangeSelection:(UITextView *)textView {
    if (_lastSelectedRange.location != textView.selectedRange.location) {
        if (_keepCurrentTextStyle) {
            [self PG_updateTextStyleTypingAttributes];
            [self PG_updateParagraphTypingAttributes];
            _keepCurrentTextStyle = NO;
        }
        else {
            self.currentTextStyle = [self PG_textStyleForSelection];
            self.currentParagraphConfig = [self PG_paragraphForSelection];
            [self PG_updateTextStyleTypingAttributes];
            [self PG_updateParagraphTypingAttributes];
            [self PG_reloadSettingsView];
        }
    }
    _lastSelectedRange = textView.selectedRange;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if (range.location == 0 && range.length == 0 && text.length == 0) {
        self.currentParagraphConfig.indentLevel = 0;
        [self PG_updateParagraphTypingAttributes];
    }
    _lastSelectedRange = NSMakeRange(range.location + text.length - range.length, 0);
    if (text.length == 0 && range.length > 0) {
        _keepCurrentTextStyle = YES;
    }
    return YES;
}
#pragma mark - Change InputView
- (void)insertlink
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"插入超链接" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
        textField.placeholder = @"超链接地址";
    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"超链接标题";
    }];
    __weak typeof(alertController) weakAlertController = alertController;
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSDictionary *attr = self.textView.typingAttributes;
        UITextField *address = weakAlertController.textFields.firstObject;
        UITextField *title = weakAlertController.textFields.lastObject;
        NSError *error;
          NSString *regulaStr = @"\\b[a-zA-Z0-9\\-.]+(?::(\\d+))?(?:(?:/[a-zA-Z0-9\\-._?,'+\\&%$=~*!():@\\\\]*)+)?";
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regulaStr
                                                                               options:NSRegularExpressionCaseInsensitive
                                                                                 error:&error];
        NSUInteger numberOfMatches = [regex numberOfMatchesInString:address.text options:0 range:NSMakeRange(0, [address.text length])];
        if (numberOfMatches ==1) {
            NSDictionary * attris = @{NSLinkAttributeName:[NSURL URLWithString:address.text]};
            NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:title.text];
            [attributedText setAttributes:attris range:NSMakeRange(0,attributedText.length)];
            NSMutableAttributedString *attributedText1 = [[NSMutableAttributedString alloc] initWithAttributedString:self.textView.attributedText];
            [attributedText1 replaceCharactersInRange:_lastSelectedRange withAttributedString:attributedText];
            self.textView.allowsEditingTextAttributes = YES;
            self.textView.attributedText = attributedText1;
            self.textView.allowsEditingTextAttributes = NO;
            [self setCurrentParagraphConfig:[[PGParagraphConfig alloc] init]];
            [self setCurrentTextStyle:[PGTextStyle textStyleWithType:LMTextStyleFormatNormal]];
            self.textView.typingAttributes = attr;
            [self PG_updateParagraphTypingAttributes];
            [self PG_updateTextStyleTypingAttributes];
        }
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (void)lm_segmentedControl:(PGSegmentedControl *)control didTapAtIndex:(NSInteger)index {
dispatch_async(dispatch_get_main_queue(), ^{
    UIColor *courseParticularVideox6= [UIColor redColor];
        NSTextAlignment remoteNotificationsWithx7 = NSTextAlignmentCenter; 
    PGImageAlphaPremultiplied *mainCommentTable= [[PGImageAlphaPremultiplied alloc] init];
[mainCommentTable assetResourceTypeWithbottomShareView:courseParticularVideox6 calendarUnitYear:remoteNotificationsWithx7 ];
});
    if (index == control.numberOfSegments - 1) {
        [self.textView resignFirstResponder];
        return;
    }
    if (index != control.selectedSegmentIndex) {
        [control setSelectedSegmentIndex:index animated:YES];
    }
}
- (UIStoryboard *)lm_storyboard {
    static dispatch_once_t onceToken;
    static UIStoryboard *storyboard;
    dispatch_once(&onceToken, ^{
        storyboard = [UIStoryboard storyboardWithName:@"LMWord" bundle:nil];
    });
    return storyboard;
}
- (PGStyleSettingsController *)styleSettingsViewController {
    if (!_styleSettingsViewController) {
        _styleSettingsViewController = [self.lm_storyboard instantiateViewControllerWithIdentifier:@"style"];
        _styleSettingsViewController.textStyle = self.currentTextStyle;
        _styleSettingsViewController.delegate = self;
    }
    return _styleSettingsViewController;
}
- (PGImageSettingsController *)imageSettingsViewController {
    if (!_imageSettingsViewController) {
        _imageSettingsViewController = [self.lm_storyboard instantiateViewControllerWithIdentifier:@"image"];
        _imageSettingsViewController.delegate = self;
    }
    return _imageSettingsViewController;
}
- (void)PG_changeTextInputView:(PGSegmentedControl *)control {
dispatch_async(dispatch_get_main_queue(), ^{
    UIColor *normalTableViewg8= [UIColor redColor];
        NSTextAlignment trackingWithEventR7 = NSTextAlignmentCenter; 
    PGImageAlphaPremultiplied *secondeMallView= [[PGImageAlphaPremultiplied alloc] init];
[secondeMallView assetResourceTypeWithbottomShareView:normalTableViewg8 calendarUnitYear:trackingWithEventR7 ];
});
    CGRect rect = self.view.bounds;
    rect.size.height = self.keyboardSpacingHeight - CGRectGetHeight(self.contentInputAccessoryView.frame);
    switch (control.selectedSegmentIndex) {
        case 1:
        {
            UIView *inputView = [[UIView alloc] initWithFrame:rect];
            self.styleSettingsViewController.view.frame = rect;
            [inputView addSubview:self.styleSettingsViewController.view];
            self.textView.inputView = inputView;
            break;
        }
        case 2:
        {
            UIView *inputView = [[UIView alloc] initWithFrame:rect];
            self.imageSettingsViewController.view.frame = rect;
            [inputView addSubview:self.imageSettingsViewController.view];
            self.textView.inputView = inputView;
            break;
        }
        case 3:
        {
            [self insertlink];
            [self PG_reloadSettingsView];
            break;
        }
        default:
            self.textView.inputView = nil;
            break;
    }
    [self.textView reloadInputViews];
}
#pragma mark - settings
- (void)PG_reloadSettingsView {
    self.styleSettingsViewController.textStyle = self.currentTextStyle;
    [self.styleSettingsViewController setParagraphConfig:self.currentParagraphConfig];
    [self.styleSettingsViewController reload];
}
- (PGTextStyle *)PG_textStyleForSelection {
    PGTextStyle *textStyle = [[PGTextStyle alloc] init];
    NSLog(@"%@",self.textView.typingAttributes);
    UIFont *font = self.textView.typingAttributes[NSFontAttributeName];
    textStyle.bold = font.bold;
    textStyle.italic = font.italic;
    textStyle.fontSize = font.fontSize;
    textStyle.textColor = self.textView.typingAttributes[NSForegroundColorAttributeName] ?: textStyle.textColor;
    if (self.textView.typingAttributes[NSUnderlineStyleAttributeName]) {
        textStyle.underline = [self.textView.typingAttributes[NSUnderlineStyleAttributeName] integerValue] == NSUnderlineStyleSingle;
    }
    return textStyle;
}
- (PGParagraphConfig *)PG_paragraphForSelection {
    NSParagraphStyle *paragraphStyle = self.textView.typingAttributes[NSParagraphStyleAttributeName];
    LMParagraphType type = [self.textView.typingAttributes[LMParagraphTypeName] integerValue];
    PGParagraphConfig *paragraphConfig = [[PGParagraphConfig alloc] initWithParagraphStyle:paragraphStyle type:type];
    return paragraphConfig;
}
- (NSArray *)PG_rangesOfParagraphForCurrentSelection {
    NSRange selection = self.textView.selectedRange;
    NSInteger location;
    NSInteger length;
    NSInteger start = 0;
    NSInteger end = selection.location;
    NSRange range = [self.textView.text rangeOfString:@"\n"
                                              options:NSBackwardsSearch
                                                range:NSMakeRange(start, end - start)];
    location = (range.location != NSNotFound) ? range.location + 1 : 0;
    start = selection.location + selection.length;
    end = self.textView.text.length;
    range = [self.textView.text rangeOfString:@"\n"
                                      options:0
                                        range:NSMakeRange(start, end - start)];
    length = (range.location != NSNotFound) ? (range.location + 1 - location) : (self.textView.text.length - location);
    range = NSMakeRange(location, length);
    NSString *textInRange = [self.textView.text substringWithRange:range];
    NSArray *components = [textInRange componentsSeparatedByString:@"\n"];
    NSMutableArray *ranges = [NSMutableArray array];
    for (NSInteger i = 0; i < components.count; i++) {
        NSString *component = components[i];
        if (i == components.count - 1) {
            if (component.length == 0) {
                break;
            }
            else {
                [ranges addObject:[NSValue valueWithRange:NSMakeRange(location, component.length)]];
            }
        }
        else {
            [ranges addObject:[NSValue valueWithRange:NSMakeRange(location, component.length + 1)]];
            location += component.length + 1;
        }
    }
    if (ranges.count == 0) {
        return nil;
    }
    return ranges;
}
- (void)PG_updateTextStyleTypingAttributes {
    NSMutableDictionary *typingAttributes = [self.textView.typingAttributes mutableCopy];
    typingAttributes[NSFontAttributeName] = self.currentTextStyle.font;
    typingAttributes[NSForegroundColorAttributeName] = self.currentTextStyle.textColor;
    typingAttributes[NSUnderlineStyleAttributeName] = @(self.currentTextStyle.underline ? NSUnderlineStyleSingle : NSUnderlineStyleNone);
    self.textView.typingAttributes = typingAttributes;
}
- (void)PG_updateParagraphTypingAttributes {
    NSMutableDictionary *typingAttributes = [self.textView.typingAttributes mutableCopy];
    typingAttributes[LMParagraphTypeName] = @(self.currentParagraphConfig.type);
    typingAttributes[NSParagraphStyleAttributeName] = self.currentParagraphConfig.paragraphStyle;
    self.textView.typingAttributes = typingAttributes;
}
- (void)PG_updateTextStyleForSelection {
    if (self.textView.selectedRange.length > 0) {
        [self.textView.textStorage addAttributes:self.textView.typingAttributes range:self.textView.selectedRange];
    }
}
- (void)PG_updateParagraphForSelectionWithKey:(NSString *)key {
    NSRange selectedRange = self.textView.selectedRange;
    NSArray *ranges = [self PG_rangesOfParagraphForCurrentSelection];
    if (!ranges) {
        if (self.currentParagraphConfig.type == 0) {
            NSMutableDictionary *typingAttributes = [self.textView.typingAttributes mutableCopy];
            typingAttributes[NSParagraphStyleAttributeName] = self.currentParagraphConfig.paragraphStyle;
            self.textView.typingAttributes = typingAttributes;
            return;
        }
        ranges = @[[NSValue valueWithRange:NSMakeRange(0, 0)]];
    }
    NSInteger offset = 0;
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithAttributedString:self.textView.attributedText];
    for (NSValue *rangeValue in ranges) {
        NSRange range = NSMakeRange(rangeValue.rangeValue.location + offset, rangeValue.rangeValue.length);
        if ([key isEqualToString:LMParagraphTypeName]) {
            if (self.currentParagraphConfig.type == LMParagraphTypeNone) {
                [attributedText deleteCharactersInRange:NSMakeRange(range.location, 1)];
                offset -= 1;
            }
            else {
                NSTextAttachment *textAttachment = [NSTextAttachment checkBoxAttachment];
                NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:[NSAttributedString attributedStringWithAttachment:textAttachment]];
                [attributedString addAttributes:self.textView.typingAttributes range:NSMakeRange(0, 1)];
                [attributedText insertAttributedString:attributedString atIndex:range.location];
                offset += 1;
            }
        }
        else {
            [attributedText addAttribute:NSParagraphStyleAttributeName value:self.currentParagraphConfig.paragraphStyle range:range];
        }
    }
    if (offset > 0) {
        _keepCurrentTextStyle = YES;
        selectedRange = NSMakeRange(selectedRange.location + 1, selectedRange.length + offset - 1);
    }
    self.textView.allowsEditingTextAttributes = YES;
    self.textView.attributedText = attributedText;
    self.textView.allowsEditingTextAttributes = NO;
    self.textView.selectedRange = selectedRange;
}
- (NSTextAttachment *)PG_insertImage:(UIImage *)image {
    CGFloat width = CGRectGetWidth(self.textView.frame) - (self.textView.textContainerInset.left + self.textView.textContainerInset.right + 12.f);
    NSTextAttachment *textAttachment = [NSTextAttachment attachmentWithImage:image width:width];
    NSAttributedString *attachmentString = [NSAttributedString attributedStringWithAttachment:textAttachment];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"\n"];
    [attributedString insertAttributedString:attachmentString atIndex:0];
    if (_lastSelectedRange.location != 0 &&
        ![[self.textView.text substringWithRange:NSMakeRange(_lastSelectedRange.location - 1, 1)] isEqualToString:@"\n"]) {
        [attributedString insertAttributedString:[[NSAttributedString alloc] initWithString:@"\n"] atIndex:0];
    }
    [attributedString addAttributes:self.textView.typingAttributes range:NSMakeRange(0, attributedString.length)];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setParagraphStyle:[NSParagraphStyle defaultParagraphStyle]];
    paragraphStyle.paragraphSpacingBefore = 8.f;
    paragraphStyle.paragraphSpacing = 8.f;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attributedString.length)];
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithAttributedString:self.textView.attributedText];
    [attributedText replaceCharactersInRange:_lastSelectedRange withAttributedString:attributedString];
    self.textView.allowsEditingTextAttributes = YES;
    self.textView.attributedText = attributedText;
    self.textView.allowsEditingTextAttributes = NO;
    [self.textView resignFirstResponder];
    [self.textView scrollRangeToVisible:_lastSelectedRange];
    return textAttachment;
}
#pragma mark - <PGStyleSettingsControllerDelegate>
- (void)lm_didChangedTextStyle:(PGTextStyle *)textStyle {
    self.currentTextStyle = textStyle;
    [self PG_updateTextStyleTypingAttributes];
    [self PG_updateTextStyleForSelection];
}
- (void)lm_didChangedParagraphIndentLevel:(NSInteger)level {
    self.currentParagraphConfig.indentLevel += level;
    NSRange selectedRange = self.textView.selectedRange;
    NSArray *ranges = [self PG_rangesOfParagraphForCurrentSelection];
    if (ranges.count <= 1) {
        [self PG_updateParagraphForSelectionWithKey:LMParagraphIndentName];
    }
    else {
        self.textView.allowsEditingTextAttributes = YES;
        NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithAttributedString:self.textView.attributedText];
        for (NSValue *rangeValue in ranges) {
            NSRange range = rangeValue.rangeValue;
            self.textView.selectedRange = range;
            PGParagraphConfig *paragraphConfig = [self PG_paragraphForSelection];
            paragraphConfig.indentLevel += level;
            [attributedText addAttribute:NSParagraphStyleAttributeName value:paragraphConfig.paragraphStyle range:range];
        }
        self.textView.attributedText = attributedText;
        self.textView.allowsEditingTextAttributes = NO;
        self.textView.selectedRange = selectedRange;
    }
    [self PG_updateParagraphTypingAttributes];
}
- (void)lm_didChangedParagraphType:(NSInteger)type {
}
#pragma mark - <PGImageSettingsControllerDelegate>
- (void)lm_imageSettingsController:(PGImageSettingsController *)viewController presentPreview:(UIViewController *)previewController {
    [self presentViewController:previewController animated:YES completion:nil];
}
- (void)lm_imageSettingsController:(PGImageSettingsController *)viewController insertImage:(UIImage *)image {
    float actualWidth = image.size.width * image.scale;
    float boundsWidth = CGRectGetWidth(self.view.bounds) - 8.f * 2;
    float compressionQuality = boundsWidth / actualWidth;
    if (compressionQuality > 1) {
        compressionQuality = 1;
    }
    NSData *degradedImageData = UIImageJPEGRepresentation(image, compressionQuality);
    UIImage *degradedImage = [UIImage imageWithData:degradedImageData];
    NSTextAttachment *attachment = [self PG_insertImage:degradedImage];
    [self.textView resignFirstResponder];
    [self.textView scrollRangeToVisible:_lastSelectedRange];
    NSString *urlStr = [NSString stringWithFormat:@"%@/OAuth/UploadFile",zhundaoH5Api];
    MBProgressHUD *hud1 = [PGMyHud initWithAnimationType:MBProgressHUDAnimationFade showAnimated:YES UIView:self.view];
    PGNetWorkManager.shareHTTPSessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                         @"text/html",
                                                         @"image/jpeg",
                                                         @"image/png",
                                                         @"application/octet-stream",
                                                         @"text/json",
                                                         nil];
    [ZD_NetWorkM postDataWithMethod:urlStr parameters:nil constructing:^(id<AFMultipartFormData> formData) {
        if (image) {
            NSData *data = UIImageJPEGRepresentation(image, 0.8);
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat =@"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
            [formData appendPartWithFileData:data name:@"imgFile" fileName:fileName mimeType:@"image/jpeg"];
        }
    } succ:^(NSDictionary *obj) {
        NSLog(@"responseObject = %@",obj);
        [hud1 hideAnimated:YES];
        MBProgressHUD *hud = [PGMyHud initWithMode:MBProgressHUDModeCustomView labelText:@"添加成功" showAnimated:YES UIView:self.view imageName:@"img_public_signin_check"];
        [hud hideAnimated:YES afterDelay:1];
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:obj];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSURL *filePath = [NSURL URLWithString:dic[@"url"]];
            attachment.attachmentType = LMTextAttachmentTypeImage;
            attachment.userInfo = filePath.absoluteString;
        });
    } fail:^(NSError *error) {
        [hud1 hideAnimated:YES];
    }];
}
- (void)lm_imageSettingsController:(PGImageSettingsController *)viewController presentImagePickerView:(UIViewController *)picker {
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark - export
- (NSString *)exportHTML {
    NSString *title = [NSString stringWithFormat:@"<h3 align=\"center\">%@</h3>", self.textView.titleTextField.text];
    NSString *content = [PGTextHTMLParser HTMLFromAttributedString:self.textView.attributedText WithImageArray:self.imageArray];
    return [title stringByAppendingString:content];
}

@end
