//
//  ViewController.m
//  FDPictureInPicture
//
//  Created by fd-macmini on 2020/10/9.
//

#import "ViewController.h"
ViewController *vc = nil;
@interface ViewController ()<AVPictureInPictureControllerDelegate>

@property (nonatomic, strong) ZFPlayerController *player;
@property (nonatomic, strong) ZFPlayerControlView *controlView;
@property (nonatomic, strong) NSString *playUrlString, *coverUrlString;
@property (nonatomic, strong) UIButton *pipBtn;   ///< 画中画按钮
@property (nonatomic, strong) UINavigationController *navi;
@property (nonatomic, assign) BOOL pipDidRestore;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.pipBtn];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"进击的巨人04" ofType:@"mp4"];
    _playUrlString = path;
    //_playUrlString = @"http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4";
    ZFAVPlayerManager *playerManager = [[ZFAVPlayerManager alloc] init];
    self.player = [ZFPlayerController playerWithPlayerManager:playerManager containerView:self.view];
    self.player.controlView = self.controlView;
    self.player.assetURL = [NSURL fileURLWithPath:_playUrlString];
    self.navi = self.navigationController;
    #warning 在此处添加AVPictureInPictureController会有问题：正在播放视频时，APP进入后台后画中画会自动弹出
//    if ([AVPictureInPictureController isPictureInPictureSupported]) {
//        self.pipController = [[AVPictureInPictureController alloc] initWithPlayerLayer:playerManager.playerLayer];
//        self.pipController.delegate = self;
//    }
    [self.view bringSubviewToFront:self.pipBtn];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (vc != nil) {
        [vc.pipController stopPictureInPicture];
        vc = nil;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

#pragma mark ------- 画中画代理，和画中画状态有关的逻辑 在代理中处理
// 将开启画中画
- (void)pictureInPictureControllerWillStartPictureInPicture:(AVPictureInPictureController *)pictureInPictureController {
    // 处理 pipBtn 的选中状态、储存当前控制器
    vc = self;
    [self.navigationController popViewControllerAnimated:YES];
}

// 将关闭画中画
- (void)pictureInPictureControllerWillStopPictureInPicture:(AVPictureInPictureController *)pictureInPictureController {
    //
}

// 已经关闭画中画
- (void)pictureInPictureControllerDidStopPictureInPicture:(AVPictureInPictureController *)pictureInPictureController {
    // 处理 pipBtn 的选中状态、当前控制器置空
    if (!self.pipDidRestore) {
        //do close action
    }
    vc = nil;
}

// 点击视频悬浮窗的复原按钮打开控制器
- (void)pictureInPictureController:(AVPictureInPictureController *)pictureInPictureController restoreUserInterfaceForPictureInPictureStopWithCompletionHandler:(void (^)(BOOL))completionHandler {
    // 处理控制器的跳转等
    self.pipDidRestore = YES;
    if (![vc.navi.viewControllers containsObject:self]) {
        [vc.navi pushViewController:vc animated:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            completionHandler(YES);
        });
        return;
    }
    completionHandler(YES);
}

- (void)clickPipBtn:(UIButton *)sender {
    if ([AVPictureInPictureController isPictureInPictureSupported]) {
        if (self.pipController.isPictureInPictureActive) {
            [self.pipController stopPictureInPicture];
            sender.selected = NO;
        } else {
            ZFAVPlayerManager *playerManager = (ZFAVPlayerManager *)self.player.currentPlayerManager;
            self.pipController = [[AVPictureInPictureController alloc] initWithPlayerLayer:playerManager.playerLayer];
            self.pipController.requiresLinearPlayback = NO;
            self.pipController.delegate = self;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.pipController startPictureInPicture];
            });
            sender.selected = YES;
        }
    }
}

- (ZFPlayerControlView *)controlView {
    if (!_controlView) {
        _controlView = [ZFPlayerControlView new];
        _controlView.fastViewAnimated = YES;
        _controlView.autoHiddenTimeInterval = 5;
        _controlView.autoFadeTimeInterval = 0.5;
        _controlView.prepareShowLoading = YES;
        _controlView.prepareShowControlView = YES;
    }
    return _controlView;
}

- (UIButton *)pipBtn {
    if (!_pipBtn) {
        if (@available(iOS 14.0, *)) {
            UIImage *openImage = AVPictureInPictureController.pictureInPictureButtonStartImage;
            UIGraphicsBeginImageContextWithOptions(openImage.size, false, 0);
            [UIColor.blueColor setFill];
            UIRectFill(CGRectMake(0, 0, openImage.size.width, openImage.size.height));
            [openImage drawInRect:CGRectMake(0, 0, openImage.size.width, openImage.size.height) blendMode:kCGBlendModeDestinationIn alpha:1];
            openImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            openImage = [openImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

            UIImage *closeImage = AVPictureInPictureController.pictureInPictureButtonStopImage;
            UIGraphicsBeginImageContextWithOptions(closeImage.size, false, 0);
            [UIColor.blueColor setFill];
            UIRectFill(CGRectMake(0, 0, closeImage.size.width, closeImage.size.height));
            [closeImage drawInRect:CGRectMake(0, 0, closeImage.size.width, closeImage.size.height) blendMode:kCGBlendModeDestinationIn alpha:1];
            closeImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            closeImage = [closeImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

            _pipBtn = [[UIButton alloc] init];
            _pipBtn.frame = CGRectMake(10, 164, 20, 20);
            [_pipBtn setImage:openImage forState:UIControlStateNormal];
            [_pipBtn setImage:closeImage forState:UIControlStateSelected];
            [_pipBtn addTarget:self action:@selector(clickPipBtn:) forControlEvents:UIControlEventTouchUpInside];
        } else {
        }
    }
    return _pipBtn;
}
@end
