//
//  ViewController.h
//  FDPictureInPicture
//
//  Created by fd-macmini on 2020/10/9.
//

#import <UIKit/UIKit.h>
#import <AVKit/AVKit.h>
#import "ZFPlayer.h"
#import "ZFAVPlayerManager.h"
#import "ZFPlayerControlView.h"

@interface ViewController : UIViewController
@property (nonatomic, strong) AVPictureInPictureController *pipController;

@end

extern ViewController *vc;

