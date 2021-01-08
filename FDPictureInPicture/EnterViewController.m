//
//  EnterViewController.m
//  FDPictureInPicture
//
//  Created by lichenkang on 2021/1/5.
//

#import "EnterViewController.h"
#import "ViewController.h"

@interface EnterViewController ()

@end

@implementation EnterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)setupUI {
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [UILabel new];
    label.text = @"我是首页";
    label.textColor = [UIColor purpleColor];
    label.font = [UIFont systemFontOfSize:20];
    label.frame = CGRectMake(250, 150, 100, 50);
    [self.view addSubview:label];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(250, 300, 100, 50)];
    btn.backgroundColor = [UIColor yellowColor];
    [btn setTitle:@"进入播放页" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor systemPinkColor] forState:UIControlStateNormal];
    btn.titleLabel.textColor = [UIColor blueColor];
    [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(250, 365, 100, 50)];
    closeBtn.backgroundColor = [UIColor yellowColor];
    [closeBtn setTitle:@"关闭画中画" forState:UIControlStateNormal];
    [closeBtn setTitleColor:[UIColor systemPinkColor] forState:UIControlStateNormal];
    closeBtn.titleLabel.textColor = [UIColor blueColor];
    [closeBtn addTarget:self action:@selector(closeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeBtn];
}


- (void)btnClicked:(id)sender {
    if (vc) {
        vc.modalPresentationStyle = UIModalPresentationFullScreen;
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        ViewController *vc = [ViewController new];
        vc.modalPresentationStyle = UIModalPresentationFullScreen;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)closeBtnClicked:(id)sender {
    if (vc) {
        vc.pipController = nil;
        [vc.pipController stopPictureInPicture];
    }
}


@end
