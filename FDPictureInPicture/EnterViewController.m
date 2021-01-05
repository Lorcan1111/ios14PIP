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
    [btn setTitle:@"我是按钮" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor systemPinkColor] forState:UIControlStateNormal];
    btn.titleLabel.textColor = [UIColor blueColor];
    [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}


- (void)btnClicked:(id)sender {
    ViewController *vc = [ViewController new];
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self.navigationController pushViewController:vc animated:YES];
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
